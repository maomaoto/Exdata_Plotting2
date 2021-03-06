## Coursera Exploratory Data Analysis
## Course Project 2
## plot1.R
## Total Emission in each year

# Assume the data set is in the working directory
# Read data and source classification code
NEI<- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Calculate the sum in each year
NEI_year <- tapply(NEI$Emissions, NEI$year, sum)
# Change the scale to million tons
NEI_year <- NEI_year/10^6

# Create png device
png(filename="plot1.png", width=480, height=480)

# Plot
plot(names(NEI_year), NEI_year, xlab="Year", ylab="Total Emissions (million tons)", xaxt="n", type="b", pch=16, lty=2, lwd=1, col="red")
axis(1,at=names(NEI_year))
title(main=expression(PM[2.5] * " Total Emissions"))

# Close png device
dev.off()
