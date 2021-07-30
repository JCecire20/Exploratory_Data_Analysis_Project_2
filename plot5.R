#Set working directory
setwd("~/Documents/GitHub/Exploratory_Data_Analysis_Project_2")

#Read in the data
NEI <- readRDS("exdata-data-NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("exdata-data-NEI_data/Source_Classification_Code.rds")

#Question 5: How have emissions from motor vehicle sources 
#changed from 1999–2008 in Baltimore City?

##Plot 5: 
library(ggplot2)

#Subset Motor Vehicle-related data
subNEI <- NEI[NEI$fips=="24510" & NEI$type=="ON-ROAD",  ]
#Decided to subset by "ON-ROAD" because we are just looking for motor vehicles like Cars 
#and trucks that drive on the highway. If we were looking for any vehicle we would
#have merged NEI and SCC, then subset on SCC.Level.Two using grepl to find "vehicle".
mvEmissions <- aggregate(Emissions ~ year, subNEI, sum)

#Using a line plot because we are looking at changes over time.
png("plot5.png", width=640, height=480)

ggMV <- ggplot(mvEmissions, aes(year, round(Emissions,2), color=year))
ggMV <- ggMV + geom_line(size = 1.2) +
    geom_point(size = 1.7) +
    geom_text(aes(label = round(Emissions, 2)), 
              hjust=-.25, nudge_y = 10, nudge_x = -0.2, size=3.5) +
    xlab("year") +
    ylab(expression("Total PM"[2.5]*" Emission (tons)")) + 
    ggtitle(expression("Baltimore Motor Vehicle Emissions from 1999-2008"))

print(ggMV)

dev.off()