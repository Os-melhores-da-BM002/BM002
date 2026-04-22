if (!require("BiocManager", quietly = TRUE)) {
  install.packages("BiocManager")
}

# Instala o DESeq2 e dependências de bioinformática
# Update=FALSE e Ask=FALSE agilizam o processo no Colab
BiocManager::install(c("DESeq2", "limma", "ggplot2"), update = FALSE, ask = FALSE)

# Carrega
library(DESeq2)
library(limma)
library(ggplot2)

counts <- read.delim("../../data/raw/GSE148544_raw_counts.csv", row.names = 1, sep = "\t")

ncol(counts)

colData <- data.frame(
      condition = factor(c("Metastatico",	"Metastatico",	"Metastatico",	"LNCap",	"22RV1",	"Metastatico",	"Metastatico",	"Prostate")), row.names = colnames(counts)
)

#Criar objeto DESeq2
dds <- DESeqDataSetFromMatrix(countData = counts,
                              colData = colData,
                              design = ~condition)

#Rodar a anáilise estatística (Normalização + Testes)
dds <- DESeq(dds)

#Extrar os resultados 
res <- results(dds, contrast = c("condition", "Metastatico", "Prostate"))
write.csv(as.data.frame(res), "../../data/processed/resultados_Metastatico_vs_Prost_cytoscape.csv")

table(colData$condition)