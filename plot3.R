library(dplyr)

#get and clean the data
dt <- read.table("household_power_consumption.txt",sep=";",header = TRUE)
df<-as.data.frame.matrix(dt)
df1<-na.omit(df)
# subset to two days
df1$Date <- as.POSIXct(df1$Date,tz = "",format="%d/%m/%Y")
df1$Time<-as.POSIXct(df1$Time,tz = "",format="%H:%M:%OS")
lo<-"01/02/2007"
up<-"02/02/2007"
lower<-strptime(lo,format="%d/%m/%Y")
upper<-strptime(up,format="%d/%m/%Y")
dtf<-filter(df1, Date >=lower & Date<=upper)
dtf<-tbl_df(dtf)
# change data types for plotting
dtf2<-mutate(dtf,Global_active_power=as.numeric(Global_active_power))
dtf2<-mutate(dtf2,Sub_metering_1=as.numeric(Sub_metering_1))
dtf2<-mutate(dtf2,Sub_metering_2=as.numeric(Sub_metering_2))
dtf2<-mutate(dtf2,Sub_metering_3=as.numeric(Sub_metering_3))
# select data in 10 minute intervals
dtf3<-filter(dtf2,minute(Time)==0 | minute(Time)==10 |minute(Time)==20 |minute(Time)==30 | minute(Time)==40 | minute(Time)==50 )
#First Dual Plot (one for Thursday and one for friday)- also includes hout ticks
png(filename = 'plot3.png',width = 480, height = 480)
par(mfrow=c(1,2))
with(dtf3[dtf3$Date < upper,], plot(Time,Sub_metering_1, type="n",xlab="Thursday",ylab="Energy Sub Metering"))
with(dtf3[dtf3$Date < upper,], lines(Time,Sub_metering_1,type="l",col="green"))
with(dtf3[dtf3$Date < upper,], lines(Time,Sub_metering_2,type="l",col="red"))
with(dtf3[dtf3$Date < upper,], lines(Time,Sub_metering_3,type="l",col="blue"))
legend('topright',c("Sub_1","Sub_2","Sub_3"),lty=1,col=c("green","red","blue"))

with(dtf3[dtf3$Date == upper,], plot(Time,Sub_metering_3, type="n",xlab="Friday",ylab="Energy Sub Metering"))
with(dtf3[dtf3$Date == upper,], lines(Time,Sub_metering_1,type="l",col="green"))
with(dtf3[dtf3$Date == upper,], lines(Time,Sub_metering_2,type="l",col="red"))
with(dtf3[dtf3$Date == upper,], lines(Time,Sub_metering_3,type="l",col="blue"))
#legend('topright',c("Sub_1","Sub_2","Sub_3"),lty=1,col=c("green","red","blue"))


#dev.copy(png,'plot1.png')
# save to png device
dev.off()
