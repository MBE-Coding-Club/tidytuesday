setwd("C:/Users/mbryk/Documents/RSMAS/Tidy Tuesday")

christmas_songs<-readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-12-24/christmas_songs.csv")
christmas_lyrics<-readr::read_tsv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-12-24/christmas_lyrics.tsv")

library(tidyverse)

View(christmas_songs)
View(christmas_lyrics)

########################################################################################################
#number of weeks
ByWeeks<-christmas_songs %>%
  arrange(desc(weeks_on_chart))
ByWeeks$url<-NULL
ByWeeks$songid<-NULL

View(ByWeeks)

########################################################################################################
#peak position
Peak<-christmas_songs %>%
  arrange(desc(peak_position))

