setwd("C:/Users/mbryk/Documents/RSMAS/tidytuesday/Marissa_Rykowski")
food_consumption<-readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-02-18/food_consumption.csv')
library(tidyverse)

########################################################################################################
food_consumption %>%
  mutate(total_consumption=NA) %>%
  mutate(total_emission=NA)

for (i in 1:130){
  food_consumption$total_consumption[food_consumption$country==food_consumption$country[i*11]]<-sum(food_consumption$consumption[food_consumption$country==food_consumption$country[i*11]])
  food_consumption$total_emission[food_consumption$country==food_consumption$country[i*11]]<-sum(food_consumption$co2_emmission[food_consumption$country==food_consumption$country[i*11]])
}

#########################################################################################################
Total_Cons<-food_consumption %>%
  group_by(country) %>%
  filter(food_category=="Pork") %>%
  arrange(desc(total_consumption)) %>%
  filter(total_consumption>475)

Total_Emis<-food_consumption %>%
  group_by(country) %>%
  filter(food_category=="Pork") %>%
  arrange(desc(total_emission)) %>%
  filter(total_emission>1475)

ggplot(Total_Cons,aes(x=country,y=total_consumption))+
  geom_col(fill="chocolate1")+
  labs(title="Total Food Consumption for Highest 15 Countries",x="Total Consumption",y="Country")+
  coord_flip()+
  theme_classic()

ggplot(Total_Emis,aes(x=country,y=total_emission))+
  geom_col(fill="chocolate4")+
  labs(title="Total CO2 Emissions for Highest 15 Countries",x="Total Emissions",y="Country")+
  coord_flip()+
  theme_classic()

######################################################################################################

Comp<-food_consumption %>%
  filter(food_category=="Pork") %>%
  arrange(country)
Comp$food_category<-NULL
Comp$consumption<-NULL
Comp$co2_emmission<-NULL

Comp_lm<-lm(total_emission~total_consumption,data=Comp)


ggplot(Comp,aes(x=total_consumption,y=total_emission))+
  geom_point(color="deepskyblue4")+
  labs(title="Total Consumption and Total CO2 Emissions",x="Total Consumption",y="Total Emissions")+
  theme_classic()+
  geom_abline(slope=2.706531,intercept=-18.674557)

      
