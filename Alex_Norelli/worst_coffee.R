coffee_ratings <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-07-07/coffee_ratings.csv')

unique(coffee_ratings$species)

library("patchwork")
library(tidyverse)

ggplot(coffee_ratings, aes(species)) + geom_bar() + ggtitle("How Many Coffees of Each Species?") + theme_classic()

test <- arrange(coffee_ratings, total_cup_points, species)

arabica <- filter(test, species == "Arabica")
robusta <- filter(test, species == "Robusta")

head(robusta)

w10a <- slice(arabica, 2:11)
w10r <- slice(robusta, 1:10)

worstAmean <- mean(w10a$total_cup_points)
worstRmean <- mean(w10r$total_cup_points)

df <- rbind(w10a, w10r)

ggplot(df, aes(total_cup_points, species)) + geom_boxplot() + coord_flip() + xlab("Species") + ylab("Total Cup Points") + ggtitle("A comparison of the 10 worst coffees")

ggplot(df, aes(country_of_origin)) + geom_bar(aes(color = species, fill = species)) + coord_flip() + xlab("Species") + ylab("Total Cup Points") + ggtitle("A comparison of the 10 worst coffees")

## set the levels in order we want
theTable <- within(df, 
                   country_of_origin <- factor(country_of_origin, 
                                      levels=names(sort(table(country_of_origin), 
                                                        decreasing=FALSE))))
## plot
ggplot(theTable,aes(x=country_of_origin))+ geom_bar(aes(color = species, fill = species)) + coord_flip() + xlab("Country") + ylab("# of worst coffees") + ggtitle("A comparison of the 10 worst coffees")


theTable2 <- within(arabica, 
                   country_of_origin <- factor(country_of_origin, 
                                               levels=names(sort(table(country_of_origin), 
                                                                 decreasing=FALSE))))
gg1 <- ggplot(theTable2,aes(x=country_of_origin))+ geom_bar(aes(color = species, fill = species)) + coord_flip() + xlab("Country") + ylab("# of worst coffees") + ggtitle("Arabica Coffees by Country")

theTable3 <- within(robusta, 
                    country_of_origin <- factor(country_of_origin, 
                                                levels=names(sort(table(country_of_origin), 
                                                                  decreasing=FALSE))))
gg2<- ggplot(theTable3,aes(x=country_of_origin))+ geom_bar(aes(color = species, fill = species)) + coord_flip() + xlab("Country") + ylab("# of worst coffees") + ggtitle("Robusta Coffees by Country")


gg1+gg2
