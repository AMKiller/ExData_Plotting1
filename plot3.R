##Read the data
data <- read.table("household_power_consumption.txt",
                   header = TRUE,
                   sep = ";")

##Convert ? to NA and get rid of any rows with NA's
origdata <- data   ##data <- origdata
data[data == "?"] = NA
data <- na.omit(data)
# summary(data)
# head(data)

##convert the Date and Time variables to Date/Time classes in R using 
##the as.Date() and strptime()functions.

##Convert factor -> character -> date

data$Date <- as.character(data$Date)
data$Time <- as.character(data$Time)
data$Date <- as.Date(data$Date,format = "%d/%m/%Y")
data$DateTime <- as.POSIXct(paste(data$Date, data$Time), 
                            format="%Y-%m-%d %H:%M:%S")
# summary(data)
# head(data)

newdata <- subset(data,  Date == "2007-02-01" |  Date == "2007-02-02")
# head(newdata)

##Convert factor -> character -> numberic
newdata$Sub_metering_1 <- as.character(newdata$Sub_metering_1)
newdata$Sub_metering_1 <- as.numeric(newdata$Sub_metering_1)

newdata$Sub_metering_2 <- as.character(newdata$Sub_metering_2)
newdata$Sub_metering_2 <- as.numeric(newdata$Sub_metering_2)

newdata$Sub_metering_3 <- as.character(newdata$Sub_metering_3)
newdata$Sub_metering_3 <- as.numeric(newdata$Sub_metering_3)

##new field with day of week
newdata$Day <- weekdays(newdata$Date)

max_y1 <- max(newdata$Sub_metering_1)
max_x <- max(newdata$DateTime)
min_x <- min(newdata$DateTime)

png( "plot3.png", width = 480, height = 480)

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

##Need the legend
##Need to send to file as png
legend("topright", # places a legend at the appropriate place 
       c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), # puts text in the legend      
       lty=c(1,1,1), # gives the legend appropriate symbols (lines)
       lwd=c(2.5,2.5,2.5),col=c("black","blue","red")) # gives the legend lines the correct color and width

dev.off()


