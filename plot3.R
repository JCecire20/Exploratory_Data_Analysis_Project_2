#Set working directory
setwd("~/Documents/GitHub/Exploratory_Data_Analysis_Project_2")

#Read in the data
NEI <- readRDS("exdata-data-NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("exdata-data-NEI_data/Source_Classification_Code.rds")

#Question 3: Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
#which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? 
#Which have seen increases in emissions from 1999–2008? 
#Use the ggplot2 plotting system to make a plot answer this question.

## Plot 3: 
library(ggplot2)
# Subset NEI data by Baltimore's fip.
baltData <- NEI[NEI$fips=="24510",]
baltEmissions <- aggregate(Emissions ~ year + type, baltData,sum)

#Using a line plot because we are looking at changes over time.
png("plot3.png", width=480, height=480)

ggBalt <- ggplot(baltEmissions, aes(year, Emissions, color=type))
ggBalt <- ggBalt + geom_line(size = 1.2) +
    geom_point(size = 1.7) +
    xlab("year") +
    ylab(expression("Total PM"[2.5]*" Emission (Tons)")) + 
    ggtitle(expression("Baltimore PM"[2.5]*" Emissions, 1999-2008 by Source Type"))
   
print(ggBalt)
              
dev.off()