# reading the data with fread function from data.table package
# in order to read just a subset of it
library(data.table)
data <- fread("./household_power_consumption.txt", sep=";", header=TRUE, 
              na.strings="?")[Date == "1/2/2007" | Date == "2/2/2007", ]

# creating a new column in the data frame that merges date and time info
data$datetime <- strptime(paste(data$Date, data$Time), 
                          format = "%d/%m/%Y %H:%M:%S")

# assigning the two dates to the variables day_1 and day_2
day_1 <- as.Date(min(data$Date), format = "%d/%m/%Y")
day_2 <- as.Date(max(data$Date), format = "%d/%m/%Y")

# command to create a panel for 4 plots to be filled column-wise
par(mfcol = c(2, 2), pin = c(2, 2))

# first plot
plot(data$Global_active_power ~ data$datetime, 
     type = "l", 
     xlab = "", 
     ylab = "Global Active Power", 
     xaxt = "n")

# inserting information on X-axis as abbreviated weekdays
axis.POSIXct(side = 1, 
             at = seq(day_1, day_2 + 1, by = "day"),
             format = "%a",
             labels = c("Thu", "Fri", "Sat"))

# second plot
plot(data$Sub_metering_1 ~ data$datetime, 
     type = "l", 
     xlab = "", 
     ylab = "Energy sub metering", 
     xaxt = "n")

lines(data$Sub_metering_2 ~ data$datetime, col = "red")
lines(data$Sub_metering_3 ~ data$datetime, col = "blue")

legend("topright", 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"),
       lty = 1,
       cex = 0.8)

# inserting information on X-axis as abbreviated weekdays
axis.POSIXct(side = 1, 
             at = seq(day_1, day_2 + 1, by = "day"),
             format = "%a",
             labels = c("Thu", "Fri", "Sat"))

# third plot
plot(data$Voltage ~ data$datetime,
     type = "l",
     xlab = "datetime",
     ylab = "Voltage",
     xaxt = "n")

# inserting information on X-axis as abbreviated weekdays
axis.POSIXct(side = 1, 
             at = seq(day_1, day_2 + 1, by = "day"),
             format = "%a",
             labels = c("Thu", "Fri", "Sat"))

# fourth plot
plot(data$Global_reactive_power ~ data$datetime,
     type = "l",
     xlab = "datetime",
     ylab = "Global_reactive_power",
     xaxt = "n")

# inserting information on X-axis as abbreviated weekdays
axis.POSIXct(side = 1, 
             at = seq(day_1, day_2 + 1, by = "day"),
             format = "%a",
             labels = c("Thu", "Fri", "Sat"))

# copying the plot to a png file and turning the connection off
dev.copy(png, file = "plot4.png")
dev.off()