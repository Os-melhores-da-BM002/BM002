# Instalar o BiocManager para baixar as demais bibliotecas (Descomente se precisar)
# install.packages("BiocManager")

# Instalar as bibliotecas para análise diferencial (Descomente se precisar)
# BiocManager::install('DESeq2')
# BiocManager::install('apeglm')

library(DESeq2)
library(apeglm)

# Colocar no countdata (pode ser chamado de countData) a tabela com os valores absolutos dos counts achados pelo RNAseq
countdata <- read.csv("Final_table.csv", row.names = 1)

# Fazer uma tabela com ascondições para cada uma das variáveis escolhidas (ex: cancer, normal; tratado, não tratado)
coldata <- read.csv("condition.csv", row.names = 1, header = T)

# Converter o countdata em matriz (isso é exigido pelo pacote DESeq2)
countdata <- as.matrix(countdata)

# Faça o seguinte comando para garantir que os seus dados estão em número inteiros
storage.mode(countdata) <- "integer"

# Verifique se os valores de colunas e de linhas são compatíveis 
# Se for FALSE, alinha o countdata às linhas do coldata
if(!all(rownames(coldata) == colnames(countdata))){
  countdata <- countdata[, rownames(coldata)]
}

coldata <- coldata[!is.na(coldata$condition_4), ]

## ANÁLISE DIFERENCIAL EM SI

# Normal vs Cancer
coldata$condition_1 <- factor(coldata$condition_1, levels = c("Normal", "Cancer"))
dds1 <- DESeqDataSetFromMatrix(countData = countdata, colData = coldata, design = ~ condition_1)
dds1 <- DESeq(dds1)

res1 <- results(dds1, contrast = c("condition_1","Cancer","Normal"))
resLFC1 <- lfcShrink(dds1, coef = 2, type = "apeglm")
write.csv(as.data.frame(res1), file = "resultados_Normal_vs_Cancer.csv")

# Mestastatico vs Não mestastático
coldata$condition_2 <- factor(coldata$condition_2, levels = c("No_meta", "meta"))
dds2 <- DESeqDataSetFromMatrix(countData = countdata, colData = coldata, design = ~ condition_2)
dds2 <- DESeq(dds2)

res2 <- results(dds2, contrast = c("condition_2","meta","No_meta"))
resLFC2 <- lfcShrink(dds2, coef = 2, type = "apeglm")
write.csv(as.data.frame(res2), file = "resultados_nao_metastatico_vs_metastatico.csv")

# Dependente de andrógeno vs Não dependente de andrógenos
coldata$condition_3 <- factor(coldata$condition_3, levels = c("dep_andro", "indep_andro"))
dds3 <- DESeqDataSetFromMatrix(countData = countdata, colData = coldata, design = ~ condition_3)
dds3 <- DESeq(dds3)

res3 <- results(dds3, contrast = c("condition_3","indep_andro","dep_andro"))
resLFC3 <- lfcShrink(dds3, coef = 2, type = "apeglm")
write.csv(as.data.frame(res3), file = "resultados_Dependente_de_androgeno_vs_Independente_de_androgeno.csv")


# Comparativos do condition_4 (BPH1, c22Rv1, LNCaP, PC3)
# Inicializamos e rodamos o DESeq apenas UMA vez para este design, trocando apenas o "contrast" para gerar tabelas.
coldata <- read.csv("condition.csv", row.names = 1, header = T)
coldata$condition_4 <- factor(coldata$condition_4, levels = c("BPH1", "c22Rv1","LNCaP","PC3"))

dds4 <- DESeqDataSetFromMatrix(countData = countdata, colData = coldata, design = ~ condition_4)
dds4 <- DESeq(dds4)

# BPH1 vs 22Rv1
res4_1 <- results(dds4, contrast = c("condition_4","c22Rv1","BPH1"))
write.csv(as.data.frame(res4_1), file = "resultados_BPH_vs_22Rv1.csv")

# BPH1 vs LNCap
res4_2 <- results(dds4, contrast = c("condition_4","LNCaP","BPH1"))
write.csv(as.data.frame(res4_2), file = "resultados_BPH_vs_LNCap.csv")

# BPH1 vs PC3
res4_3 <- results(dds4, contrast = c("condition_4","PC3","BPH1"))
write.csv(as.data.frame(res4_3), file = "resultados_BPH_vs_PC3.csv")

# 22Rv1 vs LNCap
res4_4 <- results(dds4, contrast = c("condition_4","LNCaP","c22Rv1"))
write.csv(as.data.frame(res4_4), file = "resultados_22Rv1_vs_LNCap.csv")

# 22Rv1 vs PC3
res4_5 <- results(dds4, contrast = c("condition_4","PC3","c22Rv1"))
write.csv(as.data.frame(res4_5), file = "resultados_22Rv1_vs_PC3.csv")

# LNCap vs PC3
res4_6 <- results(dds4, contrast = c("condition_4","PC3","LNCaP"))
write.csv(as.data.frame(res4_6), file = "resultados_LNCap_vs_PC3.csv")