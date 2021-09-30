# IMPORTANT:
# The raw data set is to big for github. If you want to run the code in the
# RStudio you have to load and unzip the raw data (see README file).

## Import dplyr
library(dplyr)
Sys.setlocale("LC_TIME", "English")

## Load the data
raw_data <- read.table("household_power_consumption.txt",header=TRUE,sep=";")
data <- filter(raw_data,Date=="1/2/2007"|Date=="2/2/2007")
data$Global_active_power <- as.numeric(data$Global_active_power)
## Format the data
date_time <- paste(data$Date,data$Time,sep=" ")
data <- cbind(date_time,select(data,!c(Date,Time)))
data$date_time <- strptime(data$date_time,format = "%d/%m/%Y %H:%M:%S")

## Create the plot
y_label = "Global Active Power (kilowatts)"
png(filename="plot2.png")
plot(data$date_time,data$Global_active_power,type="l",xlab="",ylab=y_label)
## Close the device
dev.off()