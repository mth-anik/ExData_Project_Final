#How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

library(dplyr)

nei <- readRDS("summarySCC_PM25.rds")
scc <- readRDS("Source_Classification_Code.rds")

motor_scc<-scc[grepl('vehicles',scc$EI.Sector,ignore.case = TRUE),]
motor_nei<-subset(nei,nei$SCC %in% motor_scc$SCC)
motor_nei_balt<-subset(motor_nei,motor_nei$fips=='24510')

motor_nei_balt_grp<-group_by(motor_nei_balt,year)
total_emsn<-summarise(motor_nei_balt_grp,sum(Emissions))
names(total_emsn)[2]<-'total_emission'
yval<-seq(min(total_emsn$total_emission),max(total_emsn$total_emission),length.out = 5)

with(total_emsn,plot(year,total_emission,type = 'l',axes = FALSE,ylab = 'Total emission(tons)'))
axis(1,at=total_emsn$year)
axis(2,at=round(yval))
title(main = 'Change in emission of motor sources in Baltimore')

dev.copy(png,file='plot5.png')
dev.off()
