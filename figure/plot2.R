## plot2.R

# load data
library(data.table)
library(dplyr)
power <- fread("household_power_consumption.txt", na.strings = "?") %>%
    filter(Date == "1/2/2007" | Date == "2/2/2007")
power$Date <- paste(power$Date, power$Time) %>%
    strptime(format = "%d/%m/%Y %H:%M:%S")
power <- select(power, -c(Time))

# create .png
png(file = "plot2.png")
with(power, 
     plot(Date, Global_active_power, 
          type = "l",
          xaxt = "n",
          ylab = "Global Active Power (kilowatts)",
          xlab = ""))
with(power, 
     axis(1, 
          at = c(as.numeric(power$Date[1]), 
                 as.numeric(power$Date[(1+length(power$Date))/2]),
                 as.numeric(power$Date[length(power$Date)])),
          labels = c("Thu", "Fri", "Sat")))
dev.off()
