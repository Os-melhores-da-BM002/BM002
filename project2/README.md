# P2 - Template da Segunda Entrega
*2026.1 Ciência e Visualização de Dados em Saúde*

# Estrutura de sua pasta de projeto

A fim de uniformizar os repositórios de projetos da disciplina, os diretórios de seu repositório deverão ser nomeados conforme segue.

A estrutura aqui apresentada é uma simplificação daquela proposta pelo [Cookiecutter Data Science](https://drivendata.github.io/cookiecutter-data-science/). Também será aceito que o projeto adote a estrutura completa do Cookiecutter Data Science e isso será considerado um diferencial. A estrutura geral é a seguinte e será detalhada a seguir:

~~~
...
│
└── project2
    |
    ├── README.md  <- texto da Entrega 2 do projeto
    │
    ├── data
    │   ├── external       <- dados de terceiros em formato usado para entrada na transformação
    │   ├── interim        <- dados intermediários, e.g., resultado de transformação
    │   ├── processed      <- dados finais usados para a publicação
    │   └── raw            <- dados originais sem modificações
    │
    ├── pipelines
    │   ├── notebooks      <- Jupyter notebooks ou equivalentes
    │   └── workflows      <- workflows Orange ou equivalentes 
    |
    ├── src                <- fonte em linguagem de programação ou sistema (e.g., Orange, Cytoscape)
    │   └── README.md      <- instruções básicas de instalação/execução
    │
    └── assets             <- mídias usadas no projeto
        ├── images  <- imagens usadas no texto do README.md
        └── slides  <- slides da prévia (em PDF)
~~~

Na raiz da pasta `project2` deve haver um arquivo de nome `README.md` contendo a apresentação do projeto, como detalhado na seção seguinte.

## `data`

Arquivos de dados usados no projeto, quando isso ocorrer.

## `pipelines`

Processos implementados no projeto que tenham sido executados em algum mecanismo de workflow, como o Orange, ou de notebook, como o Jupyter.

## `src`

Código implementado em alguma linguagem de programação, se houver, além dos workflows e notebooks.

Projeto na linguagem escolhida incluindo todos os arquivos de dados e bibliotecas necessários para a sua execução. Só coloque código Pyhton ou Java aqui se ele não rodar dentro do notebook.

Acrescente na raiz um arquivo `README.md` com as instruções básicas de instalação e execução.

## `assets`

Qualquer mídia usada no seu projeto: vídeo, imagens, animações, slides etc. Coloque os arquivos aqui (mesmo que você mantenha uma cópia no diretório do código).

## `README.md`

Segue abaixo o modelo de como deve ser apresentado e documentado o projeto. Há partes do modelo a seguir que têm uma marcação específica indicando que **não devem ser literalmente transcritas**:

Trecho entre `<...>` representa algo que deve ser substituído pelo indicado. Nesse caso, você não deve manter os símbolos `<...>`.
> Parágrafos que aparecem neste modo de citação representa algo que deve ser substituído pelo explicado.

No modelo a seguir são colocados exemplos ilustrativos, que serão substituídos pelos do seu projeto.

> # Modelo para Apresentação da Entrega 2 do Projeto (Arquivo README.md)

<hr>

# Projeto `Assinatura de Progressão no Câncer de Próstata via Ciência de Redes`

# Project `Prostate Cancer Progression Signature via Network Science`


# Descrição Resumida do Projeto

O câncer de próstata (CdP) apresenta um comportamento biológico complexo, onde a transição de um estado indolente para uma forma maligna agressiva é acompanhada por mudanças drásticas no perfil de expressão gênica. O objetivo deste projeto é investigar a progressão da malignidade do CdP através da alteração na topologia das redes de interação de mRNAs. A estratégia central foca na combinação de múltiplos datasets transcriptômicos para mapear a evolução da doença em cinco estágios críticos, desde o tumor primário até o estado metastático insensível a andrógenos..

# Slides

> Coloque aqui o link para o PDF da apresentação da parte 2.

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

# Metodologia

A análise aplicará estratégias de ***Ciência de Redes***. Pretendemos explorar a ***Análise de Centralidade*** para identificar "genes-hub" (reguladores centrais) e a comparação topológica entre as redes de cada fase da doença para detectar padrões de reorganização estrutural associados à malignidade.

% > Proposta de metodologia incluindo especificação de quais de Ciência de Redes que estão sendo usadas no projeto,
% > tais como: detecção de comunidades, análise de centralidade, predição de links, ou a combinação de uma ou mais técnicas. Descreva o que perguntas pretende endereçar com a técnica escolhida.

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

> ![Modelo Lógico de Grafos](./assets/images/modelo_logico_entrega-2.png)


## Integração entre Bases

> Descreva se houve desafios de integração de fontes de dados.

## Análise Preliminar

> Este item não é obrigatório neste estágio. Apresente aqui uma análise preliminar dos dados se houver.
> Utilize gráficos que descrevam os aspectos principais da base que são relevantes para as perguntas de pesquisa consideradas.

## Evolução do Projeto
> Este item não é obrigatório neste estágio, mas pode ser uma preparação para o estágio final.
> Relatório de evolução, descrevendo as evoluções na modelagem do projeto, dificuldades enfrentadas, mudanças de rumo, melhorias e lições aprendidas. Referências aos diagramas, modelos e recortes de mudanças são bem-vindos.
> Podem ser apresentados destaques na evolução dos modelos conceitual e lógico. O modelo inicial e intermediários (quando relevantes) e explicação de refinamentos, mudanças ou evolução do projeto que fundamentaram as decisões.
> Relatar o processo para se alcançar os resultados é tão importante quanto os resultados.

# Ferramentas

- Linguagem: R (DESeq2, limma e ggplot2).
- Redes: String e DAVID.
- Visualização: Cytoscape para análise exploratória visual.

# Referências Bibliográficas

1. EVANS, T. S.; CHEN, B. Linking the network centrality measures closeness and degree. **Communications Physics**, v. 5, n. 172, 2022. DOI: [10.1038/s42005-022-00949-5](https://doi.org/10.1038/s42005-022-00949-5).

2. HANAHAN, Douglas. Hallmarks of cancer—Then and now, and beyond. **Cell**, v. 189, n. 3, p. S0092-8674(25)01498-9, 2026. DOI: [10.1016/j.cell.2025.12.049](https://doi.org/10.1016/j.cell.2025.12.049).

3. LUO, Y.; LIU, X.; LIN, J.; ZHONG, W.; CHEN, Q. Development and validation of novel inflammatory response-related gene signature to predict prostate cancer recurrence and response to immune checkpoint therapy. **Mathematical Biosciences and Engineering (MBE)**, v. 19, n. 11, p. 11345–11366, 2022. DOI: [10.3934/mbe.2022528](https://doi.org/10.3934/mbe.2022528).

4. National Center for Biotechnology Information (NCBI). **Gene Expression Omnibus (GEO)**. Disponível em: [https://www.ncbi.nlm.nih.gov/geo/](https://www.ncbi.nlm.nih.gov/geo/).

5. TANG, S. et al. A genome-scale CRISPR screen reveals PRMT1 as a critical regulator of androgen receptor signaling in prostate cancer. **Cell Reports**, v. 38, n. 8, 2022. DOI: [10.1016/j.celrep.2022.110417](https://doi.org/10.1016/j.celrep.2022.110417).

6. ZHANG, Y. et al. CDCA2 Inhibits Apoptosis and Promotes Cell Proliferation in Prostate Cancer and Is Directly Regulated by HIF-1α Pathway. **Frontiers in Oncology**, v. 10, p. 725, 2020. DOI: [10.3389/fonc.2020.00725](https://doi.org/10.3389/fonc.2020.00725).

7. ZHU, Y. et al. Role of androgen receptor splice variant-7 (AR-V7) in prostate cancer resistance to 2nd-generation androgen receptor signaling inhibitors. **Oncogene**, v. 39, p. 6935–6949, 2020. DOI: [10.1038/s41388-020-01479-6](https://doi.org/10.1038/s41388-020-01479-6). 
