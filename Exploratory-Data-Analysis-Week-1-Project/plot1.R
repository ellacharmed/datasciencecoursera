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
mydata$Date <- as.Date(mydata$Date, "%d/%m/%Y")

png(filename = "plot1.png", width = 480, height = 480, units = "px")
with(mydata, hist(Global_active_power
           , main="Global Active Power"
           , xlab = "Global Active Power (kilowatts)"
           , col="orangered2"))
dev.off()
