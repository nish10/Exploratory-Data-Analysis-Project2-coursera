pm<- readRDS("summarySCC_PM25.rds")

# split the data by year and find the total PM2.5 emission

sumPM<- with(pm, tapply(Emissions, as.factor(year), sum))

# ploting the graph
png("plot1.png")
plot(names(sumPM), sumPM, type="l", ylab= expression("Total Emission, PM"[2.5]), 
    xlab = "Year", main ="Decreased Total PM2.5  Emissions in U.S. from 1999 to 2008", col="red")
points(names(sumPM), sumPM, col="blue")

dev.off()