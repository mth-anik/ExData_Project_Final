#Have total emissions from PM2.5 decreased in the Baltimore City, 
#Maryland (fips == "24510") from 1999 to 2008? 
#Use the base plotting system to make a plot answering this question.

#reading data
library(dplyr)
nei <- readRDS("summarySCC_PM25.rds")

#subsetting the data of baltimore city
city_dat<-subset(nei,nei$fips==24510)
#grouping data into packages according to years and summing total emissions of each year
city_dat_pack_year<-group_by(city_dat,year)
total_per_year<-summarise(city_dat_pack_year,sum(Emissions))
names(total_per_year)[2]<-'total_emission'

#plotting with base plotting system
with(total_per_year,plot(year,total_emission,type = 'l',axes = FALSE,ylab = 'Total emission(tons)'))
axis(1,at=total_per_year$year)
axis(2,at=round(total_per_year$total_emission),las=2)
title(main = 'Change of emission in Baltimore City accross 9 years')

#converting the plot into a png file
dev.copy(png,file='plot2.png')
dev.off()
