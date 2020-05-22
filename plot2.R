#Have total emissions from PM2.5 decreased in the Baltimore City, 
#Maryland (fips == "24510") from 1999 to 2008? 
#Use the base plotting system to make a plot answering this question.

library(dplyr)
nei <- readRDS("summarySCC_PM25.rds")

city_dat<-subset(nei,nei$fips==24510)
city_dat_pack_year<-group_by(city_dat,year)
total_per_year<-summarise(city_dat_pack_year,sum(Emissions))
names(total_per_year)[2]<-'total_emission'

with(total_per_year,plot(year,total_emission,type = 'l',axes = FALSE,ylab = 'Total emission(tons)'))
axis(1,at=total_per_year$year)
axis(2,at=round(total_per_year$total_emission),las=2)
title(main = 'Change of emission in Baltimore City accross 9 years')

dev.copy(png,file='plot2.png')
dev.off()