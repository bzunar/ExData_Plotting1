## plot3.R

# load data
library(data.table)
library(dplyr)
power <- fread("household_power_consumption.txt", na.strings = "?") %>%
    filter(Date == "1/2/2007" | Date == "2/2/2007")
power$Date <- paste(power$Date, power$Time) %>%
    strptime(format = "%d/%m/%Y %H:%M:%S")
power <- select(power, -c(Time))

# create .png
png(file = "plot3.png")
with(power, 
     plot(Date, Sub_metering_1, 
          type = "l",
          xaxt = "n",
          ylab = "Energy sub metering",
          xlab = ""))
with(power,
     lines(Date, Sub_metering_2,
           col = "red"))
with(power,
     lines(Date, Sub_metering_3,
           col = "blue"))
with(power, 
     axis(1, 
          at = c(as.numeric(power$Date[1]), 
                 as.numeric(power$Date[(1+length(power$Date))/2]),
                 as.numeric(power$Date[length(power$Date)])),
          labels = c("Thu", "Fri", "Sat")))
legend("topright", 
       col = c("black", "red", "blue"), 
       lty = c(1, 1, 1), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()
