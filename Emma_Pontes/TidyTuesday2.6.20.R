getwd()

require(Rmisc)
library(tidyverse)
library(dplyr)
install.packages("broom")

attendance<-read.csv("attendance.csv")
games<-read.csv("games.csv")
standings<-read.csv("standings.csv")

summary.team=summarySE(attendance,measurevar = 'weekly_attendance',groupvars = c("team_name"),na.rm=TRUE)
g=ggplot(summary.team,aes(team_name,weekly_attendance))
g=g+geom_col(fill="coral")
g=g+labs(x="Team Name", y="Average Weekly Attendance",)
g=g+coord_flip()
g=g+ggtitle("Average Weekly Attendance by Team")
g=g+geom_errorbar(aes(ymin=weekly_attendance-se,ymax=weekly_attendance+se),width=.1,size=0.5)
g

a=ggplot(standings,aes(team_name,wins))
a=a+geom_col(fill="blue")
a=a+coord_flip()
a=a+ggtitle("Number of Wins by Team")
a=a+labs(x="Team Name",y="Number of Wins")
a         
         
         
        