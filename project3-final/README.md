# Projeto `Assinatura de Progressão no Câncer de Próstata via Ciência de Redes`
# Project `Prostate Cancer Progression Signature via Network Science`

# Descrição Resumida do Projeto

> Descrição resumida do tema do projeto. Sugestão de roteiro (cada item tipicamente tratado em uma ou poucas frases):
>
> Contextualização do projeto
>
> Caracterização do problema
>
> Motivação
>
> Relevância
>
> Trabalhos relacionados
>
> Indicação (bastante resumida) da análise proposta
>
> Indicação (bastante resumida) dos resultados alcançados

O câncer de próstata (CdP) apresenta um comportamento biológico complexo, onde a transição de um estado indolente para uma forma maligna agressiva é acompanhada por mudanças drásticas no perfil de expressão gênica. O objetivo deste projeto é investigar a progressão da malignidade do CdP através da alteração na topologia das redes de interação de mRNAs. A estratégia central foca na combinação de múltiplos datasets transcriptômicos para mapear a evolução da doença em estágios críticos, desde o tumor primário até o estado metastático insensível a andrógenos. Para isso, os dados foram ubmetidos a análise diferencial de expressão utilizando bibliotecas do R, seguido por extração de redes através da base STRING, possibilitando a descoberta de genes hub entre cada transição de estágios.

# Slides

> Coloque aqui o link para o PDF da apresentação da parte 3.

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

Este projeto ajuda a responder a essas perguntas identificando clusters e hubs fundamentais de expressão diferenciada na transição do estado primário, até estados de metástase sensível ou não à andrógeno. 

# Metodologia

A análise utiliza ciência de redes voltada ao estudo por métricas de centralidade e extração de subredes para identificar genes chave da progressão. Realizamos o levantamento dos perfis através de abordagens estatísticas e mapeamos interações validadas empiricamente.

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

> Faça uma descrição sobre o que concluiu sobre esta base. Sugere-se que respondam perguntas ou forneçam informações indicadas a seguir:
> * O que descobriu sobre essa base?
> * Quais as transformações e tratamentos (e.g., dados faltantes e limpeza) feitos?

## Modelo Lógico

![Modelo Lógico de Grafos](assets/images/modelo_logico_entrega-3.png)

## Integração entre Bases

> Descreva se houve desafios de integração de fontes de dados e etapas para a mesma.

Os dados foram coletados em seus formatos brutos. Diferentes bancos de dados tinham diferentes tipos de `gene IDs` (símbolos de genes vs Entrez/Ensembl), sendo necessária uma etapa em que utilizamos o Orange e scripts de pré-processamento para fazer o alinhamento de IDs genéticos. Uma mesma amostra foi alinhada nas colunas e submetida à filtragem conjunta na etapa final no R para extração de logs comparáveis através do DESeq2.

## Análises Realizadas

> Apresente aqui uma análise dos dados.
> Utilize gráficos que descrevam os aspectos principais da base que são relevantes para as perguntas de pesquisa consideradas.
>
> Nesta seção ou na seção de Resultados podem aparecer destaques de código como indicado a seguir. Note que foi usada uma técnica de highlight de código, que envolve colocar o nome da linguagem na abertura de um trecho com `~~~`, tal como `~~~python`.
>
> Os destaques de código devem ser trechos pequenos de poucas linhas, que estejam diretamente ligados a alguma explicação. Não utilize trechos extensos de código. Se algum código funcionar online (tal como um Jupyter Notebook), aqui pode haver links. No caso do Jupyter, preferencialmente para o Binder abrindo diretamente o notebook em questão.

No projeto propusemos comparar e contrastar 6 condições baseadas na progressão do câncer (ex: não câncer x câncer; metastático vs primário; sensível x insensível a andrógenos; e em escadas BPH -> 22Rv1 -> LNCap -> PC3). O cálculo dos diferenciais extraiu em média mais de 2 mil genes diferencialmente expressos (`DEGs`).

Visualizamos a rede geral que conecta todos os hubs por centralidade de grau. Adicionalmente, analisamos os clusters e os principais genes hub em cada fase.

Para calcular a expressão diferencial, foi utilizada a biblioteca DESeq2 em R:
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
- **Pré-processamento**: Orange. Essencial para manipular e organizar visualmente o grande volume de tabelas brutas e juntar as métricas sob chaves de `GeneID` únicas.
- **Redes e Anotação**: Cytoscape + STRING App. Utilizado para buscar interações experimentais para cada subgrupo de genes extraídos, computando e exibindo a topologia (Confidence cutoff: 0.75).

# Resultados

> Esta pode ser uma seção independente ou combinada com a seção de Análises Realizadas.
>
> Descrição dos resultados mais importantes obtidos.
>
> Apresente os resultados da forma mais rica possível, com gráficos e tabelas. Mesmo que o seu código rode online em um notebook, copie para esta parte a figura estática. A referência a código e links para execução online pode ser feita aqui ou na seção de Análises Realizadas (o que for mais pertinente).

Foram encontradas variações altamente significativas focadas tanto em características metabólicas intrínsecas ao tumor quanto funções de sinalização da matriz extracelular.

- **BHP 1 vs. 22Rv1:**
- **22Rv1 vs. LNCap:**
- **LNCap vs. PC3:**
- **Câncer vs Não Câncer:** 
- **Metastático vs Primário:**
- **Depleção Androgênica vs Insensibilidade:**

# Discussão

> Discussão dos resultados. Relacionar os resultados com as perguntas de pesquisa ou hipóteses avaliadas.
>
> A discussão dos resultados também pode ser feita opcionalmente na seção de Resultados, na medida em que os resultados são apresentados. Aspectos importantes a serem discutidos: Por que seu modelo alcançou (ou não) um bom resultado? É possível tirar conclusões dos resultados? Quais? Há indicações de direções para estudo? São necessários trabalhos mais profundos?

# Conclusão

> Destacar as principais conclusões obtidas no desenvolvimento do projeto.
>
> Destacar os principais desafios enfrentados.
>
> Principais lições aprendidas.

# Trabalhos Futuros

> O que poderia ser melhorado se houvesse mais tempo?
> Quais possíveis desdobramentos este projeto pode ter?

Havendo mais tempo para maturação do projeto, seria pertinente:
- Desenvolver ou aplicar modelos de Graph Neural Network sobre as características topológicas de rede.
- Avaliar algoritmos baseados em detecção de comunidades (ex: Louvain, K-core) em conjunto com a centralidade para determinar complexos proteicos exatos.

# Referências Bibliográficas

1. EVANS, T. S.; CHEN, B. Linking the network centrality measures closeness and degree. **Communications Physics**, v. 5, n. 172, 2022. DOI: [10.1038/s42005-022-00949-5](https://doi.org/10.1038/s42005-022-00949-5).

2. HANAHAN, Douglas. Hallmarks of cancer—Then and now, and beyond. **Cell**, v. 189, n. 3, p. S0092-8674(25)01498-9, 2026. DOI: [10.1016/j.cell.2025.12.049](https://doi.org/10.1016/j.cell.2025.12.049).

3. LUO, Y.; LIU, X.; LIN, J.; ZHONG, W.; CHEN, Q. Development and validation of novel inflammatory response-related gene signature to predict prostate cancer recurrence and response to immune checkpoint therapy. **Mathematical Biosciences and Engineering (MBE)**, v. 19, n. 11, p. 11345–11366, 2022. DOI: [10.3934/mbe.2022528](https://doi.org/10.3934/mbe.2022528).

4. National Center for Biotechnology Information (NCBI). **Gene Expression Omnibus (GEO)**. Disponível em: [https://www.ncbi.nlm.nih.gov/geo/](https://www.ncbi.nlm.nih.gov/geo/).

5. TANG, S. et al. A genome-scale CRISPR screen reveals PRMT1 as a critical regulator of androgen receptor signaling in prostate cancer. **Cell Reports**, v. 38, n. 8, 2022. DOI: [10.1016/j.celrep.2022.110417](https://doi.org/10.1016/j.celrep.2022.110417).
