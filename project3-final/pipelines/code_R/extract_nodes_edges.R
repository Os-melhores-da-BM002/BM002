# Script para extrair as redes "Largest Subnetwork" de um arquivo .cys
# e salvar os dados de 'node' (nós) e 'edge' (arestas) para cada uma delas.
#
# Pré-requisitos: 
# 1. Cytoscape deve estar aberto.
# 2. Pacote RCy3 instalado: BiocManager::install("RCy3")

BiocManager::install("RCy3")

library(RCy3)

# Define o caminho do arquivo .cys
cys_file_path <- normalizePath("../workflows/cytoscape/All_Networks_ImportantGenes.cys")

# Checa conexão com o Cytoscape
tryCatch({
  cytoscapePing()
  message("Conectado ao Cytoscape com sucesso.")
}, error = function(e) {
  stop("Erro de conexão. Certifique-se de que o Cytoscape está aberto e rodando.")
})

# Abre a sessão no Cytoscape
message("Abrindo o arquivo: ", cys_file_path)
openSession(cys_file_path)

# Aguarda um tempo para a sessão ser carregada completamente pelo Cytoscape
message("Aguardando o carregamento completo da sessão...")
Sys.sleep(10) # Pausa de 10 segundos (aumente se o arquivo for muito grande)

# Tenta obter a lista de redes com algumas tentativas (retry)
all_nets <- NULL
max_retries <- 3
for (i in 1:max_retries) {
  try({
    all_nets <- getNetworkList()
    if (length(all_nets) > 0) break # Sai do loop se conseguiu pegar as redes
  }, silent = TRUE)
  
  message(sprintf("Tentativa %d de obter redes falhou ou vazia. Tentando novamente em 5 segundos...", i))
  Sys.sleep(5)
}

if (is.null(all_nets)) {
  stop("Erro: Não foi possível obter a lista de redes do Cytoscape após múltiplas tentativas. Verifique se o arquivo abriu corretamente no Cytoscape.")
}

# Filtra apenas as redes que têm "Largest Subnetwork" no nome
target_networks <- grep("Largest Subnetwork", all_nets, value = TRUE, ignore.case = TRUE)

if (length(target_networks) == 0) {
  message("Nenhuma rede contendo 'Largest Subnetwork' foi encontrada na sessão.")
  message("Redes presentes: ", paste(all_nets, collapse = ", "))
} else {
  # Define o diretório de saída
  out_dir <- "../../data/processed/largest_subnetworks_nodes_edges"
  if (!dir.exists(out_dir)) {
    dir.create(out_dir, recursive = TRUE)
  }
  
  for (net_name in target_networks) {
    message("\nProcessando: ", net_name)
    
    # Define a rede atual no Cytoscape
    setCurrentNetwork(network = net_name)
    
    # Formata o nome para ser seguro como nome de arquivo
    file_prefix <- gsub("[^A-Za-z0-9_.-]", "_", net_name)
    
    # --- 1. Extração e salvamento de NODE (Nós) ---
    node_data <- getTableColumns(table = "node", network = net_name)
    node_csv_path <- file.path(out_dir, paste0("node_", file_prefix, ".csv"))
    write.csv(node_data, file = node_csv_path, row.names = FALSE)
    message("  -> Arquivo de nós (node) salvo em: ", node_csv_path)
    
    # --- 2. Extração e salvamento de EDGE (Arestas) ---
    edge_data <- getTableColumns(table = "edge", network = net_name)
    edge_csv_path <- file.path(out_dir, paste0("edge_", file_prefix, ".csv"))
    write.csv(edge_data, file = edge_csv_path, row.names = FALSE)
    message("  -> Arquivo de arestas (edge) salvo em: ", edge_csv_path)
  }
  
  message("\nProcessamento concluído com sucesso! Arquivos gerados em: ", out_dir)
}
