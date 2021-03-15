setwd("C:/Users/mbryk/Documents/RSMAS/Tidy Tuesday")
spotify_songs<-readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-01-21/spotify_songs.csv')
library(tidyverse)
library(lubridate)

spotify_songs<-spotify_songs %>%
  arrange(desc(track_popularity)) %>%
  distinct(.,track_id,.keep_all=TRUE)

#######################################################################################################
#by subgenre
TopSubgenre<-spotify_songs %>%
  count(playlist_subgenre,sort=T) %>%
  top_n(10,n)

TopSubgenre<-cbind(TopSubgenre,playlist=TopSubgenre$playlist_subgenre)
TopSubgenre$playlist=factor(TopSubgenre$playlist,levels=TopSubgenre$playlist)

for (i in 1:10){
  holder<- spotify_songs %>% filter(playlist_subgenre==TopSubgenre$playlist_subgenre[i])
  TopSubgenre$Genre[i]<-holder$playlist_genre[i]
}

ggplot(TopSubgenre,aes(x=playlist,y=n,fill=Genre))+
  geom_col()+
  labs(title="Top 10 Subgenres",x="Subgenre Playlist",y="Count")+
  coord_flip()+
  theme_classic()

###################################################################################################
#danceability
ggplot(spotify_songs,aes(danceability))+
  geom_histogram(fill="chartreuse4",binwidth=0.05)+
  labs(title="Danceability Scores",x="Danceability",y="")+
  theme_classic()

DanceScore<-spotify_songs %>%
  filter(danceability>0.971) %>%
  arrange(desc(danceability)) 

#####################################################################################################
#average danceability score
ByGenre<-spotify_songs %>%
  group_by(playlist_genre) %>%
  summarize(avgDance=mean(danceability))

#average track popularity
ByPopular<-spotify_songs %>%
  group_by(playlist_genre) %>%
  summarize(avgPop=mean(track_popularity))

#average energy
ByEnergy<-spotify_songs %>%
  group_by(playlist_genre) %>%
  summarize(avgEnergy=mean(energy))

#average speechiness
BySpeech<-spotify_songs %>%
  group_by(playlist_genre) %>%
  summarize(avgSpeech=mean(speechiness))

plot1<-ggplot(ByGenre,aes(x=playlist_genre,y=avgDance))+geom_col()+labs(title="Danceability",x="",y="")+theme_classic()
plot2<-ggplot(ByPopular,aes(x=playlist_genre,y=avgPop))+geom_col()+labs(title="Popularity",x="",y="")+theme_classic()
plot3<-ggplot(ByEnergy,aes(x=playlist_genre,y=avgEnergy))+geom_col()+labs(title="Energy",x="",y="")+theme_classic()
plot4<-ggplot(BySpeech,aes(x=playlist_genre,y=avgSpeech))+geom_col()+labs(title="Speechiness",x="",y="")+theme_classic()

grid.arrange(plot1,plot2,plot3,plot4,nrow=2,top="Average Scores",bottom="Genre",left="Score")

########################################################################################################
#change in duration over time
ggplot(data=spotify_songs,aes(x=track_album_release_date,y=duration_ms))+
  geom_line()
  

ByDate<-tickets %>%
  count(Date,sort=TRUE) %>%
  arrange(Date)

ggplot(data=ByDate,aes(x=Date,y=n,group=1))+
  geom_line(color="yellow")+
  labs(x="Day",y="Count",title="Tickets Issued Per Day")+
  theme_classic()

#####################################################################################################
#tracks released per month
strptime(spotify_songs$track_album_release_date, format="%Y-%m-%d")
ByMonth<-spotify_songs %>%
  filter(track_album_release_date != "NA")

ggplot(data=ByMonth,aes(x=Months,y=n,group=1))+
  geom_line(color="magenta",size=2)+
  geom_point(color="black",size=2)+
  labs(x="Month",y="Count",title="Tickets Issued Per Month")+
  theme_classic()