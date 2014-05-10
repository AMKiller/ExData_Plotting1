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
data$Time <- as.character(data$Time)
data$DateTime <- as.POSIXct(paste(data$Date, data$Time), 
                            format="%Y-%m-%d %H:%M:%S")

data$Date <- as.Date(data$Date,format = "%d/%m/%Y")

newdata <- subset(data,  Date == "2007-02-01" |  Date == "2007-02-02")
head(newdata)

##Convert factor -> character -> numberic
newdata$Global_active_power <- as.character(newdata$Global_active_power)
newdata$Global_active_power <- as.numeric(newdata$Global_active_power)

##new field with day of week
newdata$Day <- weekdays(newdata$Date)

tail(newdata$Day)

max_y <- max(newdata$Global_active_power)
max_x <- max(newdata$DateTime)
min_x <- min(newdata$DateTime)

png( "plot2.png", width = 480, height = 480)
plot(newdata$DateTime,newdata$Global_active_power,
     ylab = "Global Active Power (kilowatts)",
     xlab = "",
     ylim=c(0,max_y), xlim=c(min_x,max_x),
     type="l", lwd=1
)
dev.off() 








