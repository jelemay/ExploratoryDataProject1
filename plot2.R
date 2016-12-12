library(dplyr)
#library(lubridate)
#get and clean the data
dt <- read.table("household_power_consumption.txt",sep=";",header = TRUE)
df<-as.data.frame.matrix(dt)
df1<-na.omit(df)
# subset to two dates
df1$Date <- as.POSIXct(df1$Date,tz = "",format="%d/%m/%Y")
df1$Time<-as.POSIXct(df1$Time,tz = "",format="%H:%M:%OS")
lo<-"01/02/2007"
up<-"02/02/2007"
lower<-strptime(lo,format="%d/%m/%Y")
upper<-strptime(up,format="%d/%m/%Y")
dtf<-filter(df1, Date >=lower & Date<=upper)
dtf<-tbl_df(dtf)
# select relevenat variables
dtf1<-select(dtf,Date,Time,Global_active_power)
# change data types for plotting
dtf2<-mutate(dtf1,Global_active_power=as.numeric(Global_active_power))
# select data in 10 minute intervals
dtf3<-filter(dtf2,minute(Time)==0 | minute(Time)==10 |minute(Time)==20 |minute(Time)==30 | minute(Time)==40 | minute(Time)==50 )
#First Dual Plot (one for Thursday and one for friday)- also includes hout ticks
# better than example!!!!
png(filename = 'plot2.png',width = 480, height = 480)
par(mfrow=c(1,2))
with(dtf3[dtf3$Date < upper,], plot(Time,Global_active_power, type="n",xlab="Thursday"))
with(dtf3[dtf3$Date < upper,], lines(Time,Global_active_power,type="l"))
with(dtf3[dtf3$Date == upper,], plot(Time,Global_active_power, type="n",xlab="Friday"))
with(dtf3[dtf3$Date ==upper,], lines(Time,Global_active_power,type="l"))

# save to png device
dev.off()
