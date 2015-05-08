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

# ornate sql statement to handle "?" used for missing data

datafile <- file("./data/household_power_consumption.txt")

sql <- 'select
            case
                when Date = "?" then null
                else Date
            end as Date,
            case
                when Time = "?" then null
                else Time
            end as Time,
            case
                when Global_active_power = "?" then null
                else Global_active_power
            end as Global_active_power,
            case
                when Global_reactive_power = "?" then null
                else Global_reactive_power
            end as Global_reactive_power,
            case
                when Voltage = "?" then null
                else Voltage
            end as Voltage,
            case
                when Global_intensity = "?" then null
                else Global_intensity
            end as Global_intensity,
            case
                when Sub_metering_1 = "?" then null
                else Sub_metering_1
            end as Sub_metering_1,
            case
                when Sub_metering_2 = "?" then null
                else Sub_metering_2
            end as Sub_metering_2,
            case
                when Sub_metering_3 = "?" then null
                else Sub_metering_3
            end as Sub_metering_3
        from datafile where "Date" in ("1/2/2007", "2/2/2007")'

data <- tbl_df(sqldf(sql,
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
               Date_time = dmy_hms(paste(Date, Time)))


#
# Plot 3.
#

# line plot of Sub_metering_1,2,3 vs. Date_time

# open PNG device
png("plot3.png")

# set for just 1 plot
par(mfrow = c(1, 1))

# draw the plot with Sub_metering_1 data
# default height and width is 480x480 pixels
# default background is white
# default axis labels used by R are as desired
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
