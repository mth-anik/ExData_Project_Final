#Compare emissions from motor vehicle sources in Baltimore City
#with emissions from motor vehicle sources in Los Angeles County, California (fips = "06037").
#Which city has seen greater changes over time in motor vehicle emissions?

library(dplyr)
library(ggplot2)

nei <- readRDS("summarySCC_PM25.rds")
scc <- readRDS("Source_Classification_Code.rds")

motor_scc<-scc[grepl('vehicles',scc$EI.Sector,ignore.case = TRUE),]
motor_nei<-subset(nei,nei$SCC %in% motor_scc$SCC)

motor_balt<-subset(motor_nei,motor_nei$fips=='24510')
motor_la<-subset(motor_nei,motor_nei$fips=='06037')

balt_grp<-group_by(motor_balt,year)
la_grp<-group_by(motor_la,year)
balt_ems<-summarise(balt_grp,sum(Emissions))
la_ems<-summarise(la_grp,sum(Emissions))
names(balt_ems)[2]<-'total_emission'
names(la_ems)[2]<-'total_emission'

total_ems<-rbind(balt_ems,la_ems)
total_ems[1:4,3]<-'Baltimore'
total_ems[5:8,3]<-'Los Angeles'
names(total_ems)[3]<-'city'

g<-ggplot(total_ems,aes(year,total_emission))
g+geom_line()+facet_grid(.~city)+scale_x_continuous(breaks=c(1999,2002,2005,2008))

dev.copy(png,file='plot6.png')
dev.off()