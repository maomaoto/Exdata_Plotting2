## Coursera Exploratory Data Analysis
## Course Project 2
## plot4.R
## Emissions from coal combustion-related sources in the US

# Assume the data set is in the working directory
# Read data and source classification code
NEI<- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Find SCC related to coal combustion
SCC_coal_comb <- SCC[grepl("Coal", SCC$Short.Name),]
SCC_coal_comb <- SCC_coal_comb[grepl("Combustion", SCC_coal_comb$SCC.Level.One),]

# Find Emissions corresponding to coal combustion related SCC
NEI_coal_comb <- NEI[NEI$SCC %in% SCC_coal_comb$SCC,]

# Calcualte sum of each year
NEI_coal_comb <- with(NEI_coal_comb, tapply(Emissions, year, sum))
NEI_coal_comb <- NEI_coal_comb/1000

# Create png device
png(filename="plot4.png", width=480, height=480)

# Plot
plot(names(NEI_coal_comb), NEI_coal_comb, xlab="Year", ylab=expression(PM[2.5] * " Emissions (thousand tons)"), xaxt="n", type="b", pch=16, lty=2, lwd=1, col="red")
axis(1,at=names(NEI_coal_comb))
title(main=expression(PM[2.5] * " Emissions of Coal Combustion"))

# Close png device
dev.off()
