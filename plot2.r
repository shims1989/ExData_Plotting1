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
##prepare scatter plot with no lable name (ann = FALSE) and no x-axis scale (xaxt = "n")
png("plot2.png")
with(file_int, plot(Global_active_power, type = "n", ann = FALSE, xaxt = "n")) 
axis(1,at=xlabscale, labels = xlable) #Use defined x-axis scale
lines(file_int$Global_active_power) #drow lines to the plot
title(ylab = "Global Active Power (kilowatts)") #add y-axis lable name
dev.off()
