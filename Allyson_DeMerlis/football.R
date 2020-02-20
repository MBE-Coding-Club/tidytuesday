# Get the Data

attendance <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-02-04/attendance.csv')
standings <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-02-04/standings.csv')
games <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-02-04/games.csv')

library(dplyr)
library(tidyverse)
library(ggplot2)

head(games)
head(attendance)
head(standings)

attendance %>% dplyr::left_join(standings, by = c("year", "team_name", "team")) 
%>% dplyr::left_join(games, by=c("year")) %>% View()

philly_attendance<- filter(attendance, attendance$team == "Philadelphia") 

philly_standings<- filter(standings, standings$team == "Philadelphia")



ggplot(philly_attendance, aes(weekly_attendance, away), class = "year") + 
  geom_point()

install.packages("teamcolors")
require(Rmisc)
summarySE(attendance,measurevar=attendance,groupvars=year,na.rm=T)


attendance %>% 
  group_by(year) %>%
  summarise(mean=mean(weekly_attendance, na.rm=T)) %>% View()





