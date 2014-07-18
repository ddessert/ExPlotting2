# plot2.R - Code to generate plot2.png
# Coursera Exploratory Data Analysis
# Project 2
#
# Generate a plot showing whether Baltimore City, MD PM2.5 emissions from all sources
# has decreased bewtween 1999 and 2008

# Sourc data files
neiFile <- './data/summarySCC_PM25.rds'
# sccFile <- './data/Source_Classification_Code.rds'

# Read in data
nei <- readRDS(neiFile)
# scc <- readRDS(sccFile)

# Library for using function plyr::ddply
library(plyr)

# Compute PM2.5 Emissions for fips 24510 covering 1999 and 2008, totaling by year
yearly_emissions <- ddply(nei[nei$fips == '24510' & ((nei$year == 1999) | (nei$year == 2008)), ],
                          .(year), 
                          summarise, 
                          total=sum(Emissions))

# Open the png graphics device
png(filename='plot2.png',
    bg='transparent')

# Issue the plot command(s)
# Build list for multi-line graph title
titleLines <- list(bquote('All Sources'),
                   bquote('Baltimore City, MD PM'[2.5]*' Emissions'))

# Generate the bar plot
barplot(yearly_emissions$total/1e3,
        names.arg = yearly_emissions$year,
        xlab='Year',
        ylab=expression('Emissions (Kilotons)'),
        col=rgb(0.1,0.1,0.1,0.65))

# Add the multi-line graph title
mtext(do.call(expression, titleLines),side=3,line=0:1)

# Close the graphics device, causing the PNG file to be written
dev.off()