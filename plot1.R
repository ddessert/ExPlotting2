# plot1.R - Code to generate plot1.png
# Coursera Exploratory Data Analysis
# Project 2
#
# Generate a plot showing total PM2.5 emissions from all sources
# for each of the years 1999, 2002, 2005, and 2008

# Sourc data files
neiFile <- './data/summarySCC_PM25.rds'
# sccFile <- './data/Source_Classification_Code.rds'

# Read in data
nei <- readRDS(neiFile)
# scc <- readRDS(sccFile)

# Library for using function plyr::ddply
library(plyr)

# Compute Emissions totals by year
yearly_emissions <- ddply(nei, .(year), summarise, total=sum(Emissions))

# Open the png graphics device
png(filename='plot1.png',
    bg='transparent')

# Issue the plot command(s)
# Build list for multi-line graph title
titleLines <- list(bquote('All Sources'),
                   bquote('Total PM'[2.5]*' Emissions'))
barplot(yearly_emissions$total/1e6,
        names.arg = yearly_emissions$year,
        xlab='Year',
        ylab=expression('Emissions (x10'^6*' tons)'),
#        main=expression('Total PM'[2.5]*' Emissions (All Sources)'),
        col=rgb(0.1,0.1,0.1,0.65))

# Generate multi-line graph title
mtext(do.call(expression, titleLines),side=3,line=0:1)

# Close the graphics device, causing the PNG file to be written
dev.off()