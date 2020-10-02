
library(tidyverse)
library(tvthemes)

avatar <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-08-11/avatar.csv')
scene_description <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-08-11/scene_description.csv')

unique(avatar$character)
jc <- avatar %>% group_by(chapter_num) %>% filter(character == "Cabbage merchant")
njc <- avatar %>% group_by(chapter_num) %>% filter(chapter_num != jc$chapter_num)


test <- avatar %>% group_by(book_num, chapter_num) %>% summarise(mean(imdb_rating))

lol <- avatar %>% group_by(book_num, chapter_num) %>% summarise(mean(imdb_rating)) %>% filter(chapter_num != jc$chapter_num)%>% filter(chapter_num != jc$book_num) 

test$cab[35] <- 1

test$t <- seq(1,61,1)

ggplot(test, aes(t, `mean(imdb_rating)`)) + geom_point(aes(color = cab, size = cab))+xlab("Episode Number") + ylab("IMDB Rating (/10)") 

  
  
jc$imdb_rating
summary(jc$imdb_rating)



ggplot(jc, aes(imdb_rating)) + boxplot(imdb_rating)

summary(character)

