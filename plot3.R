# reading the data with fread function from data.table package
# in order to read just a subset of it
library(data.table)
data <- fread("./household_power_consumption.txt", sep=";", header=TRUE, 
              na.strings="?")[Date == "1/2/2007" | Date == "2/2/2007", ]

# creating a new column in the data frame that merges date and time info
data$datetime <- strptime(paste(data$Date, data$Time), 
                          format = "%d/%m/%Y %H:%M:%S")

# plotting the line graphic for the first variable without information on its X-axis
plot(data$Sub_metering_1 ~ data$datetime, 
     type = "l", 
     xlab = "", 
     ylab = "Energy sub metering", 
     xaxt = "n")

# adding the other variables to the plot
lines(data$Sub_metering_2 ~ data$datetime, col = "red")
lines(data$Sub_metering_3 ~ data$datetime, col = "blue")

# adding the legend
legend("topright", 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"),
       lty = 1)

# assigning the two dates to the variables day_1 and day_2
day_1 <- as.Date(min(data$Date), format = "%d/%m/%Y")
day_2 <- as.Date(max(data$Date), format = "%d/%m/%Y")

# inserting information on X-axis as abbreviated weekdays
axis.POSIXct(side = 1, 
             at = seq(day_1, day_2 + 1, by = "day"),
             format = "%a",
             labels = c("Thu", "Fri", "Sat"))

# copying the plot to a png file and turning the connection off
dev.copy(png, file = "plot3.png")
dev.off()