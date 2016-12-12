library(dplyr)
#get and clean the data
dt <- read.table("household_power_consumption.txt",sep=";",header = TRUE)
df<-as.data.frame.matrix(dt)
df1<-na.omit(df)
# subset to two dates
df1$Date <- dmy(df1$Date)
lower<-ymd("2007-02-01")
upper<-ymd("2007=02-02")
dtf<-filter(df1, Date >=lower & Date<=upper)
# create df with one variable
gap<-as.numeric(dtf[,3])


ht<-c(1,1,1,1,1,1,1,1,1,1,1,1)
ht[1]<-sum(gap >= 0 & gap <=.5) 
ht[2]<-sum(gap > 0.5 & gap<=1.0) 
ht[3]<-sum(gap >1.0  & gap <=1.5) 
ht[4]<-sum(gap > 1.5 & gap <=2.0) 
ht[5]<-sum(gap > 2.0 & gap <=2.5)
ht[6]<-sum(gap > 2.5 & gap <=3.0)
ht[7]<-sum(gap > 3.0 & gap <=3.5)
ht[8]<-sum(gap > 3.5 & gap <=4.0)
ht[9]<-sum(gap > 4.0 & gap <=4.5)
ht[10]<-sum(gap > 4.5 & gap <=5.0)
ht[11]<-sum(gap > 5.0& gap <=5.5)
ht[12]<-sum(gap > 5.5 & gap <=6.0)


png(filename = 'plot1.png',width = 480, height = 480)
# do the bar plot
barplot(ht, main="Global Active Power",width=.5, xlab="Global Active Power (kilowatts)",ylab="Frequency",space=c(0.0),col="red")
axis(side=1,at = c(0,2,4,6),tick=TRUE)
#dev.copy(png,'plot1.png')
# save to png device
dev.off()
