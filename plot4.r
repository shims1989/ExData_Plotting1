library(data.table) ## load data.table package to read big data.frame effectively
library(dplyr) ## load dplyr package to filter data

##read the data unziped to current working directory
zip_file <- download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "file.zip")
tempfile <- unz(zip_file, "household_power_consumption.txt")
file <- fread(file = "household_power_consumption.txt") 

file_int <- filter(file, Date == "1/2/2007" | Date == "2/2/2007") ## subset rows 
file_int$Global_active_power <- as.numeric(file_int$Global_active_power) ## convert to numeric
xlabscale <- c(1, (nrow(file_int)-1) * 0.5, nrow(file_int)) ## Define the scale of x axis
xlable <- c("Thu", "Fri", "Sat") ##Use weekday name in x-axis 

png("plot4.png")
par(mfcol = c(2,2), ann = FALSE) ##Set parameters

##Plot the first graph
with(file_int, plot(Global_active_power, type = "n", xaxt = "n")) 
axis(1,at=xlabscale, labels = xlable) #Use defined x-axis scale
lines(file_int$Global_active_power) #drow lines to the plot
title(ylab = "Global Active Power") #add y-axis lable name

## -----------------------------------------------------------------------

##Plot the second graph
with(file_int, plot(Sub_metering_1, type = "n", xaxt = "n")) 
axis(1,at=xlabscale, labels = xlable) #Use defined x-axis scale
## Adding lines for 3 sub_metering
lines(file_int$Sub_metering_1, col = "black") #drow lines to the plot
lines(file_int$Sub_metering_2, col = "red") #drow lines to the plot
lines(file_int$Sub_metering_3, col = "blue") #drow lines to the plot
## Adding legend
legend("topright", col = c("black", "red", "blue"), lty = 1, bty = "n",
      legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
title(ylab = "Energy sub metering") #add y-axis lable name

## -----------------------------------------------------------------------

##Plot the third graph
with(file_int, plot(Voltage, type = "n", xaxt = "n")) 
axis(1,at=xlabscale, labels = xlable) #Use defined x-axis scale
lines(file_int$Voltage) #drow lines to the plot
title(xlab = "datetime", ylab = "Voltage") #add names of labels

## -----------------------------------------------------------------------

##Plot the forth graph
with(file_int, plot(Global_reactive_power, type = "n", xaxt = "n")) 
axis(1,at=xlabscale, labels = xlable) #Use defined x-axis scale
lines(file_int$Global_reactive_power) #drow lines to the plot
title(xlab = "datetime", ylab = "Global_reactive_power") #add names of labels

## Reset parameters
par(mfcol = c(1,1), ann = TRUE)
dev.off()
