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
                     col.names = colVariables,
        )
x <- as.POSIXct(strptime(paste(mydata$Date, mydata$Time), "%Y-%m-%d %H:%M:%S"))
y <- as.numeric(mydata$Global_active_power)
png(filename = "plot2.png", width = 480, height = 480, units = "px")
plot(y~x, type = "l", ylab = "Global Active Power (kilowatts)", xlab = "")
dev.off()
