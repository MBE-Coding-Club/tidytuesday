setwd("C:/Users/mbryk/Documents/RSMAS/Tidy Tuesday")
murders<-readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-12-10/international_murders.csv")
gun_murders<-readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-12-10/gun_murders.csv")
diseases<-readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-12-10/diseases.csv")
nyc_regents<-readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-12-10/nyc_regents.csv")

library(tidyverse)
library(countrycode)
#library(ggflags) doesn't work with r 3.6.1

View(murders)
View(gun_murders)
View(diseases)
View(nyc_regents)

########################################################################################################
#from github
dat <- tibble(country = toupper(c("US", "Italy", "Canada", "UK", "Japan", "Germany", "France", "Russia")),
              count = c(3.2, 0.71, 0.5, 0.1, 0, 0.2, 0.1, 0),
              label = c(as.character(c(3.2, 0.71, 0.5, 0.1, 0, 0.2, 0.1)), "No Data"),
              code = c("us", "it", "ca", "gb", "jp", "de", "fr", "ru"))

dat %>% mutate(country = reorder(country, -count)) %>%
  ggplot(aes(country, count, label = label)) +
  geom_bar(stat = "identity", fill = "darkred") +
  geom_text(nudge_y = 0.2, color = "darkred", size = 5) +
  geom_flag(y = -.5, aes(country = code), size = 12) +
  scale_y_continuous(breaks = c(0, 1, 2, 3, 4), limits = c(0,4)) +   
  geom_text(aes(6.25, 3.8, label = "Source UNODC Homicide Statistics")) + 
  ggtitle(toupper("Homicide Per 100,000 in G-8 Countries")) + 
  xlab("") + 
  ylab("# of gun-related homicides\nper 100,000 people") +
  ggthemes::theme_economist() +
  theme(axis.text.x = element_text(size = 8, vjust = -16),
        axis.ticks.x = element_blank(),
        axis.line.x = element_blank(),
        plot.margin = unit(c(1,1,1,1), "cm")) 