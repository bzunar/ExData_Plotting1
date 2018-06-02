## plot1.R

# load data
library(data.table)
library(dplyr)
power <- fread("household_power_consumption.txt", na.strings = "?") %>%
    filter(Date == "1/2/2007" | Date == "2/2/2007")
power$Date <- paste(power$Date, power$Time) %>%
    strptime(format = "%d/%m/%Y %H:%M:%S")
power <- select(power, -c(Time))

# create .png
png(file = "plot1.png")
with(power, 
     hist(Global_active_power, 
          col = "red", 
          main = "Global Active Power",
          xlab = "Global Active Power (kilowatts)"))
dev.off()
