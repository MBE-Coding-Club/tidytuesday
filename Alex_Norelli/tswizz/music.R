setwd("D:/Documents/RSMAS/Other Projects/Coding Club/tidytuseday/tswizz")

beyonce_lyrics <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-09-29/beyonce_lyrics.csv')
taylor_swift_lyrics <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-09-29/taylor_swift_lyrics.csv')
sales <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-09-29/sales.csv')
charts <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-09-29/charts.csv')

library("tidyverse")
install.packages("sjmisc")
library("sjmisc")


ts_last <- length(taylor_swift_lyrics$Lyrics[grep("last", taylor_swift_lyrics$Lyrics)])
ts_him <- length(taylor_swift_lyrics$Lyrics[grep("him", taylor_swift_lyrics$Lyrics)])
ts_together <- length(taylor_swift_lyrics$Lyrics[grep("together", taylor_swift_lyrics$Lyrics)])
ts_free <- length(taylor_swift_lyrics$Lyrics[grep("free", taylor_swift_lyrics$Lyrics)])
ts_pain <- length(taylor_swift_lyrics$Lyrics[grep("pain", taylor_swift_lyrics$Lyrics)])

ts_total <- sum(ts_last, ts_him, ts_together, ts_free, ts_pain)

#tried to do the same thing for beyonce:  

be_last <- length(beyonce_lyrics$line[grep("last", beyonce_lyrics$line)])
be_him <- length(beyonce_lyrics$line[grep("him", beyonce_lyrics$line)])
be_together <- length(beyonce_lyrics$line[grep("together", beyonce_lyrics$line)])
be_free <- length(beyonce_lyrics$line[grep("free", beyonce_lyrics$line)])
be_pain <- length(beyonce_lyrics$line[grep("pain", beyonce_lyrics$line)])

be_total <- sum(be_last, be_him, be_together, be_free, be_pain)

#doesn't work because beyonce's data is different so I made a forloop:  

tote_songs<- length(unique(beyonce_lyrics$song_id))
unique <- unique(beyonce_lyrics$song_id)
be <- 0
for(i in 1:tote_songs){
  song <- filter(beyonce_lyrics, song_id == unique[i])
  if(length(song$line[grep("last", song$line)]) > 1){
    be <- be + 1 
  }
}

be_last <- be

be <- 0
for(i in 1:tote_songs){
  song <- filter(beyonce_lyrics, song_id == unique[i])
  if(length(song$line[grep("him", song$line)]) > 1){
    be <- be + 1 
  }
}

be_him <- be

be <- 0
for(i in 1:tote_songs){
  song <- filter(beyonce_lyrics, song_id == unique[i])
  if(length(song$line[grep("together", song$line)]) > 1){
    be <- be + 1 
  }
}

be_together <- be

be <- 0
for(i in 1:tote_songs){
  song <- filter(beyonce_lyrics, song_id == unique[i])
  if(length(song$line[grep("free", song$line)]) > 1){
    be <- be + 1 
  }
}

be_free <- be

be <- 0
for(i in 1:tote_songs){
  song <- filter(beyonce_lyrics, song_id == unique[i])
  if(length(song$line[grep("pain", song$line)]) > 1){
    be <- be + 1 
  }
}

be_pain <- be

be_total <- sum(be_last, be_him, be_together, be_free, be_pain)

ts <- c(ts_last, ts_him, ts_together, ts_free, ts_pain)
be <- c(be_last, be_him, be_together, be_free, be_pain)
both <- c(ts,be)
id <-c("Taylor", "Taylor", "Taylor", "Taylor", "Taylor", "Beyonce", "Beyonce", "Beyonce", "Beyonce", "Beyonce") 
names <- c("last", "him", "together", "free", "pain")
dn <- c(names, names)
df <- data.frame(dn, id, both)



ggplot(df, aes(x = dn, y = both, fill = id)) + geom_bar(stat="identity", position=position_dodge())


