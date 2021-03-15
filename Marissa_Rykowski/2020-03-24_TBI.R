setwd("C:/Users/mbryk/Documents/RSMAS/tidytuesday/Marissa_Rykowski")

tbi_age <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-03-24/tbi_age.csv')
tbi_year <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-03-24/tbi_year.csv')
tbi_military <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-03-24/tbi_military.csv')

library(tidyverse)
###############################################################################################
list(unique(tbi_age$injury_mechanism))
######################################################################################################
graph1<- tbi_year %>%
  filter(!is.na(number_est)) %>%
  group_by(year) %>%
  summarize(total=sum(number_est))
ggplot(graph1,aes(year,total))+
  geom_line(color="palevioletred2",size=2)+
  theme_classic()+
  labs(title="Trend in Estimated Brain Injuries per Year",x="Year",y="Estimated")

###########################################################################################

graph2<- tbi_year %>%
  filter(injury_mechanism=="Motor vehicle crashes",type=="Emergency Department Visit")
ggplot(graph2,aes(year,number_est))+
  geom_line(color="salmon4",size=2)+
  theme_classic()+
  labs(title="Trend in Motor Vehicle Crashes in Emergency Department Visit",x="Year",y="Estimated Number of Brain Injuries")

################################################################################################

#derived from https://github.com/delabj/tidyTues/blob/master/2020-03-24/Head%20Injury.R

deathdata<-tbi_age %>%
  filter(age_group != "Total") %>%
  filter(age_group != "0-17") %>%
  filter(number_est != "NA") %>%
  filter(type == "Deaths") %>%
  mutate(injury_mechanism = case_when(injury_mechanism == "Motor Vehicle Crashes" ~ "Motor Accident",
                                      injury_mechanism %in% c("Unintentional Falls","Unintentionally struck by or against an object","Other unintentional injury, mechanism unspecified") ~ "Unintentional Accident",
                                      injury_mechanism == "Intentional self-harm" ~ "Self-harm",
                                      injury_mechanism == "Other or no mechanism specified" ~ "Other",
                                      injury_mechanism == "Assault" ~ "Assault"))

hospdata<-tbi_age %>%
  filter(age_group != "Total") %>%
  filter(age_group != "0-17") %>%
  filter(number_est != "NA") %>%
  filter(type == "Hospitalizations") %>%
  mutate(injury_mechanism = case_when(injury_mechanism == "Motor Vehicle Crashes" ~ "Motor Accident",
                                      injury_mechanism %in% c("Unintentional Falls","Unintentionally struck by or against an object","Other unintentional injury, mechanism unspecified") ~ "Unintentional Accident",
                                      injury_mechanism == "Intentional self-harm" ~ "Self-harm",
                                      injury_mechanism == "Other or no mechanism specified" ~ "Other",
                                      injury_mechanism == "Assault" ~ "Assault"))

ERdata<-tbi_age %>%
  filter(age_group != "Total") %>%
  filter(age_group != "0-17") %>%
  filter(number_est != "NA") %>%
  filter(type == "Emergency Department Visit") %>%
  mutate(injury_mechanism = case_when(injury_mechanism == "Motor Vehicle Crashes" ~ "Motor Accident",
                                      injury_mechanism %in% c("Unintentional Falls","Unintentionally struck by or against an object","Other unintentional injury, mechanism unspecified") ~ "Unintentional Accident",
                                      injury_mechanism == "Intentional self-harm" ~ "Self-harm",
                                      injury_mechanism == "Other or no mechanism specified" ~ "Other",
                                      injury_mechanism == "Assault" ~ "Assault")) %>%
  mutate(age_group = factor(age_group, levels = c("0-4", "5-14", "15-24", "25-34", "35-44", "45-54", "55-64", "65-74", "75+")), 
         injury_mechanism = factor(injury_mechanism, levels = c("Assault", "Motor Accident", "Self-harm", "Unintentional Accident", "Other")))

Dgraph<-ggplot(deathdata,aes(x=injury_mechanism,y=number_est))+
  geom_bar(stat="identity",fill="turquoise4")+
  facet_wrap(~age_group,nrow=1)+
  labs(x=" ",y="")

EDVgraph<-ggplot(ERdata,aes(x=injury_mechanism,y=number_est))+
  geom_bar(stat="identity",aes(fill=injury_mechanism))+
  facet_wrap(~age_group,nrow=1)+
  labs(x="",y="")+
  scale_fill_discrete(name="Injury",labels=c("Assault","Motor Accident","Self-harm","Unintentional Accident","Other"))+
  theme(axis.text.x=element_blank(),axis.ticks.x=element_blank())

Hgraph<-ggplot(hospdata,aes(x=injury_mechanism,y=number_est))+
  geom_bar(stat="identity",fill="tomato4")+
  facet_wrap(~age_group,nrow=1)+
  labs(x="",y="")

plot_grid(Dgraph,EDVgraph,Hgraph,nrow=3,labels=c("Deaths","ER Visits","Hospitalization"),
          hjust=c(-1.3,-0.8,-0.1))
