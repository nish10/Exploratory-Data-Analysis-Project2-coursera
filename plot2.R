pm<- readRDS("summarySCC_PM25.rds")

subpm<- subset(pm, fips=="24510")
sumPM<- with(subpm, tapply(Emissions, as.factor(year), sum))

png("plot2.png")
plot(names(sumPM), sumPM, type="l", ylab= expression("Total Emission, PM"[2.5]), 
     xlab = "Year", main ="Total PM2.5 Emissions in Baltimore City from 1999 to 2008", col="red")
points(names(sumPM), sumPM, col="blue")

dev.off()

