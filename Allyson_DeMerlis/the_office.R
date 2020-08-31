office_ratings <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-03-17/office_ratings.csv')

library(schrute)
mydata <- schrute::theoffice

directors <- mydata %>% select(season, episode, director, imdb_rating) %>% 
  group_by(director) %>% 
  unique()

ratings <- directors %>%
  filter(!is.na(imdb_rating)) %>%
  mutate(overall_rating = mean(imdb_rating)) %>%
  arrange(director)

ggplot(aes())