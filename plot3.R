# Exploratory Data Analysis
# May 2015
#
# Project 1
# Plot 3
# Line plot of Sub_metering_1,2,3 vs. Date_time

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
# Plot 3.
#

# line plot of Sub_metering_1,2,3 vs. Date_time

# open PNG device
# default height and width is 480x480 pixels
# default background is white
png("plot3.png")

# set for just 1 plot
par(mfrow = c(1, 1))

# draw the plot with Sub_metering_1 data
with(data, plot(Date_time, Sub_metering_1,
                xlab = "",
                ylab = "Energy sub metering",
                type = "l",
                col = "black"))

# add the Sub_metering_2 data
with(data, lines(Date_time, Sub_metering_2,
                 col = "red"))

# add the Sub_metering_3 data
with(data, lines(Date_time, Sub_metering_3,
                 col = "blue"))

# add the legend
legend("topright", 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"),
       lty = 1)

# close PNG device
dev.off()
