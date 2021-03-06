chopped <- readr::read_tsv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-08-25/chopped.tsv')

library(tidyverse)

case_when(
  if (chopped) judge1 == "Aar�n Sanchez" ~ "Aar�n Sanchez",
  if (chopped) judge1 == "Aar�n S�nchez" ~ "Aar�n Sanchez",
  TRUE
)

unique(chopped$judge1)

for(i in 1:569){
  if(chopped$judge1[i] == "Aar�n S�nchez"){
    chopped$judge1[i] <- "Aar�n Sanchez"
  }
}

unique(chopped$judge1)

ggplot(chopped, )

test <- chopped %>% separate(appetizer, c("A", "B", "C", "D"), sep = ",")

