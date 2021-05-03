
# Set Up ------------------------------------------------------------------

setwd("C:/Users/mbryk/Documents/RSMAS/tidytuesday/Marissa_Rykowski")

raw_bechdel <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-03-09/raw_bechdel.csv')
movies <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-03-09/movies.csv')

library(tidyverse)


# Organizing Data ---------------------------------------------------------

View(movies)
View(raw_bechdel)

Movies <- movies %>%
  mutate(years = case_when(
    between(year,1970,1974) ~ "1970-'74",
    between(year,1975,1979) ~ "1975-'79",
    between(year,1980,1984) ~ "1980-'84",
    between(year,1985,1989) ~ "1985-'89",
    between(year,1990,1994) ~ "1990-'94",
    between(year,1995,1999) ~ "1995-'99",
    between(year,2000,2004) ~ "2000-'04",
    between(year,2005,2009) ~ "2005-'09",
    TRUE                    ~ "2010-'13"
  ))

Movies <- Movies %>%
  group_by(years,clean_test) %>%
  summarize(count=n()) %>%
  group_by(years)

Movies <- Movies %>%
  mutate(prop=count/sum(count))

Movies <- Movies %>%
  mutate(clean_test=factor(clean_test,levels=c("ok","dubious","men","notalk","nowomen")),
         clean_test=fct_rev(clean_test))


# Plot --------------------------------------------------------------------

ggplot(Movies) +
  geom_col(aes(x=years,y=prop,fill=clean_test),color="white",show.legend=F,width=1)+
  labs(x="",y="",title="The Bechdel Test Over Time",subtitle="How women are represented in movies")+
  scale_fill_manual(values=c("ok"="#008fd5","dubious"="#6bb2d5","men"="#ffc9bf","notalk"="#ff9380","nowomen"="#ff2700"))+
  scale_y_continuous(labels=c("0","25","50","75","100%"))+
  theme_bw()+
  theme(plot.background=element_rect(fill="#f0f0f0"),
        panel.border=element_blank(),
        panel.grid.major=element_blank(),
        panel.grid.minor=element_blank(),
        panel.background=element_rect(fill="#f0f0f0"))

png(file="BechdelTest.png",width=6,height=6,units="in",res=300)
ggplot(Movies) +
  geom_col(aes(x=years,y=prop,fill=clean_test),color="white",show.legend=F,width=1)+
  labs(x="",y="",title="The Bechdel Test Over Time",subtitle="How women are represented in movies")+
  scale_fill_manual(values=c("ok"="#008fd5","dubious"="#6bb2d5","men"="#ffc9bf","notalk"="#ff9380","nowomen"="#ff2700"))+
  scale_y_continuous(labels=c("0","25","50","75","100%"))+
  theme_bw()+
  theme(plot.background=element_rect(fill="#f0f0f0"),
        panel.border=element_blank(),
        panel.grid.major=element_blank(),
        panel.grid.minor=element_blank(),
        panel.background=element_rect(fill="#f0f0f0"))
dev.off()
