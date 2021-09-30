# IMPORTANT:
# The raw data set is to big for github. If you want to run the code in the
# RStudio you have to load and unzip the raw data (see README file).

## Import dplyr
library(dplyr)
Sys.setlocale("LC_TIME", "English")

## Load the data
raw_data <- read.table("household_power_consumption.txt",header=TRUE,sep=";")
data <- filter(raw_data,Date=="1/2/2007"|Date=="2/2/2007")
## Format the data
data$Sub_metering_1 <- as.numeric(data$Sub_metering_1)
data$Sub_metering_2 <- as.numeric(data$Sub_metering_2)
data$Sub_metering_3 <- as.numeric(data$Sub_metering_3)
date_time <- paste(data$Date,data$Time,sep=" ")
data <- cbind(date_time,select(data,!c(Date,Time)))
data$date_time <- strptime(data$date_time,format = "%d/%m/%Y %H:%M:%S")
## Create the plot
png(filename="plot3.png")
plot(data$date_time,data$Sub_metering_1,type="l",xlab="",ylab="Energy sub metering")
lines(data$date_time,data$Sub_metering_2,col="red")
lines(data$date_time,data$Sub_metering_3,col="blue")
# Creating the legend
c_color <- c("black","red","blue")
c_legend <- c("Sub_metering_1","Sub_metering_2","Sub_metering_3")
legend("topright",lty=1, col=c_color,legend=c_legend)
# Close the device
dev.off()