setwd("C:/Users/mbryk/Documents/RSMAS/tidytuesday/Marissa_Rykowski")

firsts <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-06-09/firsts.csv')
science <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-06-09/science.csv')

library(tidyverse)

View(firsts)
View(science)

#######################################################################################################

female_firsts <- firsts %>% 
  mutate(n=1) %>%
  filter(gender=="Female African American Firsts") %>%
  group_by(category) %>%
  mutate(roll_n = cumsum(n))

ggplot(female_firsts,aes(x=year,y=roll_n,color=category))+
  geom_line()

#from github tidytuesday code
plot_ex <- first_df %>% 
  mutate(n = 1) %>% 
  group_by(category) %>% 
  mutate(roll_n = cumsum(n)) %>% 
  ggplot(aes(x = year, y = roll_n, color = category)) +
  geom_step(size = 1) +
  theme(legend.position = "top") +
  tomtom::theme_tomtom() +
  scale_y_continuous(breaks = scales::pretty_breaks(n = 6)) +
  scale_x_continuous(breaks = seq(1750, 2020, 25)) +
  geom_hline(yintercept = 0, size = 1, color = "black") +
  labs(x = "", y = "",
       title = "Cumulative African-Americans firsts over time",
       subtitle = "479 'Firsts' of African-Americans breaking the color barrier across a wide range of topics",
       caption = "Data: wikipedia.org/wiki/List_of_African-American_firsts")
