penguins.csv <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-07-28/penguins.csv')

library(tidyverse)
library(plyr)

mu <- penguins.csv %>% 
  filter(species == "Adelie") 
mean(mu$body_mass_g)

test <- penguins.csv %>% 
  filter(!is.na(body_mass_g))
mu <- ddply(test, "species", summarise, grp.mean=mean(body_mass_g))


a <- filter(species == "Adelie")


ggplot(data = penguins.csv, aes(body_mass_g, fill = species)) + 
  annotation_custom(g, xmin=4500, xmax=6500, ymin=12, ymax=18) +
  geom_histogram(position = "dodge")+
  xlab("Body Mass (g)") + 
  ylab("Count")+
  scale_fill_manual(values = c("#f77f0f", "#cc47ca", "#05777d" )) +
  scale_color_manual(values = c("#f77f0f", "#cc47ca", "#05777d" )) +
  theme(legend.position = "none") +
  geom_vline(data=mu, aes(xintercept=grp.mean, color=species), linetype="dashed")
  


gg1 <- penguins.csv %>% 
       filter(species == "Adelie") %>% 
       ggplot(aes(body_mass_g, fill = species)) +
       geom_histogram()
gg2 <- penguins.csv %>% 
  filter(species == "Gentoo") %>% 
  ggplot(aes(body_mass_g, fill = species)) +
  geom_histogram()
gg3 <- penguins.csv %>% 
  filter(species == "Chinstrap") %>% 
  ggplot(aes(body_mass_g, fill = species)) +
  annotation_custom(g, xmin=2600, xmax=3400, ymin=6, ymax=8) +
  geom_histogram()


gg1
gg2
gg3

install.packages("png")
install.packages("grid")

library(png)
library(grid)
library(ggplot2)

img <- readPNG("lter_penguins.png")
g <- rasterGrob(img, interpolate=TRUE)

qplot(x=sample(1:10,20,replace=TRUE), geom="blank") +
  annotation_custom(g, xmin=4.5, xmax=5.5, ymin=3, ymax=4) +
  geom_bar()
