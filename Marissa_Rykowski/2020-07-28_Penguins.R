setwd("C:/Users/mbryk/Documents/RSMAS/tidytuesday/Marissa_Rykowski")

penguins <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-07-28/penguins.csv')

library(tidyverse)

#########################################################################################################

Adelie <- penguins %>%
  na.omit(Adelie) %>%
  filter(species == "Adelie") %>%
  group_by(island,sex) %>%
  summarize(AvgBillLen = mean(bill_length_mm),
         AvgBillDep = mean(bill_depth_mm),
         AvgFlipLen = mean(flipper_length_mm),
         AvgBodyMass = mean(body_mass_g))

############################################################################################
  

penguins<-penguins %>%
  na.omit(penguins)
  
ggplot(penguins,aes(x=bill_length_mm,y=bill_depth_mm,color=sex))+
  geom_point()+
  facet_grid(.~island)+
  labs(x="Bill Length (mm)",y="Bill Depth (mm)")+
  scale_color_discrete(name="Sex",labels=c("Female","Male"))

####################################################################################################  

Adelie2 <- penguins %>%
  na.omit(Adelie2) %>%
  filter(species == "Adelie") %>%
  group_by(island,sex)

ggplot(Adelie2,aes(bill_length_mm,bill_depth_mm,color=island,size=body_mass_g))+
  geom_point()+
  theme_classic()+
  labs(x="Bill Length (mm)",y="Bill Depth (mm)",color="Island",size="Body Mass (g)")

###################################################################################################  