data <- read.table("household_power_consumption.txt",
                   header = TRUE,
                   sep = ";")

origdata <- data   ##data <- origdata
data[data == "?"] = NA
data <- na.omit(data)
# summary(data)

##convert the Date and Time variables to Date/Time classes in R using 
##the as.Date() and strptime()functions.

##Convert factor -> character -> date
data$Date <- as.character(data$Date)
data$Date <- as.Date(data$Date,format = "%d/%m/%Y")

data$DateTime <- as.POSIXct(paste(data$Date, data$Time), 
                            format="%Y-%m-%d %H:%M:%S")

newdata <- subset(data,  Date == "2007-02-01" |  Date == "2007-02-02")

##Convert factor -> character -> numberic
newdata$Global_active_power <- as.character(newdata$Global_active_power)
newdata$Global_active_power <- as.numeric(newdata$Global_active_power)

png( "plot1.png", width = 480, height = 480)
hist(newdata$Global_active_power, col="red",
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)",
     las=1)
dev.off() 




