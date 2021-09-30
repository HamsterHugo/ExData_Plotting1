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
data$Global_active_power <- as.numeric(data$Global_active_power)
data$Global_reactive_power <- as.numeric(data$Global_reactive_power)
data$Voltage <- as.numeric(data$Voltage)
data$Sub_metering_1 <- as.numeric(data$Sub_metering_1)
data$Sub_metering_2 <- as.numeric(data$Sub_metering_2)
data$Sub_metering_3 <- as.numeric(data$Sub_metering_3)
date_time <- paste(data$Date,data$Time,sep=" ")
data <- cbind(date_time,select(data,!c(Date,Time)))
data$date_time <- strptime(data$date_time,format = "%d/%m/%Y %H:%M:%S")

## Create the plot
png(filename="plot4.png")
par(mfrow = c(2,2))
# First plot
y_lab = "Global Active Power"
plot(data$date_time,data$Global_active_power,xlab="",type="l",ylab=y_lab)
# Second plot
x_lab <- "datetime"
y_lab <- "Voltage"
plot(data$date_time,data$Voltage,type="l",xlab=x_lab,ylab=y_lab)
# Third plot
y_lab="Energy sub metering"
plot(data$date_time,data$Sub_metering_1,type="l",xlab="",ylab=y_lab)
lines(data$date_time,data$Sub_metering_2,col="red")
lines(data$date_time,data$Sub_metering_3,col="blue")
# Creating the legend
c_color <- c("black","red","blue")
c_legend <- c("Sub_metering_1","Sub_metering_2","Sub_metering_3")
legend("topright",lty=1, bty="n",cex=0.9,col=c_color,legend=c_legend)
# Fourth plot
x_lab = "datetime"
y_lab = "Global_reactive_power"
plot(data$date_time,data$Global_reactive_power,type="l",xlab=x_lab,ylab=y_lab)
# Close the device
dev.off()