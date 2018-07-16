library(lubridate)
library(tidyverse)

path <- file.path("~/EDA","project 1")
hpc <- read.table(file=paste0(path,"/household_power_consumption.txt"), 
                  header=TRUE, sep = ";", stringsAsFactors = FALSE  )

hpc <- hpc %>% mutate(date2 = dmy(Date)) %>% filter(date2 %in% c(ymd("2007-02-01"), ymd("2007-02-02"))) %>% 
     mutate(gap = (as.numeric(Global_active_power))) %>%  
     mutate(datetime = dmy_hms(paste(Date,Time)))

#this could easily have been done during the read.table step /shrug
hpc[grep("Sub", colnames(hpc))] <- sapply(hpc[grep("Sub", colnames(hpc))], as.numeric)


png(filename = "~/EDA/project 1/ExData_Plotting1/plot4.png", width = 480, height = 480 )
par(mfrow=c(2,2))

#1
with(hpc, (plot(datetime, gap, type = "l", ylab = "Global Active Power (kilowatts)", xlab="" )))
#2
with(hpc, (plot(datetime, Voltage, type="l" )))
#3
plot(hpc$datetime, hpc$Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab="")
with(hpc, lines(datetime, Sub_metering_3, col="blue"))
with(hpc, lines(datetime, Sub_metering_2, col="red"))
with(hpc, legend("topright", lty=1, col = c("black", "red", "blue"), 
                 legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3")))
#4
with(hpc, plot(datetime, Global_reactive_power, type="l" ))

dev.off()
