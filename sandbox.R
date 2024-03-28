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
