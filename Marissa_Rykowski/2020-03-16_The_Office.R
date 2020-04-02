setwd("C:/Users/mbryk/Documents/RSMAS/tidytuesday/Marissa_Rykowski")

office_ratings <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-03-17/office_ratings.csv')

library(tidyverse)
library(patchwork)

######################################################################################

RateGraph <- office_ratings %>%
  group_by(season) %>%
  summarize(avg_ratings=mean(imdb_rating)) %>%
  ggplot(aes(season,avg_ratings))+
    geom_line(color="hotpink4",size=3)+
    labs(x="",y="",title="Average IMDB Rating")+
    scale_x_continuous(breaks=1:9)

###################################################################################

VoteGraph <- office_ratings %>%
  group_by(season) %>%
  summarize(num_votes=sum(total_votes)) %>%
  ggplot(aes(season,num_votes))+
    geom_line(color="indianred4",size=3)+
    labs(x="Season",y="",title="Total Number of IMDB Votes")+
    scale_x_continuous(breaks=1:9)

###################################################################################

CombGraph <- RateGraph / VoteGraph
wrap_elements(CombGraph)
