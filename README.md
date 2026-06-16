# Projeto `Assinatura de Progressão no Câncer de Próstata via Ciência de Redes`

# Project `Prostate Cancer Progression Signature via Network Science`

| Nome | RA | Especialização |
| :--- | :--- | :--- |
| Diogo Pereira de Lima Carvalho| 322992 | Computação |
| Nicolas Alexandre de Oliveira | 237039 | Biologia |
| Rafael Henrique Ramos| 324076 | Computação |
| Raffael Rotta Bindi | 249464 | Biologia |
| Victoria Christina de Moraes Atilio | 295891 | Computação |
| Vinícius Costa de Oliveira | 324079 | Computação |

# Apresentação

O presente projeto foi originado no contexto das atividades da disciplina de pós-graduação [Ciência e Visualização de Dados em Saúde](https://link-da-disciplina), oferecida no primeiro semestre de 2026, na Unicamp.

# Descrição Resumida do Projeto

O câncer de próstata (CdP) apresenta um comportamento biológico complexo, onde a transição de um estado indolente para uma forma maligna agressiva é acompanhada por mudanças drásticas no perfil de expressão gênica. Tradicionalmente, a literatura e os trabalhos relacionados avaliam a progressão tumoral focando em análises isoladas de expressão ou nas marcas funcionais clássicas do câncer (*Hallmarks of Cancer*).

Como diferencial e principal motivação, este projeto buscou investigar a progressão da malignidade do CdP de forma sistêmica, compreendendo a doença não apenas pelo aumento de genes isolados, mas através da alteração na ***topologia das redes de interação de mRNAs***. Para superar as limitações de amostras isoladas, a estratégia do grupo consistiu na combinação de múltiplos datasets transcriptômicos provenientes do ***GEO (Gene Expression Omnibus)***. A partir desses dados, foram construídos grafos onde os nós representam mRNAs e as arestas representam correlações funcionais ou de coexpressão.

Através de métricas de ciência de redes, identificamos os "genes-hub" que atuam como reguladores centrais em cada fase do tumor (desde o primário até o metastático insensível a andrógenos). A hipótese central de que a malignidade pode ser mapeada pela reorganização dessas redes foi testada, e os resultados alcançados revelaram assinaturas estruturais específicas para cada estágio. Observou-se que o avanço da doença desloca o comando de vias inflamatórias para o domínio do metabolismo de tradução ribossômica e citocinas.