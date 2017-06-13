#load libraries
library(dplyr)
#read the file
house<-read.csv("household_power_consumption.txt", sep = ";")
#make table data frame
tabhouse<-tbl_df(house)
#filter by two required days
twodays<-filter(tabhouse, tabhouse$Date=="1/2/2007"|tabhouse$Date=="2/2/2007")
#create .png file in working directory
png("plot1.png")
#create histogram
hist(as.numeric(as.character(twodays$Global_active_power)), col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
#close the device
dev.off()