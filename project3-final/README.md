# Projeto `Assinatura de Progressão no Câncer de Próstata via Ciência de Redes`
# Project `Prostate Cancer Progression Signature via Network Science`

# Descrição Resumida do Projeto

O câncer de próstata (CdP) apresenta um comportamento biológico complexo, onde a transição de um estado indolente para uma forma maligna agressiva é acompanhada por mudanças drásticas no perfil de expressão gênica. O objetivo deste projeto é investigar a progressão da malignidade do CdP através da alteração na topologia das redes de interação de mRNAs. A estratégia central foca na combinação de múltiplos datasets transcriptômicos para mapear a evolução da doença em cinco estágios críticos, desde o tumor primário até o estado metastático insensível a andrógenos.

>
> `Falta incluir algus tópicos`
>
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

# Metodologia
> Proposta de metodologia incluindo especificação de quais as técnicas/métricas de Ciência de Redes que estão sendo usadas no projeto,
> tais como: detecção de comunidades, análise de centralidade, predição de links, ou a combinação de uma ou mais técnicas. Descreva o que perguntas pretende endereçar com a técnica escolhida.

## Bases de Dados e Evolução

| Base de Dados | Endereço na Web | Resumo descritivo |
| :--- | :--- | :--- |
| **GSE148544** | [Link GEO](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE148544) | RNA-seq de linhagens celulares (como Du145) e tecidos normais para identificar expressão diferencial regulada pela via HIF-1α. |
| **GSE149433** | [Link GEO](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE149433) | Estudo em modelos PDX sobre o papel da variante AR-v7 na resistência a inibidores de sinalização de andrógenos (Abiraterona/Enzalutamida). |
| **GSE195659** | [Link GEO](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE195659) | Perfil de expressão em linhagens LNCaP para investigar o PRMT1 como regulador da sinalização do receptor de andrógeno. |
| **GSE131985** | [Link GEO](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE131985) | Transcriptomas de linhagens LNCaP95 com nocaute do receptor de andrógeno em condições de enriquecimento ou depleção hormonal. |
| **GSE210205** | [Link GEO](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE210205) | Comparação entre linhagem benigna (BPH-1) e cancerígenas (DU145/PC3) para construção de assinaturas de resposta inflamatória. |

Boa parte dos datasets precisam de um tratamento especial, o que dificultou o uso direto do GEO Soft no Orange. Esse foi um dos principais motivos para a adoção do R no tratamento e padronização das análises, permitindo um maior controle sobre os dados de entrada, os filtros estatísticos e a geração das tabelas utilizadas nas etapas posteriores.

> Faça uma descrição sobre o que concluiu sobre esta base. Sugere-se que respondam perguntas ou forneçam informações indicadas a seguir:
> * O que descobriu sobre essa base?
> * Quais as transformações e tratamentos (e.g., dados faltantes e limpeza) feitos?

## Modelo Lógico

> Modelo lógico da base de grafos revisado. Para o modelo de grafos de propriedades, utilize este
> [modelo de base](https://docs.google.com/presentation/d/10RN7bDKUka_Ro2_41WyEE76Wxm4AioiJOrsh6BRY3Kk/edit?usp=sharing) para construir o seu.
> Coloque a imagem do PNG do seu modelo lógico como ilustrado abaixo (a imagem estará na pasta `image`):
>
> ![Modelo Lógico de Grafos](images/modelo-logico-grafos.png)

## Integração entre Bases

> Descreva se houve desafios de integração de fontes de dados e etapas para a mesma.

## Análises Realizadas

> Apresente aqui uma análise dos dados.
> Utilize gráficos que descrevam os aspectos principais da base que são relevantes para as perguntas de pesquisa consideradas.
>
> Nesta seção ou na seção de Resultados podem aparecer destaques de código como indicado a seguir. Note que foi usada uma técnica de highlight de código, que envolve colocar o nome da linguagem na abertura de um trecho com `~~~`, tal como `~~~python`.
>
> Os destaques de código devem ser trechos pequenos de poucas linhas, que estejam diretamente ligados a alguma explicação. Não utilize trechos extensos de código. Se algum código funcionar online (tal como um Jupyter Notebook), aqui pode haver links. No caso do Jupyter, preferencialmente para o Binder abrindo diretamente o notebook em questão.

~~~python
df = pd.read_excel("/content/drive/My Drive/Colab Notebooks/dataset.xlsx");
sns.set(color_codes=True);
sns.distplot(df.Hemoglobin);
plt.show();
~~~

## Evolução do Projeto

> Relatório de evolução, descrevendo as evoluções na modelagem do projeto, dificuldades enfrentadas, mudanças de rumo, melhorias e lições aprendidas. Referências aos diagramas, modelos e recortes de mudanças são bem-vindos.
> Podem ser apresentados destaques na evolução do modelo lógico. O modelo inicial e intermediários (quando relevantes) e explicação de refinamentos, mudanças ou evolução do projeto que fundamentaram as decisões.
> Relatar o processo para se alcançar os resultados é tão importante quanto os resultados.

# Ferramentas

- Linguagem: R (DESeq2, limma e ggplot2).
- Redes: String e DAVID.
- Visualização: Cytoscape para análise exploratória visual.

> Panorama das ferramentas utilizadas incluindo `discussão sobre o uso das mesmas`.

# Resultados

> Esta pode ser uma seção independente ou combinada com a seção de Análises Realizadas.
>
> Descrição dos resultados mais importantes obtidos.
>
> Apresente os resultados da forma mais rica possível, com gráficos e tabelas. Mesmo que o seu código rode online em um notebook, copie para esta parte a figura estática. A referência a código e links para execução online pode ser feita aqui ou na seção de Análises Realizadas (o que for mais pertinente).

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

# Referências Bibliográficas

1. EVANS, T. S.; CHEN, B. Linking the network centrality measures closeness and degree. **Communications Physics**, v. 5, n. 172, 2022. DOI: [10.1038/s42005-022-00949-5](https://doi.org/10.1038/s42005-022-00949-5).

2. HANAHAN, Douglas. Hallmarks of cancer—Then and now, and beyond. **Cell**, v. 189, n. 3, p. S0092-8674(25)01498-9, 2026. DOI: [10.1016/j.cell.2025.12.049](https://doi.org/10.1016/j.cell.2025.12.049).

3. LUO, Y.; LIU, X.; LIN, J.; ZHONG, W.; CHEN, Q. Development and validation of novel inflammatory response-related gene signature to predict prostate cancer recurrence and response to immune checkpoint therapy. **Mathematical Biosciences and Engineering (MBE)**, v. 19, n. 11, p. 11345–11366, 2022. DOI: [10.3934/mbe.2022528](https://doi.org/10.3934/mbe.2022528).

4. National Center for Biotechnology Information (NCBI). **Gene Expression Omnibus (GEO)**. Disponível em: [https://www.ncbi.nlm.nih.gov/geo/](https://www.ncbi.nlm.nih.gov/geo/).

5. TANG, S. et al. A genome-scale CRISPR screen reveals PRMT1 as a critical regulator of androgen receptor signaling in prostate cancer. **Cell Reports**, v. 38, n. 8, 2022. DOI: [10.1016/j.celrep.2022.110417](https://doi.org/10.1016/j.celrep.2022.110417).
