# IMPORTANT:
# The raw data set is to big for github. If you want to run the code in the
# RStudio you have to load and unzip the raw data (see README file).


## Import dplyr
library(dplyr)

## Load the data
raw_data <- read.table("household_power_consumption.txt",header=TRUE,sep=";")
data <- filter(raw_data,Date=="1/2/2007"|Date=="2/2/2007")
data$Global_active_power <- as.numeric(data$Global_active_power)
x_label <- "Global Active Power (kilowatts)"
title <- "Global Active Power"

## Create the plot
png(filename="plot1.png")
hist(data$Global_active_power,col="red",xlab=x_label,main=title)
axis(2,at=1200)
## Close the device
dev.off()