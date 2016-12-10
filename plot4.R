pm<- readRDS("summarySCC_PM25.rds")
code<- readRDS("Source_Classification_Code.rds")

# index of Short.Name variable that contains "Coal" in it
a<- grep("Coal",code$Short.Name)

# subsetting SCC
b<- code$SCC[a]

subPM<- subset(pm, pm$SCC %in% b)

sumPM<- with(subPM, tapply(Emissions, as.factor(year), sum, na.rm=TRUE))

png("plot4.png")
plot(names(sumPM), sumPM, type="l", ylab= expression("Total Emission, PM"[2.5]), 
     xlab = "Year", main ="Emissions from coal combustion-related sources in U.S. (1999–2008)", col="red")
points(names(sumPM), sumPM, col="blue")

dev.off()

