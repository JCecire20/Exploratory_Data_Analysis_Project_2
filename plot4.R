#Set working directory
setwd("~/Documents/GitHub/Exploratory_Data_Analysis_Project_2")

#Read in the data
NEI <- readRDS("exdata-data-NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("exdata-data-NEI_data/Source_Classification_Code.rds")

#Question 4: Across the United States,how have emissions from 
#coal combustion-related sources changed from 1999–2008? 

##Plot 4: 
library(ggplot2)
#Merge NEI and SCC data set
#Note: This will take a few minutes so be patient
NEISCC <- merge(NEI, SCC, by="SCC")
#Subset Coal combustion-related data
coalData  <- grepl("coal", NEISCC$EI.Sector, ignore.case=TRUE)
subNEISCC <- NEISCC[coalData, ]
coalEmissions <- aggregate(Emissions ~ year, subNEISCC, sum)

#Using a line plot because we are looking at changes over time.
png("plot4.png", width=640, height=480)

ggCoal <- ggplot(coalEmissions, aes(year, round(Emissions/1000,2), color=year))
ggCoal <- ggCoal + geom_line(size = 1.2) +
    geom_point(size = 1.7) +
    geom_text(aes(label = round(Emissions/1000, 2)), 
              hjust=-.25, nudge_y = -5, nudge_x = -.5, size=3.5) +
    xlab("year") +
    ylab(expression("Total PM"[2.5]*" Emission (tons)")) + 
    ggtitle(expression("US Coal Combustion Emissions from 1999-2008"))

print(ggCoal)

dev.off()