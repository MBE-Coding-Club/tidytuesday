# Get the Data

tbi_age <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-03-24/tbi_age.csv')
tbi_year <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-03-24/tbi_year.csv')
tbi_military <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-03-24/tbi_military.csv')
  
injuries_by_age <- tbi_age %>% 
  drop_na() %>%
  arrange(age_group) %>% 
  filter(age_group != "Total")

ggplot(data=injuries_by_age, aes(x=age_group,y=number_est, fill=injury_mechanism))+
  geom_col() + theme_classic() +
  xlab("Age Group") +
  ylab("Number of Cases")+ 
  scale_y_continuous(format(x,scientific=FALSE))
