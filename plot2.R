# Exploratory Data Analysis
# May 2015
#
# Project 1
# Plot 2
# Line plot of Global_active_power vs. Date_time

#
# Load packages
#

library(sqldf)
library(dplyr)
library(lubridate)


#
# Read the data
#

datafile <- file("./data/household_power_consumption.txt")
data <- tbl_df(sqldf('select * from datafile where "Date" in ("1/2/2007", "2/2/2007")',
                      file.format = list(sep = ";")))
close(datafile)


#
# Process the data
#

# create POSIX date_time field
#
# This ensures that the dates are plotted by default as day of the week,
# as required.
# Therefore, horizontal axis labels will not have to be set explicitly

data <- mutate(data,
               Date_time = dmy_hms(paste0(Date, "_", Time)))


#
# Plot 2.
#

# line plot of Global_active_power vs. Date_time

# open PNG device
# default height and width is 480x480 pixels
# default background is white
png("plot2.png")

# set for just 1 plot
par(mfrow = c(1, 1))

# plot the data
with(data, plot(Date_time, Global_active_power, 
                xlab = "",
                ylab = "Global Active Power (kilowatts)",
                type = "l"))

# close PNG device
dev.off()
