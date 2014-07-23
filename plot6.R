## Coursera Exploratory Data Analysis
## Course Project 2
## plot6.R
## Compare emissions from motor vehicle sources in Baltimore City(fips == "24510) and Los Angeles County (fips=="06037")

# Assume the data set is in the working directory
# Read data and source classification code
NEI<- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Extract data for Baltimore and Los Angeles
NEI_BL <- NEI[grepl("24510|06037", NEI$fips),]

# Use SCC On-Road for extracting motor vehicle source
SCC_onroad <- SCC[grepl("Mobile - On-Road", SCC$EI.Sector),]
NEI_BL_onroad <- NEI_BL[NEI_BL$SCC %in% SCC_onroad$SCC,]

# Create fips_year for split
NEI_BL_onroad$fips_year <- with(NEI_BL_onroad, paste(fips, year))

# Calcualte sum of each year/fips
NEI_BL_onroad <- with(NEI_BL_onroad, tapply(Emissions, fips_year, sum))

# Transform into data frame and modify name
NEI_BL_onroad <- data.frame(NEI_BL_onroad)
names(NEI_BL_onroad) <- "Emissions"

# Add fips and year properties
fips_year <- matrix(unlist(strsplit(rownames(NEI_BL_onroad), " ")), ncol=2, byrow=TRUE)
NEI_BL_onroad$fips <- fips_year[,1]
NEI_BL_onroad$year <- fips_year[,2]

# Normalize with data of 1998 for comparing the variation
base <- rep(NEI_BL_onroad$Emissions[c(1,5)], each=4)
NEI_BL_onroad$ratio <- NEI_BL_onroad$Emissions/base
NEI_BL_onroad$year <- as.numeric(NEI_BL_onroad$year)

# Add location name for plot
NEI_BL_onroad$location[NEI_BL_onroad$fips=="06037"] <- "Los Angeles"
NEI_BL_onroad$location[NEI_BL_onroad$fips=="24510"] <- "Baltimore"

# Create png device
png(filename="plot6.png", width=600, height=480)

# Plot
g <- ggplot(NEI_BL_onroad, aes(year, ratio))
g + geom_line(aes(color=location)) + geom_point(aes(color=location)) + labs(title="Emission Variation of Motor Vehicle in Baltimore and Los Angeles") + labs(y="Emissions (ratio)")

# Close png device
dev.off()
