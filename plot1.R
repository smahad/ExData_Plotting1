#Read Data
hpc <- read.table("household_power_consumption.txt",sep=";",header=TRUE,skip=grep("31/1/2007;23:58:00",readLines("household_power_consumption.txt")),nrows=2880,col.names = colnames(read.table("household_power_consumption.txt",header=TRUE,nrows = 1,sep=";")))
hpc[hpc=="?"]=NA
hpc <- transform(hpc, Date= as.Date(hpc$Date,format="%d/%m/%Y"))
hpc1 <- unite(hpc,"DateTime",Date,Time,sep=" ")
hpc2 <- transform(hpc1,DateTime=strptime(hpc1$DateTime, "%Y-%m-%d %H:%M:%OS"))

png(filename="plot1.png",width = 480, height = 480)
#Plot1
hist(hpc2$Global_active_power,col="red",xlab="Global Active Power (kilowatts)",main="Global Active Power")
dev.off()