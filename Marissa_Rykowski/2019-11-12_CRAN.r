setwd("C:/Users/mbryk/Documents/RSMAS/Tidy Tuesday")

library(ggplot2)
library(tidyverse)

cran_code<-readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-11-12/loc_cran_packages.csv")

######################################################################################################
#mean number of files per package in top 5 occuring languages
lang_set<-cran_code %>%
  count(language,sort=T) %>%
  top_n(5,n)

top5<-subset(cran_code,language=="R" | language=="Markdown" | language=="HTML" | language=="C" | 
                language=="C++")

mean_file<-tapply(top5$file,top5$language,mean)
mean_file2<-data.frame(mean=mean_file,labels=c("C","C++","HTML","Markdown","R"))
mean_file3<-mean_file2 %>%
  arrange(desc(mean))
mean_file3$labels=factor(mean_file3$labels,levels=c("R","C++","C","HTML","Markdown"))

ggplot(mean_file3,aes(x=labels,y=mean))+geom_col(fill="lightblue",color="darkblue")+
  labs(title="Mean Number of Files in Top 5 Occuring Languages",x="Language",y="Mean Files per Package")+
  theme_classic()

#################################################################################################