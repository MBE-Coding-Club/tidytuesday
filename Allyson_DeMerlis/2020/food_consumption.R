food_consumption <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-02-18/food_consumption.csv')

library(tidyverse)

ggplot(data = food_consumption) + 
  geom_point(mapping = aes(x = consumption, y = co2_emmission, color=food_category))

##USA 

USA <- filter(food_consumption, country == "USA") 

barplot_USA <- ggplot(USA, aes(x="", y=co2_emmission, fill=food_category))+
  geom_bar(width = 1, stat = "identity")
barplot_USA

pie_USA <- barplot_USA + coord_polar("y", start=0) + scale_fill_brewer(palette="RdBu")+
  labs(x="", y="CO2 Emissions", fill="Food Category") 


##Argentina

Argentina <- filter(food_consumption, country == "Argentina")
barplot_Arg <- ggplot(Argentina, aes(x="", y=co2_emmission, fill=food_category))+
  geom_bar(width = 1, stat = "identity")
barplot_Arg

pie_Arg <- barplot_Arg + coord_polar("y", start=0) + scale_fill_brewer(palette="RdYlBu")+
  labs(x="", y="CO2 Emissions", fill="Food Category") 

##Brazil

Brazil <- filter(food_consumption, country == "Brazil")
barplot_Bra <- ggplot(Brazil, aes(x="", y=co2_emmission, fill=food_category))+
  geom_bar(width = 1, stat = "identity") 
barplot_Bra

pie_Bra <- barplot_Bra + coord_polar("y", start=0) + scale_fill_brewer(palette="YlGn") + 
  labs(x="", y="CO2 Emissions", fill="Food Category") 

##Australia

Australia <- filter(food_consumption, country == "Australia")
barplot_Aus <- ggplot(Australia, aes(x="", y=co2_emmission, fill=food_category))+
  geom_bar(width = 1, stat = "identity")
barplot_Aus

pie_Aus <- barplot_Aus + coord_polar("y", start=0) + scale_fill_brewer(palette="Reds") +
  labs(x="", y="CO2 Emissions", fill="Food Category") 

## plot all 4 plots together

install.packages("cowplot")

library(cowplot)

plot_grid(pie_Arg,pie_Bra,pie_USA,pie_Aus, labels = c('Argentina','Brazil','USA','Australia'))



