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

ggplot(Adelie,aes(AvgBillLen))+
  geom_col(aes(fill=sex))+
  facet_grid(AvgBillLen ~ island)

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