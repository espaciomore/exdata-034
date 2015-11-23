require(grDevices)

# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") 
# from 1999 to 2008? Use the base plotting system to make a plot answering this question.

NEI <- readRDS("summarySCC_PM25.rds")
# SCC <- readRDS("Source_Classification_Code.rds")

selectedData <- NEI[(NEI$year >= 1999) &  (NEI$year <= 2008) & (NEI$fips == "24510"), c("Emissions", "year")]
selectedData <- data.frame( year=factor(selectedData$year), Emissions=selectedData$Emissions )
selectedData <- aggregate(selectedData$Emissions, by=list(year=selectedData$year), FUN=sum)

selectedData$year <- as.numeric(levels(selectedData$year))

png(file="plot2.png",width=480,height=480)

plot(x=selectedData$year, y=selectedData$x, col = "orange", pch = 19, xlab = "Year", ylab = "PM2.5 Emissions (Tons)", main="Total Annual PM2.5 Emission in Baltimore City, MD")
abline(lm(x ~ year, data = selectedData), col = "orange")

dev.off()