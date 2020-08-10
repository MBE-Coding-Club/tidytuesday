setwd("C:/Users/mbryk/Documents/RSMAS/tidytuesday/Marissa_Rykowski")

energy_types <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-08-04/energy_types.csv')
country_totals <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-08-04/country_totals.csv')

library(tidyverse)

#######################################################################################################

Energy <- energy_types %>%
  mutate(change = `2018` - `2016`)

ggplot(Energy)+
  geom_col(aes(x=country,y=change,fill=type))+
  labs(x="Country",y="Change (GWh)",title="Change in Energy Usage from 2016 to 2018",fill="Type")+
  coord_flip()

#######################################################################################################

Usage <- country_totals %>%
  mutate(total = `2016`+`2017`+`2018`) %>%
  filter(type == "Total net production")

ggplot(Usage)+
  geom_col(aes(x=country,y=total))+
  labs(x="Country",y="Energy (GWh)",title="Total Energy Usage from 2016-2018")+
  coord_flip()+
  theme_classic()

#################################################################################################

Sustainable <- energy_types %>%
  mutate(type = case_when(type == "Conventional thermal" ~ "Thermal",
                               type == "Nuclear" ~ "Nuclear",
                               type %in% c("Hydro","Pumped hydro power","Wind","Solar","Geothermal") ~ "Renewable",
                               type == "Other" ~ "Other")) %>%
  group_by(country,type) %>%
  mutate(total = )


  





