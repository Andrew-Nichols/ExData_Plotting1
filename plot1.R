# Coursera - Exploratory Data Analysis
# Course Project 1 (Posted by Direction from Instructors)
# Submitter:  A. Nichols
# Date: August 9, 2015

# Plot 1
# Set working directory, source the code, and go!

# Install and load required packages:

install.packages("RCurl")      # For downloading file from the Internet
library(RCurl)
install.packages("dplyr")      # For parsing the data set
library(dplyr)
install.packages("lubridate")  # For parsing dates and times
library(lubridate)
install.packages("grDevices")  # Needed for png files
library(grDevices)
install.packages("RColorBrewer")
library(RColorBrewer)

# Download data from the Internet:

dataset_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(dataset_url, 
	destfile = "C:/.../power_zipfile",
	method = "libcurl")	# Full download file path omitted here
unzip("power_zipfile", exdir = "power_data")
list.files("power_data")

# Read the data (cleanly), and time it:
# Full file path omitted here

system.time({
data1df <- read.table("C:/.../power_data/household_power_consumption.txt",
	header=TRUE, sep = ";", colClasses=c("character", "character", 
	"numeric", "numeric", "numeric", "numeric", "numeric", 
	"numeric", "numeric"), na.strings=c("?"))
})

# Prepare and tidy the data:

data2tbl <- tbl_df(data1df)  				# Creates tbl out of data frame
rm("data1df")                				# Removes original data frame from memory
data3 <- mutate(data2tbl, Date = dmy(Date))	
data4 <- filter(data3, Date>"2007-01-31", Date<="2007-02-02")
data5 <- mutate(data4, Time=hms(Time))
data5df <- data.frame(data5) 				# data5 and data5df are the baseline data sets

#### Plot 1 ###

data6 <- select(data5, Global_active_power)
data7 <- filter(data6, !is.na(Global_active_power))
hist(data7$Global_active_power, 
	breaks=12,
	col="Red",
	bg="White",
	main="Global Active Power",
	xlab="Global Active Power (kilowatts)",
	ylab="Frequency")

# Copy 480 x 480 png image to working directory, then turn off the device:

dev.copy(png, file="plot1.png", width=480, height=480, bg="White")
dev.off()

####### End of Program ########
