setwd("C:/Users/mbryk/Documents/RSMAS/tidytuesday/Marissa_Rykowski")

tuesdata <- tidytuesdayR::tt_load('2020-06-23')

individuals <- tuesdata$individuals
locations <- tuesdata$locations

################################################################################################

Sites <- individuals %>%
  count(study_site,sort=T)
Sites$study_site=factor(Sites$study_site,levels=Sites$study_site)

ggplot(Sites,aes(x=study_site,y=n,fill=n))+
  geom_bar(stat="identity")+
  labs(title="Caribou Tagged Per Study Site",x="Location",y="Total")+
  theme_classic()+
  theme(legend.position = "none")

######################################################################################################

Calves <- individuals %>%
  filter(with_calf != "NA")

#########################################################################################

Pregnancy <- individuals %>%
  filter(pregnant != "NA")

#################################################################################################

ggplot(locations,aes(x=longitude,y=latitude))+
  geom_point()

####################################################################################################

Indiv1 <- locations %>%
  filter(animal_id == "GR_C01") %>%
  group_by(season)

ggplot(Indiv1,aes(x=longitude,y=latitude))+
  geom_path(aes(color=timestamp))+
  theme_classic()+
  labs(title="Movement of Caribou GR_C01",x="Longitude",y="Latitude")
