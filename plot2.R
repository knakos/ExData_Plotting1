print("Reading CSV file...")
mydata <- read.csv("./household_power_consumption.txt", header=TRUE, sep=";", na.strings = c("?"))

## MOVING OVER TO TESTDATA SO AS TO NOT HAVE TO LOAD THE CSV WITH EVERY ERROR
testdata <- mydata

## CREATE NEW COLUMN WITH DATES AND TIMES
print("Processing data columns to date/time...")
testdata <- within(testdata, DateTime <- as.POSIXlt(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S"))

## LIMITING THE OBSERVATIONS TO DESIRED DATES
print("Limiting observations to desired dates...")
testdata$Date <- strptime(testdata$Date, "%d/%m/%Y")
testdata <- testdata[testdata$Date >= strptime("01/02/2007","%d/%m/%Y"),]
testdata <- testdata[testdata$Date <= strptime("02/02/2007","%d/%m/%Y"),]

## REMOVE PREVIOUS DATE AND TIME COLUMNS
print("Removing unnecessary columns...")
testdata <- testdata[,-(1:2)]

## REMOVE MISSING VALUES FROM THE REMAINING OBSERVATIONS (ROWS)
testdata <- testdata[!is.na("Global_active_power"),]

## START THE REAL WORK - PLOTTING !
print("Started plotting...")
times <- testdata$DateTime

gap <- testdata$Global_active_power
grp <- testdata$Global_reactive_power
voltage <- testdata$Voltage
subm1 <- testdata$Sub_metering_1
subm2 <- testdata$Sub_metering_2
subm3 <- testdata$Sub_metering_3

png("Plot2.png",
    width=480,
    height=480,
    units="px",
    pointsize=10)

## PLOT 2
plot(times,gap,type="n",main="",ylab="Global Active Power (kilowatts)", xlab="")
lines(times,gap,type="c")
lines(times,gap,type="l")

dev.off()

print("Plot 2 completed. End.")
