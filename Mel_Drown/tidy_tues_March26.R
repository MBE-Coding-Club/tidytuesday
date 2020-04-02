# Get the Data
tbi_age <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-03-24/tbi_age.csv')
tbi_year <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-03-24/tbi_year.csv')
tbi_military <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-03-24/tbi_military.csv')

head(tbi_age)
head(tbi_military)
head(tbi_year)

library(ggplot2)
library(tidyr)
library(dplyr)

age <- tbi_age
mil <- tbi_military
yr <- tbi_year

# military
mil2 <- mil %>% group_by(service, component, year) %>%
  summarize(avg = mean(diagnosed, na.rm=TRUE))

ggplot(mil2) +
  geom_bar(aes(x=service, y=avg, fill=component), stat="identity", position="dodge") +
  scale_fill_manual(values=c("darkgreen", "tan", "brown")) +
  facet_wrap(~year) +
  theme_bw()

# age - want to plot type as a proportion of total across all ages

age2 <- age %>% group_by(type) %>%
  mutate(total_num=sum(number_est,na.rm=TRUE))

age2 <- age2 %>% group_by(age_group, type) %>%
  mutate(perc_total=(number_est/total_num)*100)

ggplot(age2) +
  geom_bar(aes(x=age_group, y=perc_total, fill=age_group), stat="identity", position="dodge") +
  theme_bw()

ggplot(age2) +
  geom_bar(aes(x=age_group, y=perc_total, fill=age_group), stat="identity", position="dodge") +
  facet_wrap(~type, nrow=3, scales="free")+
  theme_bw()

ggplot(age2) +
  geom_bar(aes(x=type, y=perc_total, fill=age_group), stat="identity", position="dodge") +
  theme_bw()

ggplot(age2) +
  geom_bar(aes(x=age_group, y=perc_total, fill=type), stat="identity", position="dodge") + 
  scale_fill_manual(values=c("grey","wheat","lightblue"))+
  theme_bw()

install.packages("patchwork")
library(patchwork)
