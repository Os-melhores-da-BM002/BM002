library(dplyr)
library(ggplot2)
library(readr)
library(stringr)
library(purrr)

diretorio <- "../../data/processed/largest_subnetworks_nodes_edges"
arquivos_nodes <- list.files(path = diretorio, 
                             pattern = "^node_.*\\.csv$", 
                             full.names = TRUE)

# Função para calcular a Entropia de Shannon da distribuição de graus
calcular_entropia <- function(graus) {
  graus <- na.omit(graus)
  probabilidades <- table(graus) / length(graus)
  entropia <- -sum(probabilidades * log2(probabilidades))
  return(entropia)
}

# Função principal para processar cada rede
processar_rede <- function(caminho_arquivo) {
  nome_rede <- basename(caminho_arquivo) %>% 
    str_remove("^node_") %>% 
    str_remove("\\.csv$")
  
  df <- read.csv(caminho_arquivo)
  
  # Trava de segurança e normalização
  if (!"Betweenness_norm" %in% colnames(df)) {
    if ("BetweennessCentrality" %in% colnames(df)) {
      max_bc <- max(df$BetweennessCentrality, na.rm = TRUE)
      df$Betweenness_norm <- if (max_bc > 0) df$BetweennessCentrality / max_bc else 0
    } else {
      stop(sprintf("Erro crítico: Nem 'Betweenness_norm' nem 'BetweennessCentrality' encontradas em '%s'.", nome_rede))
    }
  }
  
  if (!"Score_Importancia" %in% colnames(df)) {
    df$Score_Importancia <- 0
  }
  
  # Métricas globais da rede
  arquivo_edges <- file.path(
    dirname(caminho_arquivo),
    paste0("edge_", nome_rede, ".csv")
  )
  
  edges_raw <- read.csv(arquivo_edges)
  
  edges <- edges_raw %>%
    mutate(
      source = sub(" \\(pp\\).*", "", name),
      target = sub(".*\\(pp\\) ", "", name)
    ) %>%
    select(source, target)
  
  g <- graph_from_data_frame(
    edges,
    directed = FALSE
  )
  
  network_density <- edge_density(g)
  
  average_path_length <- mean_distance(
    g,
    directed = FALSE,
    unconnected = TRUE
  )
  
  global_clustering_coefficient <- transitivity(
    g,
    type = "global"
  )
  
  degree_assortativity <- assortativity_degree(
    g,
    directed = FALSE
  )
  
  # Cálculos de redundância e entropia
  df <- df %>%
    mutate(
      Clustering_adj = ifelse(ClusteringCoefficient == 0, 1e-6, ClusteringCoefficient),
      Score_Redundancia = Betweenness_norm / Clustering_adj
    )
  
  entropia_rede <- calcular_entropia(df$Degree)
  
  # Visualização
  grafico <- ggplot(df, aes(x = abs(log2FoldChange), y = Score_Importancia)) +
    geom_point(alpha = 0.5, color = "#2c3e50", size = 2) +
    geom_smooth(method = "lm", color = "#e74c3c", se = FALSE, linetype = "dashed") +
    theme_minimal() +
    labs(
      title = paste("Relação Expressão vs Centralidade:", nome_rede),
      subtitle = paste("Entropia Estrutural da Rede:", round(entropia_rede, 4)),
      x = expression("|" * log[2] * "(Fold Change)" * "|"),
      y = "Score de Importância"
    ) +
    theme(
      plot.title = element_text(face = "bold", size = 14),
      plot.subtitle = element_text(color = "darkgray", size = 11)
    )
  
  return(list(
    nome = nome_rede,
    dados = df,
    entropia = entropia_rede,
    network_density = network_density,
    average_path_length = average_path_length,
    global_clustering_coefficient = global_clustering_coefficient,
    degree_assortativity = degree_assortativity,
    plot = grafico
  ))
}

# Executar o processamento para todos os arquivos
resultados_redes <- map(arquivos_nodes, processar_rede)
names(resultados_redes) <- map_chr(resultados_redes, "nome")

# Configuração do diretório de saída
metrics_dir <- "../../data/processed/metrics_analisys"
if (!dir.exists(metrics_dir)) {
  dir.create(metrics_dir, recursive = TRUE)
}

metricas_alvo <- c("Degree", "Eigenvector", "ClosenessCentrality", 
                   "BetweennessCentrality", "Eccentricity", "Score_Importancia")

# Função para extrair Top 10 de cada métrica
extrair_top10 <- function(resultados_redes) {
  map(resultados_redes, function(net_list) {
    df <- net_list$dados
    nome <- net_list$nome
    
    tops <- list()
    
    tops$log2FC_Pos <- df %>% 
      arrange(desc(log2FoldChange)) %>% 
      head(10) %>% 
      select("display.name", log2FoldChange)
    
    tops$log2FC_Neg <- df %>% 
      arrange(log2FoldChange) %>% 
      head(10) %>% 
      select("display.name", log2FoldChange)
    
    for(metrica in metricas_alvo) {
      if(metrica %in% colnames(df)) {
        tops[[metrica]] <- df %>% 
          arrange(desc(!!sym(metrica))) %>% 
          head(10) %>% 
          select("display.name", !!sym(metrica))
      }
    }
    
    arquivo_saida <- file.path(metrics_dir, paste0("Top10_", nome, ".csv"))
    write_csv(bind_rows(tops, .id = "Metrica"), arquivo_saida)
  })
}

# Executar a extração
extrair_top10(resultados_redes)

# Salvar as métricas globais em um único arquivo
df_metricas_globais <- data.frame(
  Rede = names(resultados_redes),
  Entropia = map_dbl(resultados_redes, "entropia"),
  Network_Density = map_dbl(resultados_redes, "network_density"),
  Average_Path_Length = map_dbl(resultados_redes, "average_path_length"),
  Global_Clustering_Coefficient = map_dbl(resultados_redes, "global_clustering_coefficient"),
  Degree_Assortativity = map_dbl(resultados_redes, "degree_assortativity")
)

write_csv(
  df_metricas_globais,
  file.path(metrics_dir, "Resumo_Metricas_Globais.csv")
)
