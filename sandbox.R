# World Bank Data ----
library(wbstats)
library(tidyverse)


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
