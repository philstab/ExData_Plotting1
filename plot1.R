library(lubridate)
library(tidyverse)

path <- file.path("~/EDA","project 1")
hpc <- read.table(file=paste0(path,"/household_power_consumption.txt"), 
                  header=TRUE, sep = ";", stringsAsFactors = FALSE  )

hpc <- hpc %>% mutate(date2 = dmy(Date)) %>% filter(date2 %in% c(ymd("2007-02-01"), ymd("2007-02-02"))) %>% 
       mutate(gap = (as.numeric(Global_active_power)))

sum(is.na(hpc$gap)) #no missing values

png(filename = "~/EDA/project 1/ExData_Plotting1/plot1.png", width = 480, height = 480 )
hist(hpc$gap, main="Global Active Power", col="red", xlab = "Global Active Power (kilowatts)")
dev.off()
