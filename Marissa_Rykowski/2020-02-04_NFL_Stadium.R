setwd("C:/Users/mbryk/Documents/RSMAS/tidytuesday")

tuesdata<-tidytuesdayR::tt_load('2020-02-04')
attendance<-tuesdata$attendance
standings<-tuesdata$standings
games<-tuesdata$games

library(tidyverse)
library(teamcolors)

#######################################################################################

ByTeam<-attendance %>%
  group_by(team_name) %>%
  filter(weekly_attendance != "NA") %>%
  summarize(meanAtt=mean(weekly_attendance))

ggplot(ByTeam,aes(x=team_name,y=meanAtt))+
  geom_col(fill=show_sport_col("football"))+
  labs(x="Team",y="Mean Attendance",title="Mean Attendance per Team from 2000-2019")+
  theme_classic()  +
  coord_flip()

FootballColors<-show_sport_col(sport="football")
########################################################################################
Difference<-attendance
Difference[is.na(Difference)]<-0

Difference<-Difference %>%
  filter(year == 2000) %>%
  group_by(team_name) %>%
  summarize(DeltaN=weekly_attendance[week == 17] - weekly_attendance[week == 1])

ggplot(Difference,aes(x=team_name,y=DeltaN))+
  geom_col(fill="bisque1")+
  labs(title="Change in Attendance from Week 1 to 17",x="Team",y="Change in Attendance")+
  coord_flip()+
  theme_classic()

##################################################################################

ByYear<-attendance %>%
  group_by(year) %>%
  summarize(AvgAtt=mean(weekly_attendance,na.rm=TRUE))
  
ggplot(ByYear,aes(x=year,y=AvgAtt))+
  geom_col(fill="gray36")+
  labs(title="Average Attendance",x="Year",y="Attendance")+
  theme_classic()

####################################################################################

BearsSched<-attendance %>%
  filter(team=="Chicago")
  
  