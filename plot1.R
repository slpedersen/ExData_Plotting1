# Exploratory Data Analysis
# May 2015
#
# Project 1
# Plot 1
# Histogram of Global_active_power

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
# Plot 1.
# 

# histogram of Global_active_power

# open PNG device
# default height and width is 480x480 pixels
# default background is white
png("plot1.png")

# set for just 1 plot
par(mfrow = c(1, 1))

# plot the data
with(data, hist(Global_active_power,
                col = "red",
                xlab = "Global Active Power (kilowatts)",
                main = "Global Active Power"))

# close PNG device.
dev.off()
