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
# head(newdata)

##new field with day of week
newdata$Day <- weekdays(newdata$Date)

##Convert factor -> character -> numberic
newdata$Voltage <- as.character(newdata$Voltage)
newdata$Voltage <- as.numeric(newdata$Voltage)

newdata$Global_reactive_power <- as.character(newdata$Global_reactive_power)
newdata$Global_reactive_power <- as.numeric(newdata$Global_reactive_power)

newdata$Sub_metering_1 <- as.character(newdata$Sub_metering_1)
newdata$Sub_metering_1 <- as.numeric(newdata$Sub_metering_1)

newdata$Sub_metering_2 <- as.character(newdata$Sub_metering_2)
newdata$Sub_metering_2 <- as.numeric(newdata$Sub_metering_2)

newdata$Sub_metering_3 <- as.character(newdata$Sub_metering_3)
newdata$Sub_metering_3 <- as.numeric(newdata$Sub_metering_3)

newdata$Global_active_power <- as.character(newdata$Global_active_power)
newdata$Global_active_power <- as.numeric(newdata$Global_active_power)

max_x <- max(newdata$DateTime)
min_x <- min(newdata$DateTime)

max_y_Sub_metering_1 <- max(newdata$Sub_metering_1)

max_y_Voltage <- max(newdata$Voltage)
min_y_Voltage <- min(newdata$Voltage)

max_y_Global_reactive_power <- max(newdata$Global_reactive_power)
min_y_Global_reactive_power <- min(newdata$Global_reactive_power)

max_y_Global_active_power <- max(newdata$Global_active_power)

png( "plot4.png", width = 480, height = 480)
par(mfcol=c(2,2))
plot(newdata$DateTime,newdata$Global_active_power,
     ylab = "Global Active Power (kilowatts)",
     xlab = "",
     ylim=c(0,max_y_Global_active_power), 
     xlim=c(min_x,max_x),
     type="l", lwd=1
)
with(newdata,plot(DateTime,Sub_metering_1,  
                  ylab = "Energy sub metering",
                  xlab = "",
                  type="n"
))

with(newdata,lines(DateTime,Sub_metering_1,col = "black"))
with(newdata,lines(DateTime,Sub_metering_2,col = "red"))
with(newdata,lines(DateTime,Sub_metering_3,col = "blue"))

fields<-c("Sub_metering_1","Sub_metering_2","Sub_metering_3")
colors<-c("black","red","blue")

legend("topright", # places a legend at the appropriate place 
       c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), # puts text in the legend      
       lty=c(1,1,1), # gives the legend appropriate symbols (lines)
       lwd=c(2.5,2.5,2.5),col=c("black","blue","red")) # gives the legend lines the correct color and width


plot(newdata$DateTime,newdata$Voltage,
     ylab = "Voltage",
     xlab = "",
     ylim=c(min_y_Voltage,max_y_Voltage), xlim=c(min_x,max_x),
     type="l", lwd=1
)

plot(newdata$DateTime,newdata$Global_reactive_power,
     ylab = "Global_reactive_power",
     xlab = "",
     ylim=c(0,max_y_Global_reactive_power), xlim=c(min_x,max_x),
     type="l", lwd=1
)
dev.off() 






