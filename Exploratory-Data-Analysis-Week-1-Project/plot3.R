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
x <- as.POSIXct(strptime(paste(mydata$Date, mydata$Time), "%Y-%m-%d %H:%M:%S"))

png(filename = "plot3.png", width = 480, height = 480, units = "px")
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
dev.off()
