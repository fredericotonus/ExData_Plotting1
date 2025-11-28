# reading the data with fread function from data.table package
# in order to read just a subset of it
library(data.table)
data <- fread("./household_power_consumption.txt", sep=";", header=TRUE, 
              na.strings="?")[Date == "1/2/2007" | Date == "2/2/2007", ]

# plotting the histogram
hist(data$Global_active_power, 
     main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)",
     col = "red")

# copying the plot to a png file and turning the connection off
dev.copy(png, file = "plot1.png")
dev.off()