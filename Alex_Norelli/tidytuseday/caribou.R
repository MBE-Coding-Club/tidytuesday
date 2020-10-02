# Get the Data

individuals <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-06-23/individuals.csv')
locations <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-06-23/locations.csv')

library(tidyverse)

case_when(
  
)

summarise(individuals, count = mean(Sepal.Length))

individuals$ss <- as.factor(individuals$study_site)

individuals %>% group_by(sex) %>% summarise(sum(ls))

i2 <- filter(individuals, !is.na(ls))

list <- c(10, 12, 2, 3, 4, 5, 6, 8)

individuals$life_stage <- as.numeric(as.character(individuals$life_stage))

for(i in 1:8){
  if(i2$ls == i){
    for(j in 1:67){
      i2$pregnant[j] = list[i]
    }
  }
}

if(i2$ls == 1){
  for(j in 1:67){
    i2$pregnant[j,] = list[i,]
  }
}

i2 %>% group_by(study_site) %>% summarise(mean(ls))

if(i2$life_stage[i] == "12-15"){
  for(j in 1:67){
    i2$pregnant[j] = 12
  }
}

count(individuals, life_stage)

individuals$ls <- as.factor(individuals$life_stage)



ggplot( individuals, aes(sex, study_site)) + geom_tile(aes(fill = ) )

