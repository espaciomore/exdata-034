require(grDevices)
require(ggplot2)

# Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
# which of these four sources have seen decreases in emissions from 1999-2008 for Baltimore City? 
# Which have seen increases in emissions from 1999-2008? 
# Use the ggplot2 plotting system to make a plot answer this question.

NEI <- readRDS("summarySCC_PM25.rds")
# SCC <- readRDS("Source_Classification_Code.rds")

selectedData <- NEI[(NEI$year >= 1999) &  (NEI$year <= 2008) & (NEI$fips == "24510"), c("Emissions", "year", "type")]
selectedData <- data.frame( year=factor(selectedData$year), Emissions=selectedData$Emissions, type=selectedData$type)
selectedData <- aggregate(selectedData$Emissions, by=list(year=selectedData$year, type=selectedData$type), FUN=sum)
colnames(selectedData) <- c("year", "type", "Emissions")

png(file="plot3.png",width=480,height=480)

graph <- ggplot(selectedData, aes(x=year,y=Emissions, color = type, group = type)) + xlab("Year") + ylab("PM2.5 Emissions (Tons)") + ggtitle("Total Annual PM2.5 Emission in Baltimore City, MD")
graph + geom_point() + geom_smooth(se = FALSE, method = "lm") + theme_bw() + theme(plot.title = element_text(size = rel(1.5), vjust=2))

dev.off()