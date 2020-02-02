install.packages("chron")
library(chron)

setwd("Z:\\odrive\\OneDrive-WatiSahnan\\Repos\\datasciencecoursera\\Exploratory-Data-Analysis-Week-1-Project")

colVariables <- c("Date"
                  ,"Time"
                  ,"Global_active_power"
                  ,"Global_reactive_power"
                  ,"Voltage"
                  ,"Global_intensity"
                  ,"Sub_metering_1"
                  ,"Sub_metering_2"
                  ,"Sub_metering_3")
mydata <- read.table("household_power_consumption.txt", 
                     sep = ";", 
                     na.strings = "?", 
                     skip = 66637, 
                     nrows = 2880, 
                     col.names = colVariables)
datetime <- as.POSIXct(strptime(paste(mydata$Date, mydata$Time)
                        , "%Y-%m-%d %H:%M:%S"))

png(filename = "plot4.png", width = 480, height = 480, units = "px")

#set up plot area 2x2 matrix of charts
par(mfrow=c(2,2))
#1st chart
plot(mydata$Global_active_power~x
      , type = "l"
      , col="black"
      , ylab = "Global Active Power"
      , xlab = "")
#2nd chart
plot(mydata$Voltage~x
      , type = "l"
      , col="black"
      , ylab = "Voltage"
      , xlab = "datetime")
#3rd chart
plot(x, mydata$Sub_metering_1
     , type = "n"
     , ylab = "Energy sub metering"
     , xlab = "")
lines(mydata$Sub_metering_1~x
      , type = "l"
      , col="black")
lines(mydata$Sub_metering_2~x
      , type = "l"
      , col="red")
lines(mydata$Sub_metering_3~x
      , type = "l"
      , col="blue")
legend("topright"
       , lwd=1
       , col=c("black","blue","red")
       , legend = c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"))
#4th chart
plot(mydata$Global_reactive_power~x
     , type = "l"
     , col="black"
     , ylab = "Global_reactive_power"
     , xlab = "datetime")

dev.off()
