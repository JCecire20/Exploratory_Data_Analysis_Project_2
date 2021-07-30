#Set working directory
setwd("~/Documents/GitHub/Exploratory_Data_Analysis_Project_2")

#Read in the data
NEI <- readRDS("exdata-data-NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("exdata-data-NEI_data/Source_Classification_Code.rds")

#Question 2: Have total emissions from PM2.5 decreased in
#Baltimore City, Maryland (fips == "24510") from 1999 to 2008? 
#Use the base plotting system to make a plot answering this question.

##Plot 2:  Total emissions of PM2.5 in Baltimore City, Maryland from 1999 to 2008
# Subset NEI data by Baltimore's fip.
baltData <- NEI[NEI$fips=="24510",]
baltEmissions <- aggregate(Emissions ~ year, baltData,sum)

png("plot2.png", width=480, height=480)

bE <- barplot(height=baltEmissions$Emissions/1000, names.arg = baltEmissions$year
              , col=c("black","blue","purple","red")
              , ylim = range(0,4)
              , main=expression('Total Baltimore PM'[2.5]*' Emissions from 1999 to 2008 in Kilotons')
              , ylab = expression('PM'[2.5]*' in Kilotons')
              , xlab = "Year")
## Adding text at the top of bars for clarity
text(x = bE, y = round(baltEmissions$Emissions/1000,2)
     , label = round(baltEmissions$Emissions/1000,2) 
     , col = "black"
     , pos = 3)

dev.off()