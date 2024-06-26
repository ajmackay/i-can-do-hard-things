# Posts to do:
## ggrepel -
# ggrepel::geom_text_repel(data = filter(dat, sirs.class == "Neglect",
#                                        incident.period == latest_period),
#                          aes(col = hcp.package,
#                              label = hcp.package),
#                          show.legend = FALSE,
#                          direction = "y",
#                          nudge_x = 0.2,
#                          fontface = "bold",
#                          segment.linetype = "dashed") +
#
#   labs(col = element_blank(),
#        x = element_blank(),
#        y = element_blank()) +
#
#   theme.flourish(background.colour = "#f0e9d8") +
#
#
#   theme(legend.position = "none",
#         panel.grid.major.x = element_line(linetype = "dashed"),
#         axis.text.x = element_text(face = "bold"))

# Date Reference table and the things you can do with it
## E.g., count how many things occurred in a period

# Quickly exporting tables using officer
# doc <- officer::read_docx() %>%
#   body_add_flextable(industry_rate_tbl, align = "center") %>%
#   body_add_par("\n\n") %>%
#   body_add_flextable(sirs_rate_tbl, align = "center")
#
# print(doc, target = "outputs/appendix-tables.docx")


DiagrammeR::grViz("
  digraph {

    # Define the nodes
    A [label = 'Node A']
    B [label = 'Node B']
    C [label = 'Node C']

    # Define the edges
    A -> B
    B -> C
    C -> A
  }
")


library(tm)

# Create a sample text corpus
text_corpus <- c("This is the first document",
                 "This document is the second document",
                 "And this is the third one")

matt_corpus <- matthew_df %>% pull(text) %>%
  VectorSource() %>% VCorpus()

# Convert the character vectors into a corpus
corpus <- VCorpus(VectorSource(text_corpus))

# Perform some preprocessing steps (optional)
corpus <- tm_map(corpus, content_transformer(tolower))    # Convert to lower case
corpus <- tm_map(corpus, removePunctuation)               # Remove punctuation
corpus <- tm_map(corpus, removeNumbers)                   # Remove numbers

matt_corpus <- tm_map(matt_corpus, content_transformer(lemmatize_words))
matt_corpus <- tm_map(matt_corpus, removePunctuation)
matt_corpus <- tm_map(matt_corpus, content_transformer(tolower))

# Create the term-document matrix
tdm <- TermDocumentMatrix(matt_corpus)
tdm %>% as.matrix()

as.matrix(tdm)


matthew_lemma_df %>%
  filter(str_detect(word, "gather")) %>%
  count(lemma)



library(DiagrammeR)

grViz("
      graph {
      rankdir=LR;
      hello -- world;
      }")



mermaid("graph LR;
        A[Corpus]-->B{Pre-Processing};

        B-->C(Tokenisation);
        B-->D(Stop Word Removal);
        B-->E(Stemming/Lemmatisation);

        F{Text Representation};



        F-->G[Bag-of-words]
        F-->H[TF-IDF]
        F-->I[Word Embeddings]
        G-->J[Contextual Embeddings]"
        )

create_graph() %>%
  add_node(label = "Corpus") %>%
  add_node(label = "Pre-Processing") %>%
  add_edge(from = 1, to = 2) %>% render_graph()


# Create a sequence diagram
DiagrammeR("graph LR;
           A(Rounded)-->B[Squared];
           B-->C{A Decision};
           C-->D[Square One];
           C-->E[Square Two];"
)


# World Bank Data ----
library(wbstats)
library(tidyverse)

pop.raw <- wb_data("SP.POP.TOTL")

pop.df <- pop.raw %>%
  select(-c(unit, obs_status)) %>%
  rename(population = SP.POP.TOTL)

eu.countries <- c("Austria",	"France",	"Malta", "Belgium",	"Germany", "Netherlands", "Bulgaria",	"Greece",
                  "Poland", "Croatia", "Hungary",	"Portugal", "Cyprus",	"Ireland", "Romania", "Czech Republic",
                  "Italy",	"Slovakia", "Denmark",	"Latvia",	"Slovenia", "Estonia", "Lithuania",	"Spain",
                  "Finland",	"Luxembourg",	"Sweden")

eu.countries[which(!eu.countries %in% unique(filter(pop.df, country %in% eu.countries)$country))]

updated.countries <- pop.df %>%
  filter(str_detect(country, "Czech|Slovak")) %>%
  distinct(country) %>% pull(country)

eu.countries <- append(eu.countries, updated.countries)
eastern.countries <- c("Poland", "Czechia", "Slovak Republic", "Hungary", "Romania", "Bulgaria")


pop.df %>%
  filter(country %in% eu.countries,
         date == 2022) %>%

  ggplot(aes(x = country, y = population)) +
  geom_col() +

  coord_flip() +

  scale_y_continuous(labels = scales::number, expand = expansion(mult = c(0.0, 0.05))) +
  scale_x_discrete(limits = rev) +

  gghighlight::gghighlight(country %in% eastern.countries)



?wb_data()

# Highlighting ----
ChickWeight %>%
  group_by(Chick) %>%
  summarise(mean = mean(weight)) %>%

  ggplot(aes(x = Chick, y = mean)) +
  geom_col()



data(Oxboys, package = 'nlme')
Oxboys %>%
  ggplot(aes(age, height, group = Subject)) +
  geom_line() +
  geom_point() +
  gghighlight::gghighlight(Subject %in% 1:3)

iris %>%
  group_by(Species) %>%
  summarise(mean.length = mean(Sepal.Length)) %>%
  ggplot(aes(x = Species, y = mean.length)) +
  geom_col() +
  gghighlight::gghighlight(Species %in% c('setosa', 'versicolor'))
