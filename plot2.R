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
png("plot2.png", width = 480, height = 480)
#plot the graph
plot(twodaysmut$DateTimeClass, as.numeric(as.character(twodaysmut$Global_active_power)), type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
#close the device
dev.off()