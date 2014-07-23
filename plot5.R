## Coursera Exploratory Data Analysis
## Course Project 2
## plot5.R
## Emissions from motor vehicle sources changed from 1999¡V2008 in Baltimore City

# Assume the data set is in the working directory
# Read data and source classification code
NEI<- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Extract Baltimore data
NEI_Bal <- NEI[NEI$fips==24510,]
# Use SCC On-Road for extracting motor vehicle source
SCC_onroad <- SCC[grepl("Mobile - On-Road", SCC$EI.Sector),]

NEI_Bal_onroad <- NEI_Bal[NEI_Bal$SCC %in% SCC_onroad$SCC,]


# Calcualte sum of each year
NEI_Bal_onroad <- with(NEI_Bal_onroad, tapply(Emissions, year, sum))

# Create png device
png(filename="plot5.png", width=480, height=480)

# Plot
plot(names(NEI_Bal_onroad), NEI_Bal_onroad, xlab="Year", ylab=expression(PM[2.5] * " Emissions (tons)"), xaxt="n", type="b", pch=16, lty=2, lwd=1, col="red")
axis(1,at=names(NEI_Bal_onroad))
title(main=expression(PM[2.5] * " Emissions of Motor Vehicles in Baltimore"))

# Close png device
dev.off()
