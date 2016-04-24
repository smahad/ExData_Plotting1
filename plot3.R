#Read Data
hpc <- read.table("household_power_consumption.txt",sep=";",header=TRUE,skip=grep("31/1/2007;23:58:00",readLines("household_power_consumption.txt")),nrows=2880,col.names = colnames(read.table("household_power_consumption.txt",header=TRUE,nrows = 1,sep=";")))
hpc[hpc=="?"]=NA
hpc <- transform(hpc, Date= as.Date(hpc$Date,format="%d/%m/%Y"))
hpc1 <- unite(hpc,"DateTime",Date,Time,sep=" ")
hpc2 <- transform(hpc1,DateTime=strptime(hpc1$DateTime, "%Y-%m-%d %H:%M:%OS"))

png(filename="plot3.png",width = 480, height = 480)

#Plot3
par(mar=c(3,5,2,2))
plot(hpc2$DateTime,hpc2$Sub_metering_1,type="n",ylab="Energy sub metering", xlab="")
points(hpc2$DateTime,hpc2$Sub_metering_1,type="l")
points(hpc2$DateTime,hpc2$Sub_metering_2,type="l",col="red")
points(hpc2$DateTime,hpc2$Sub_metering_3,type="l",col="blue")
legend("topright",lwd=1, lty=c(1,1,1),col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

dev.off()