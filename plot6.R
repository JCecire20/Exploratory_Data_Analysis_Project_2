#Set working directory
setwd("~/Documents/GitHub/Exploratory_Data_Analysis_Project_2")

#Read in the data
NEI <- readRDS("exdata-data-NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("exdata-data-NEI_data/Source_Classification_Code.rds")

#Question 6: Compare emissions from motor vehicle sources in Baltimore City 
#with emissions from motor vehicle sources in Los Angeles County, California (fips == "06037").
#Which city has seen greater changes over time in motor vehicle emissions?

##Plot 6: 
library(ggplot2)

#Subset Motor Vehicle-related data for both Baltimore and LA
subBALT <- NEI[NEI$fips=="24510" & NEI$type=="ON-ROAD",  ]
subLA <- NEI[NEI$fips=="06037" & NEI$type=="ON-ROAD",  ]
#Decided to subset by "ON-ROAD" because we are just looking for motor vehicles like Cars 
#and trucks that drive on the highway. If we were looking for any vehicle we would
#have merged NEI and SCC, then subset on SCC.Level.Two using grepl to find "vehicle".
mv.baltEmissions <- aggregate(Emissions ~ year, subBALT, sum)
mv.laEmissions <- aggregate(Emissions ~ year, subLA, sum)

#Added a column to both the Balt emissions data and La emissions data so that 
#you can identify which year and emission values belong to which location.
mv.baltEmissions$Location <- "Baltimore City, MD"
mv.laEmissions$Location <- "Los Angeles County, CA"

#Combined Balt and La emissions data sets into one so that you can graph them 
#and seperate on the newly created Location column.
mv.bothEmissions <- rbind(mv.baltEmissions, mv.laEmissions)

png("plot6.png", width=640, height=480)

ggplot(mv.bothEmissions, aes(x=factor(year), y=Emissions, fill=Location,
                             label = round(Emissions,2))) +
    geom_bar(stat="identity") + 
    facet_grid(Location~., scales="free") +
    xlab("year") +
    ylab(expression("total PM"[2.5]*" emissions in tons")) +
    ggtitle(expression("Baltimore vs. Los Angeles Motor Vehicle Emissions from 1999-2008")) +
    geom_label(aes(fill = Location), color = "white", fontface = "bold")

dev.off()
