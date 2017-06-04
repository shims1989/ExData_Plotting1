library(data.table) ## load data.table package to read big data.frame effectively
library(dplyr) ## load dplyr package to filter data

##read the data unziped to current working directory
zip_file <- download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "file.zip")
tempfile <- unz(zip_file, "household_power_consumption.txt")
file <- fread(file = "household_power_consumption.txt") 

file_int <- filter(file, Date == "1/2/2007" | Date == "2/2/2007") ## subset rows 
file_int$Global_active_power <- as.numeric(file_int$Global_active_power) ## convert to numeric

png("plot1.png")
with(file_int, hist(Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", 
                    main = "Global Active Power")) ## plot histgram for "Global_active_power"
dev.off()