require(grDevices)

# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
# Using the base plotting system, make a plot showing the total PM2.5 emission from 
# all sources for each of the years 1999, 2002, 2005, and 2008.

NEI <- readRDS("summarySCC_PM25.rds")
# SCC <- readRDS("Source_Classification_Code.rds")

selectedData <- NEI[(NEI$year >= 1999) &  (NEI$year <= 2008), c("Emissions", "year")]
selectedData <- data.frame( year=factor(selectedData$year), Emissions=selectedData$Emissions )
selectedData <- aggregate(selectedData$Emissions, by=list(year=selectedData$year), FUN=sum)

selectedData$year <- as.numeric(levels(selectedData$year))

png(file="plot1.png",width=480,height=480)

plot(x=selectedData$year, y=selectedData$x, col = "purple", pch = 19, xlab = "Year", ylab = "PM2.5 Emissions (Tons)", main="Total Annual PM2.5 Emission")
abline(lm(x ~ year, data = selectedData), col = "purple")

dev.off()