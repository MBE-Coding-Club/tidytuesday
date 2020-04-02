setwd("C:/Users/mbryk/Documents/RSMAS/Tidy Tuesday")
nz_bird<-readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-11-19/nz_bird.csv")
library(tidyverse)

#######################################################################################################
#top voted for birds (total votes)
species_set<-nz_bird %>%
  count(bird_breed,sort=T) %>%
  filter(bird_breed != "NA") %>%
  top_n(5,n)
  
species_set<-cbind(species_set,species=species_set$bird_breed)
species_set$species=factor(species_set$species,levels=species_set$species)

ggplot(species_set,aes(x=species,y=n))+geom_col(fill="orange")+
  labs(title="Top Five Birds (not adjusted for rank)",x="Bird Breed",y="Count")+theme_classic()

########################################################################################################
#top birds at rank 1
rank_species<-nz_bird %>%
  filter(vote_rank=="vote_1") %>%
  count(bird_breed,sort=T) %>%
  top_n(5,n)
rank_species<-cbind(rank_species,species=rank_species$bird_breed)
rank_species$species=factor(rank_species$species,levels=rank_species$species)

ggplot(rank_species,aes(x=species,y=n))+geom_col(fill="orange")+
  labs(title="Top Five Birds (voted as rank 1)",x="Bird Breed",y="Count")+theme_classic()

#####################################################################################################
#number of votes per day
data_vote<-nz_bird %>%
  count(date,sort=T) %>%
  arrange(date)
data_vote$n<-data_vote$n/5

ggplot(data_vote,aes(x=date,y=n))+geom_col(fill="magenta")+
  labs(title="Voting Frequency",x="Date",y="Count")+theme_classic()

#####################################################################################################
#top vote per day
date_range<-data_vote$date
date_species<-data.frame()
for (i in 1:length(date_range)){
  holder<-nz_bird %>%
    filter(date==date_range[i]) %>%
    count(bird_breed,sort=T) %>%
    filter(bird_breed != "NA") %>%
    top_n(1,n)
  date_species[i,1]<-date_range[i]
  date_species[i,2]<-holder$bird_breed
  date_species[i,3]<-holder$n
}
names(date_species)<-c("Date","Breed","Votes")

ggplot(date_species,aes(x=Date,y=Votes,fill=Breed))+geom_col()+labs(title="Top Votes per Day",y="Count")+
  theme_classic()
