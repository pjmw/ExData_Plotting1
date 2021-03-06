library(sqldf)
library(dplyr)
data <- read.csv.sql("household_power_consumption.txt","select * from file where 
                                     Date = '1/2/2007' or Date = '2/2/2007' ",sep=";")
data <- tbl_df(data)
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
data$datetime <- strptime(paste(data$Date, data$Time), format = "%Y-%m-%d %H:%M:%S")
my_data <- select(data, datetime, Global_active_power:Sub_metering_3)

dev.copy(png, file = "plot2.png")
plot(my_data$datetime, my_data$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
dev.off()