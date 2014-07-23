## Coursera Exploratory Data Analysis
## Course Project 2
## plot2.R
## Total Emission in the Baltimore City in each year

# Assume the data set is in the working directory
# Read data and source classification code
NEI<- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Extract Baltimore data
NEI_Bal <- NEI[NEI$fips==24510,]
# Calculate the sum in each year
NEI_year <- tapply(NEI_Bal$Emissions, NEI_Bal$year, sum)

# Create png device
png(filename="plot2.png", width=480, height=480)

# Plot
plot(names(NEI_year), NEI_year, xlab="Year", ylab=expression(PM[2.5] * " Emissions (tons)"), xaxt="n", type="b", pch=16, lty=2, lwd=1, col="red")
axis(1,at=names(NEI_year))
title(main=expression(PM[2.5] * " Emissions in the Baltimore City"))

# Close png device
dev.off()

