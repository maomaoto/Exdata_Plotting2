## Coursera Exploratory Data Analysis
## Course Project 2
## plot3.R
## Emission in the Baltimore City from different source

# Assume the data set is in the working directory
# Read data and source classification code
NEI<- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Extract Baltimore data
NEI_Bal <- NEI[NEI$fips==24510,]
# Create "TypeYear" column for calculation
NEI_Bal$TypeYear <- paste(NEI_Bal$type, NEI_Bal$year)
# Calculate sum with respect Type and Year
NEI_type_year <- with(NEI_Bal, tapply(Emissions, TypeYear, sum))
# Transform into data frame and modify col names
NEI_type_year <- data.frame(NEI_type_year)
names(NEI_type_year) <- "Emissions"
# Add Year and Type into data frame for plot
type_year <- matrix(unlist(strsplit(rownames(NEI_type_year), " ")), ncol=2, byrow=TRUE)
NEI_type_year$type <- type_year[,1]
NEI_type_year$year <- type_year[,2]


# import ggplot2
library(ggplot2)


# Create png device
png(filename="plot3.png", width=960, height=480)

# Plot
qplot(year, Emissions, data=NEI_type_year, facets=.~type, ylab="Emissions (tons)") + labs(title=expression(PM[2.5] * " Emissions in Baltimore with different types"))

# Close png device
dev.off()

