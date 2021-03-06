#Across the United States, 
#how have emissions from coal combustion-related sources changed from 1999–2008?

library(dplyr)

#reading data
nei <- readRDS("summarySCC_PM25.rds")
scc <- readRDS("Source_Classification_Code.rds")

#subsetting the data of coal related sources
coal_scc<-scc[grepl('coal',scc$EI.Sector,ignore.case = TRUE),]
coal_nei<-subset(nei,nei$SCC %in% coal_scc$SCC)

#grouping data into packages according to years and summing total emissions of each year
coal_nei_grp<-group_by(coal_nei,year)
total_emsn<-summarise(coal_nei_grp,sum(Emissions))
names(total_emsn)[2]<-'total_emission'
yval<-seq(min(total_emsn$total_emission),max(total_emsn$total_emission),length.out = 5)

#plotting with base plotting system
with(total_emsn,plot(year,total_emission,type = 'l',axes = FALSE,ylab = 'Total emission(tons)'))
axis(1,at=total_emsn$year)
axis(2,at=round(yval))
title(main = 'Change in total emission of coal related sources')

#converting the plot into a png file
dev.copy(png,file='plot4.png')
dev.off()
