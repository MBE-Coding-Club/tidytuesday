setwd("C:/Users/mbryk/Documents/RSMAS/tidytuesday/Marissa_Rykowski")

tuesdata <- tidytuesdayR::tt_load('2020-06-16')

blackpast <- tuesdata$blackpast
census <- tuesdata$census
slave_routes <- tuesdata$slave_routes
african_names <- tuesdata$african_names

library(tidyverse)

######################################################################################################

Decades <- slave_routes %>%
  filter(n_slaves_arrived != "NA") %>%
  mutate(decade = round(year_arrival*.1,0)) %>%
  group_by(decade) %>%
  summarize(total = sum(n_slaves_arrived)) %>%
  ungroup() %>%
  mutate(decade = decade*10)
  
ggplot(Decades,aes(x=decade,y=total))+
  geom_col()+
  theme_classic()+
  labs(title="Trans-Atlantic Slave Trade",x="Year",y="Total")

####################################################################################################



