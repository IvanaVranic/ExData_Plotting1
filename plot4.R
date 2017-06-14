#load libraries
library(dplyr)
library(lubridate)
#read the file
house<-read.csv("household_power_consumption.txt", sep = ";")
#make table data frame
tabhouse<-tbl_df(house)
#filter by two required days
twodays<-filter(tabhouse, tabhouse$Date=="1/2/2007"|tabhouse$Date=="2/2/2007")
#add new column "DateTime" which is Date and Time columns joined together and save in new table "twodaysmut"
twodaysmut<-mutate(twodays, DateTime=paste(twodays$Date, twodays$Time, sep=" "))
#make DateTimeClass column which is of "POSIXct" "POSIXt" class
twodaysmut<-mutate(twodaysmut, DateTimeClass=dmy_hms(twodaysmut$DateTime))
#create .png file in working directory
png("plot4.png", width = 480, height = 480)
par(mfrow=c(2,2))
plot(twodaysmut$DateTimeClass, as.numeric(as.character(twodaysmut$Global_active_power)), type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
plot(twodaysmut$DateTimeClass, as.numeric(as.character(twodaysmut$Voltage)), type = "l", xlab = "datetime", ylab = "Voltage")
plot(twodaysmut$DateTimeClass, as.numeric(as.character(twodaysmut$Sub_metering_1)), type = "l", xlab = "", ylab = "Energy sub metering")
lines(twodaysmut$DateTimeClass, as.numeric(as.character(twodaysmut$Sub_metering_2)), col="red")
lines(twodaysmut$DateTimeClass, as.numeric(as.character(twodaysmut$Sub_metering_3)), col="blue")
legend(x="topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty=c(1,1,1))
plot(twodaysmut$DateTimeClass, as.numeric(as.character(twodaysmut$Global_reactive_power)), type = "l", xlab = "datetime", ylab = "Global_reactive_power")
#close the device
dev.off()