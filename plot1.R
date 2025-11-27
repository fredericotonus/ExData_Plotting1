library("data.table")

data <- fread("./household_power_consumption.txt", sep=";", header=TRUE, 
              na.strings="?")[Date == "1/2/2007" | Date == "2/2/2007", ]
dim(data)

data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
class(data$Date)

data$Time <- strptime(data$Time, "%H:%M:%S")
class(data$Time)

hist(data$Global_active_power, 
     main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)",
     col = "red")

dev.copy(png, file = "plot1.png")
dev.off()

