# Instruções Básicas de Instalação e Execução

Este diretório contém os códigos-fonte em R e os arquivos de projeto do Cytoscape referentes à análise de redes de coexpressão gênica para o projeto de progressão do câncer de próstata.

## Pré-requisitos

* **R (versão >= 4.0.0):** Necessário para a execução dos scripts de análise diferencial.
* **Bibliotecas R:** 
  * `DESeq2` (via Bioconductor)
  * `ggplot2`
  * `limma`
* **Cytoscape (versão >= 3.8.0):** Necessário para a visualização das redes (`.cys`).
* **string** Plataforma na internet (https://string-db.org).
* **Orange (versão >= 3.30):** Para a execução do workflow de processamento inicial dos dados de counts (`.ows`).

## Execução

1. **Pré-processamento no Orange:**
   Abra o arquivo `Prostate cancer dovolopment.ows` (localizado em `../pipelines/workflows/`) utilizando o Orange. Este fluxo fará a junção e formatação inicial dos counts de cada amostra a partir das bases brutas para gerar a matriz de entrada do R.

2. **Análise de Expressão Diferencial no R:**
   Execute o script `differential_expression_analysis_prostate.R` passando a matriz extraída do passo anterior. Este script utiliza `DESeq2` para formar as 6 condições de comparação (Câncer x Não Câncer, Metastático x Não Metastático, etc.) e extrai os genes diferencialmente expressos com base em um limite de `|Log2FC| > 1.5` e `p-value adj < 0.01`.

3. **Geração das Redes e Análise no Cytoscape:**
   Após a extração dos genes diferencialmente expressos, as redes são construídas utilizando a base de dados STRING (confidence cutoff: 0.75). Você pode abrir os projetos Cytoscape incluídos nesta pasta para visualizar e explorar interativamente as topologias de rede criadas:
   * `All_Networks.cys`
   * `All_Networks_ImportantGenes.cys`
   * `Prostate_Cancer_Progression_Multiplex.cys`
