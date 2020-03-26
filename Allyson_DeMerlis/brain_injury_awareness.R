# Get the Data

tbi_age <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-03-24/tbi_age.csv')
tbi_year <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-03-24/tbi_year.csv')
tbi_military <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-03-24/tbi_military.csv')

militarydf <- tbi_military %>% 
  filter(component == "Active") %>% 
  group_by(year, service) %>% 
  mutate(total = sum(diagnosed))
  
ggplot(data=militarydf, aes(x=year, y=total)) +
  geom_line(aes(linetype=service))+
  geom_point()

totalinjuries <- tbi_year %>% 
  filter(injury_mechanism == "Total")

ggplot(data=totalinjuries, aes(x=year,y=rate_est, fill=type)) +
  geom_bar(stat="identity", position=position_dodge())
