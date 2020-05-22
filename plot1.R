# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
#Using the base plotting system, make a plot showing the total PM2.5 emission from 
#all sources for each of the years 1999, 2002, 2005, and 2008.

#reading data
library(dplyr)
nei <- readRDS("summarySCC_PM25.rds")

#grouping data into packages according to years and summing total emissions of each year
nei_pack_year<-group_by(nei,year)
total_per_year<-summarise(nei_pack_year,sum(Emissions))
names(total_per_year)[2]<-'total_emission'

#plotting with base plotting system
with(total_per_year,plot(year,total_emission,type = 'l',axes = FALSE,ylab = 'Total emission(tons)'))
axis(1,at=total_per_year$year)
yval<-seq(min(total_per_year$total_emission),max(total_per_year$total_emission),length.out = 3)
axis(2,at=yval)
title(main = 'Change in total emission accross 9 years')

#converting the plot into a png file
dev.copy(png,file='plot1.png')
dev.off()

