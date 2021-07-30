#Set working directory
setwd("~/Documents/GitHub/Exploratory_Data_Analysis_Project_2")

#Read in the data
NEI <- readRDS("exdata-data-NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("exdata-data-NEI_data/Source_Classification_Code.rds")

#Question 1: Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
#Using the base plotting system, make a plot showing the total PM2.5 emission 
#from all sources for each of the years 1999, 2002, 2005, and 2008.

## Plot 1: Total emissions of PM2.5 from 1999 to 2008
totalEmissions <- aggregate(Emissions ~ year, NEI, sum)

png("plot1.png", width=480, height=480)

tE <- barplot(height=totalEmissions$Emissions/1000, names.arg = totalEmissions$year
     , col=c("black","blue","purple","red")
     , ylim = range(0,8000)
     , main=expression('Total PM'[2.5]*' Emissions from 1999 to 2008 in Kilotons')
     , ylab = expression('PM'[2.5]*' in Kilotons')
     , xlab = "Year")
## Adding text at the top of bars for clarity
text(x = tE, y = round(totalEmissions$Emissions/1000,2)
     , label = round(totalEmissions$Emissions/1000,2) 
     , col = "black"
     , pos = 3)

dev.off()