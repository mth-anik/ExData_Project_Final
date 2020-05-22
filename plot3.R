#Of the 4 types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable
#which of these 4 sources have seen decreases in emissions from 1999–2008 for Baltimore City?
#Which have seen increases in emissions from 1999–2008?
#Use the ggplot2 plotting system to make a plot answer this question.


library(dplyr)
library(ggplot2)

#reading data
nei <- readRDS("summarySCC_PM25.rds")

#subsetting the data of baltimore city
city_dat<-subset(nei,nei$fips==24510)
#grouping data into packages according to years and summing total emissions of each year
city_grouped<-group_by(city_dat,type,year)
total_emissions<-summarise(city_grouped,sum(Emissions))
names(total_emissions)[3]<-'total_emission'

#plotting with ggplot2 package
g<-ggplot(data=total_emissions,aes(year,total_emission))
g+geom_line()+facet_grid(.~type)+scale_x_continuous(breaks=c(1999,2002,2005,2008))+theme(axis.text.x= element_text(angle = 45),axis.text.y= element_text(angle = 45))+labs(title = 'Emission in Baltimore City',y='Total Emission(tons)')

#converting the plot into a png file
dev.copy(png,file='plot3.png')
dev.off()
