setwd("C:/Users/mbryk/Documents/RSMAS/Tidy Tuesday")

commute<-readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-11-05/commute.csv")
table3<-readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-11-05/table_3.csv")

###################################################################################################

library(tidyverse)
library(readxl)
library(here)
library(glue)
library(janitor)

##############################################################################################

city<-commute$city
state<-commute$state
city_size<-commute$city_size
trans_mode<-commute$mode
n<-commute$n
trans_percent<-commute$percent
moe<-commute$moe
abbr<-commute$state_abb
region<-commute$state_region

#############################################################################################

city_size<-factor(city_size,levels=c("Small","Medium","Large"))
ggplot(commute)+geom_col(aes(x=city_size,y=n,fill=factor(trans_mode)),position="dodge")+
  scale_fill_manual(values=c("red","blue"),name="Mode")+theme_classic()+
  labs(title="Modes of Transportation",x="City Size",y="Count")

Illinois<-subset(commute,abbr=="IL")
ggplot(Illinois)+geom_col(aes(x=Illinois$city_size,y=Illinois$n,fill=factor(Illinois$mode)),position="dodge")+
  scale_fill_manual(values=c("red","blue"),name="Mode")+theme_classic()+
  labs(title="Illinois Transportation",x="City Size",y="Count")

Florida<-subset(commute,abbr=="FL")
ggplot(Florida)+geom_col(aes(x=Florida$city_size,y=Florida$n,fill=factor(Florida$mode)),position="dodge")+
  scale_fill_manual(values=c("red","blue"),name="Mode")+theme_classic()+
  labs(title="Florida Transportation",x="City Size",y="Count")
