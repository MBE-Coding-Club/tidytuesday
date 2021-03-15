setwd("C:/Users/mbryk/Documents/RSMAS/Tidy Tuesday")

dog_moves<-readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-12-17/dog_moves.csv')
dog_travel<-readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-12-17/dog_travel.csv')
dog_descriptions<-readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-12-17/dog_descriptions.csv')

library(tidyverse)

View(dog_moves)
View(dog_travel)
View(dog_descriptions)

########################################################################################################
#Top States with Adoptable Dogs
ByLocation<-dog_moves %>%
  arrange(desc(total)) %>%
  filter(total>1000) 

ByLocation<-cbind(ByLocation,state=ByLocation$location)
ByLocation$state=factor(ByLocation$state,levels=ByLocation$state)

ggplot(ByLocation,aes(x=state,y=total))+
  geom_col(fill="darkred")+
  labs(x="State",y="Count",title="Top States with Adoptable Dogs")+
  theme_classic()+
  coord_flip()

#########################################################################################################
#Top International Countries
ByCountry<-dog_moves %>%
  filter(inUS==FALSE) %>%
  arrange(desc(exported)) %>%
  filter(exported>10)

ByCountry<-cbind(ByCountry,country=ByCountry$location)
ByCountry$country=factor(ByCountry$country,levels=ByCountry$country)

ggplot(ByCountry,aes(x=country,y=exported))+
  geom_col(fill="darkblue")+
  labs(x="Country",y="Count",title="Top Countries with Exported Dogs")+
  theme_classic()+
  coord_flip()

########################################################################################################
#Top Dog Breeds
ByBreed<-dog_descriptions %>%
  count(breed_primary,sort=TRUE) %>%
  top_n(15,n) %>%
  rename(prime=n)
ByBreed2<-dog_descriptions %>%
  count(breed_secondary,sort=TRUE) %>%
  top_n(15,n) %>%
  rename(second=n)

#ByBreed3<-data.frame(breed=cbind(ByBreed$breed_primary,ByBreed2$breed_secondary))


ggplot(ByBreed,aes(x=c(breed_primary,breed_secondary),y=c(prime,second)))+
  geom_col(fill=c("lightblue","darkblue"))+
  coord_flip()