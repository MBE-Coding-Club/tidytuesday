setwd("D:/Documents/RSMAS/Other Projects/Coding Club/tidytuseday/gov kids")

kids <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-09-15/kids.csv')

#some redundant packages because I was using a tutorial.(https://www.datanovia.com/en/blog/how-to-create-a-map-using-ggplot2/)
library(tidyverse)
library(ggplot2)
library(dplyr)
require(maps)
require(viridis)
theme_set(
  theme_void()
)

# Retrieve the states map data and merge with funding data
states_map <- map_data("state")

#make all states lowercase
kids$region <- tolower(kids$state)
money_map <- left_join(states_map, kids, by = "region")

#figure out what variables are available and select a few to look at
unique(kids$variable)

lib_map <- filter(money_map, variable == "lib")
hed_map <- filter(money_map, variable == "highered")
park_map <- filter(money_map, variable == "parkrec")


# Create the maps
gg <- ggplot(money_map, aes(long, lat, group = group))+
  geom_polygon(aes(fill = inf_adj_perchild), color = "white")+
  scale_fill_viridis_c(option = "C") +
  ggtitle("All Funding")

gg2 <- ggplot(hed_map, aes(long, lat, group = group))+
  geom_polygon(aes(fill = inf_adj_perchild), color = "white")+
  scale_fill_viridis_c(option = "C") +
  ggtitle("Higher Education")

gg3 <- ggplot(lib_map, aes(long, lat, group = group))+
  geom_polygon(aes(fill = inf_adj_perchild), color = "white")+
  scale_fill_viridis_c(option = "C") +
  ggtitle("Libraries")

gg4 <- ggplot(park_map, aes(long, lat, group = group))+
  geom_polygon(aes(fill = inf_adj_perchild), color = "white")+
  scale_fill_viridis_c(option = "C")+
  ggtitle("Parks and Recreation")

#put all the maps on the same page
library(patchwork)

(gg + gg2) / (gg3 + gg4) 
