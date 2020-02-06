setwd("C:/Users/mbryk/Documents/RSMAS/Tidy Tuesday")
tickets<-readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-12-03/tickets.csv")
library(tidyverse)
library(lubridate)

View(tickets)

###########################################################################################################
#Top Ticket Issuing Agencies
ByAgency<-tickets %>%
  count(issuing_agency,sort=TRUE) %>%
  mutate(n=log(n)) %>%
  top_n(5,n) 

ByAgency<-cbind(ByAgency,agency=ByAgency$issuing_agency)
ByAgency$agency<-factor(ByAgency$agency,levels=ByAgency$agency)

ggplot(ByAgency,aes(x=agency,y=n))+
  geom_col(fill="blue")+
  labs(x="Issuing Agency",y="Log(Count)",title="Top Ticket Issuing Agencies")+
  theme_classic()

##########################################################################################################
#Top Ticket Violation Descriptions
ByViolation<-tickets %>%
  count(violation_desc,sort=TRUE) %>%
  top_n(5,n)

ByViolation<-cbind(ByViolation,violation=ByViolation$violation_desc)
ByViolation$violation<-factor(ByViolation$violation,levels=ByViolation$violation)

ggplot(ByViolation,aes(x=violation,y=n))+geom_col(fill="red")+
  labs(x="Violation Description",y="Count",title="Top Ticket Violations")+
  theme_classic()

#########################################################################################################
#Tickets Issued by Zip Code
ByZip<-tickets %>%
  count(zip_code,sort=TRUE) %>%
  filter(zip_code != "NA")

ggplot(ByZip,aes(x=zip_code,y=n))+
  geom_col(fill="purple")+
  labs(x="Zip Code",y="Count",title="Top Zip Codes with Issued Tickets")+
  theme_classic()

#########################################################################################################
#Ticketing by Month
tickets<-cbind(tickets,Months=month(tickets$issue_datetime,label=TRUE))
ByMonth<-tickets %>%
  count(Months,sort=TRUE) %>%
  arrange(Months)

ggplot(data=ByMonth,aes(x=Months,y=n,group=1))+
  geom_line(color="magenta",size=2)+
  geom_point(color="black",size=2)+
  labs(x="Month",y="Count",title="Tickets Issued Per Month")+
  theme_classic()

#########################################################################################################
#Ticketing by Date
tickets<-cbind(tickets,Date=date(tickets$issue_datetime))
ByDate<-tickets %>%
  count(Date,sort=TRUE) %>%
  arrange(Date)

ggplot(data=ByDate,aes(x=Date,y=n,group=1))+
  geom_line(color="yellow")+
  labs(x="Day",y="Count",title="Tickets Issued Per Day")+
  theme_classic()

#########################################################################################################
#
