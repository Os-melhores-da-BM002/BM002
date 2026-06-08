# Projeto `Assinatura de Progressão no Câncer de Próstata via Ciência de Redes`
# Project `Prostate Cancer Progression Signature via Network Science`

# Descrição Resumida do Projeto

O câncer de próstata (CdP) apresenta um comportamento biológico complexo, onde a transição de um estado indolente para uma forma maligna agressiva é acompanhada por mudanças drásticas no perfil de expressão gênica. O objetivo deste projeto é investigar a progressão da malignidade do CdP através da alteração na topologia das redes de interação de mRNAs. A estratégia central foca na combinação de múltiplos datasets transcriptômicos para mapear a evolução da doença em estágios críticos, desde o tumor primário até o estado metastático insensível a andrógenos. Para isso, os dados foram normalizados e submetidos a análise diferencial de expressão utilizando bibliotecas do R, seguido por extração de redes através da base STRING, possibilitando a descoberta de genes hub para cada transição fenotípica crítica.

# Slides

[Apresentação em pdf](./assets/slides/slides.pdf)

# Fundamentação Teórica

O projeto fundamenta-se na identificação de marcas funcionais do câncer e nos mecanismos moleculares de resistência que permitem a progressão da doença.

* **Artigos Base:**
    * **HANAHAN, Douglas (2026):** Fornece a base lógica das dimensões paramétricas e capacidades funcionais adquiridas que definem a doença durante a evolução adaptativa.
    * **ZHU, Y. et al. (2020):** Fundamenta a transição molecular para o estado de resistência à castração e a caracterização de modelos de progressão tumoral via variantes de receptor de andrógeno.

* **Problema:** Identificar como a rede de coexpressão gênica se reestrutura para conferir resistência a tratamentos hormonais e capacidade metastática, estabelecendo uma assinatura de progressão entre os diferentes estágios da doença.

# Perguntas de Pesquisa

1. Quais são os mRNAs centrais expressos em cada fase do tumor? 
2. É possível prever a progressão da malignidade do CdP? 
3. Existem grupos de genes que se mantêm estáveis ou desaparecem durante a progressão do câncer? 
4. É possível identificar um mecanismo de assinatura baseado na centralidade de nós para prever a progressão do CdP? 
5. Seria possível criar um mecanismo de identificação da possibilidade de aumento de malignidade do câncer com base em seu perfil de expressão?

Este projeto ajuda a responder a essas perguntas identificando clusters e hubs fundamentais de expressão diferenciada na transição do estado primário, até estados mais agressivos (metástase) ou insensíveis a hormônios. Ao aplicar a métrica de centralidade, descobrimos assinaturas de vias críticas, e não apenas elementos isolados do metabolismo celular, validando a viabilidade de uma predição topológica.

# Metodologia

A análise utiliza **Ciência de Redes** voltada ao estudo da **Análise de Centralidade** e extração de subredes para identificar genes chave da progressão. Realizamos o levantamento dos perfis através de abordagens de estatística de Bioinformática clássica e mapeamos interações validadas empiricamente.

O fluxo de processamento (pipeline) inclui:
1. **Orange**: Compilação de contagens brutas a partir de múltiplos Datasets com uniformização da identificação genética (`geneID`).
2. **R (DESeq2)**: Análises de Expressão Diferencial para 6 condições, usando as covariáveis da linhagem tumoral para identificar variações de expressão significativa (ajuste Bonferroni com p-Value < 0.01 e |Log2FC| > 1.5).
3. **Cytoscape (STRING app)**: Construção da rede em Cytoscape com limite de confiança > 0.75 para encontrar hubs com a maior pontuação de interações.

## Bases de Dados e Evolução

| Base de Dados | Endereço na Web | Resumo descritivo |
| :--- | :--- | :--- |
| **GSE148544** | [Link GEO](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE148544) | RNA-seq de linhagens celulares (como Du145) e tecidos normais para identificar expressão diferencial regulada pela via HIF-1α. |
| **GSE149433** | [Link GEO](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE149433) | Estudo em modelos PDX sobre o papel da variante AR-v7 na resistência a inibidores de sinalização de andrógenos (Abiraterona/Enzalutamida). |
| **GSE195659** | [Link GEO](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE195659) | Perfil de expressão em linhagens LNCaP para investigar o PRMT1 como regulador da sinalização do receptor de andrógeno. |
| **GSE131985** | [Link GEO](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE131985) | Transcriptomas de linhagens LNCaP95 com nocaute do receptor de andrógeno em condições de enriquecimento ou depleção hormonal. |
| **GSE210205** | [Link GEO](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE210205) | Comparação entre linhagem benigna (BPH-1) e cancerígenas (DU145/PC3) para construção de assinaturas de resposta inflamatória. |

**Descobertas base**: A extração bruta de `counts` dos GEOs necessitou forte tratamento da nomenclatura dos genes para unificar o estudo. Linhagens controle como a BPH foram comparadas contra linhagens agressivas, como PC3 e 22Rv1. Foram criadas classes com dezenas de amostras consolidadas para viabilizar as comparações estatísticas.

## Modelo Lógico

![Modelo Lógico de Grafos](assets/images/modelo_logico_entrega-2.png)

## Integração entre Bases

Os dados foram coletados em seus formatos brutos. Diferentes bancos de dados tinham diferentes tipos de `gene IDs` (símbolos de genes vs Entrez/Ensembl), sendo necessária uma etapa em que utilizamos o Orange e scripts de pré-processamento para fazer o alinhamento de IDs genéticos. Uma mesma amostra foi alinhada nas colunas e submetida à filtragem conjunta na etapa final no R para extração de logs comparáveis através do DESeq2.

## Análises Realizadas

No projeto propusemos comparar e contrastar 6 condições baseadas na progressão do câncer (ex: não câncer x câncer; metastático vs primário; sensível x insensível a andrógenos; e em escadas BPH -> 22Rv1 -> LNCap -> PC3). O cálculo dos diferenciais extraiu em média mais de 2 mil genes diferencialmente expressos (`DEGs`).

**Destaque em Redes**:
Visualizamos a rede geral que conecta todos os hubs por centralidade de grau. Adicionalmente, analisamos os clusters e os principais genes hub (`MMP2`, `MUC5AC`, etc.) em cada fase.

Destaque no R (Criação de objeto de expressão diferencial):
~~~R
dds <- DESeqDataSetFromMatrix(countData = countdata,
                              colData = coldata,
                              design = ~ condition_1)
dds <- DESeq(dds)
res <- results(dds)
~~~

## Evolução do Projeto

O projeto começou explorando arquivos suplementares já parcialmente processados (DEGs pré-computados pelas fontes). Contudo, a inconsistência estatística não permitia uma comparação inter-banco justa entre linhagens de estágios diferentes. Assim, reconstruímos o pipeline a partir dos dados brutos consolidados no Orange para junção tabular. Posteriormente, implementamos a análise matemática no pacote DESeq2 (R) para computar o p-value exato ajustado pelo método Bonferroni. Isso gerou uma consistência global na extração de subredes no Cytoscape, resultando numa mudança de rota crucial desde a primeira entrega.

# Ferramentas

- **Linguagem**: R (DESeq2, limma e ggplot2). Usado ativamente para análise diferencial devido à capacidade robusta de gerenciar *counts* e realizar testes logarítmicos complexos.
- **Data Mining**: Orange. Essencial para manipular e organizar visualmente o grande volume de tabelas brutas e juntar as métricas sob chaves de `GeneID` únicas.
- **Redes e Anotação**: Cytoscape + STRING App. Utilizado para buscar interações experimentais para cada subgrupo de genes extraídos, computando e exibindo a topologia (Confidence cutoff: 0.75).

# Resultados

Foram encontradas variações altamente significativas focadas tanto em características metabólicas intrínsecas ao tumor quanto funções de sinalização da matriz extracelular.

- **Câncer vs Não Câncer:** Identificou-se forte presença de metaloproteinases reguladas negativamente (como MMP2 e MMP9), o que indica um balanço alterado de remodelação de tecido no início da doença. Adicionalmente, a superexpressão de MUC5AC (mucina associada a tumores). 
- **Metastático vs Primário:** Revelaram-se modulações em hubs imunológicos e sinalizadores quimiotáxicos. Genes como `TLR4` e `CXCR4` se mostraram reprimidos, enquanto fatores de crescimento promotores da via fibrótica (`EGF`) e modulação neutrofílica (`CSF3`) mostraram-se ativos.
- **Depleção Androgênica vs Insensibilidade:** Verificou-se diminuição do citocromo C (CYCS) e do maquinário conjugador de ubiquitina (UBE2I), apontando a um mecanismo não canônico que burla os mecanismos tradicionais induzidos na resposta hormonal.

# Discussão

A topologia extraída evidenciou que não apenas genes conhecidos e já catalogados das vias de AR e próstata são alterados. Uma série de reguladores paralelos assumem altos graus de centralidade de rede em fases específicas, agindo como hubs primários para sustentar estados irreversíveis e metástases. Os Top 10 DEGs não relacionados diretamente ao metabolismo celular (como sinalização, adesão e imunidade) permitiram uma assinatura de progressão altamente discriminativa, corroborando a hipótese inicial e evidenciando a utilidade da bioinformática ligada a grafos para a evolução sistêmica de modelos da doença.

# Conclusão

Foi possível mapear com sucesso e reprodutibilidade as alterações na estrutura de redes de expressão à medida que a linhagem progredia da normalidade (BPH) até estados malignos severos. 
O principal desafio foi superar a alta carga heterogênea do uso massivo de transcriptomas experimentais brutos: a normalização entre linhagens distintas sob metodologias equivalentes abriu as portas para resultados com viés reduzido. Aprendeu-se a relevância das redes e as medidas de topologia como *degree*, unificando métricas moleculares com algoritmos computacionais para o entendimento do câncer sob a perspectiva sistêmica.

# Trabalhos Futuros

Havendo mais tempo para maturação do projeto, seria pertinente:
- Desenvolver ou aplicar modelos de regressão/Machine Learning sobre as características topológicas de rede para formalizar uma predição cega de amostras puras.
- Avaliar algoritmos baseados em detecção de comunidades (ex: Louvain, K-core) em conjunto com a centralidade para determinar complexos proteicos exatos, aplicando metodologias como GSEA nas *cliques* isoladas, no lugar de apenas avaliar o diferencial individual dos DEGs principais.

# Referências Bibliográficas

1. EVANS, T. S.; CHEN, B. Linking the network centrality measures closeness and degree. **Communications Physics**, v. 5, n. 172, 2022.
2. HANAHAN, Douglas. Hallmarks of cancer—Then and now, and beyond. **Cell**, v. 189, n. 3, p. S0092-8674(25)01498-9, 2026.
3. LUO, Y. et al. Development and validation of novel inflammatory response-related gene signature. **MBE**, v. 19, n. 11, p. 11345–11366, 2022.
4. TANG, S. et al. A genome-scale CRISPR screen reveals PRMT1 as a critical regulator of androgen receptor signaling in prostate cancer. **Cell Reports**, v. 38, n. 8, 2022.
5. ZHANG, Y. et al. CDCA2 Inhibits Apoptosis and Promotes Cell Proliferation in Prostate Cancer and Is Directly Regulated by HIF-1α Pathway. **Frontiers in Oncology**, v. 10, p. 725, 2020.
6. ZHU, Y. et al. Role of androgen receptor splice variant-7 (AR-V7) in prostate cancer resistance to 2nd-generation androgen receptor signaling inhibitors. **Oncogene**, v. 39, p. 6935–6949, 2020.
