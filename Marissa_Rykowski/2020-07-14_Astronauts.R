setwd("C:/Users/mbryk/Documents/RSMAS/tidytuesday/Marissa_Rykowski")

astronauts <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-07-14/astronauts.csv')

library(tidyverse)

#####################################################################################################

astronauts <- astronauts %>%
  mutate(age=year_of_mission-year_of_birth)

ggplot(astronauts)+
  geom_point(aes(x=age,y=year_of_mission,color=sex))+
  theme_classic()+
  labs(title="Astronauts' Age for Each Mission",x="Age",y="Year")+
  scale_fill_discrete(name="Sex",labels=c("Female","Male"))

####################################################################################################

ByMission <- astronauts %>%
  group_by(year_of_selection) %>%
  count(total_number_of_missions)
ByMission$total_number_of_missions<-factor(ByMission$total_number_of_missions)

ggplot(ByMission,aes(x=year_of_selection,fill=total_number_of_missions))+
  geom_bar()+
  theme_classic()+
  labs(title="Total number of missions for each selection year",x="Year of Selection",y="Count")+
  scale_fill_discrete(name="Number of Missions")

####################################################################################################

astronauts %>%
  count(nationality,sort=T)

#####################################################################################################

ggplot(astronauts)+
  geom_point(aes(x=age,y=hours_mission))+
  theme_classic()+
  labs(title="Number of mission hours by age",x="Age",y="Mission Hours")
           