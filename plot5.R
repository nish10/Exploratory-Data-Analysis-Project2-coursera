pm<- readRDS("summarySCC_PM25.rds")
code<- readRDS("Source_Classification_Code.rds")

# index of Short.Name variable that contains "Vehicles" in it
a<- grep("motor",code$Short.Name, ignore.case = TRUE)

b<- code$SCC[a]

subPM<- subset(pm, pm$SCC %in% b)
subpm<- subset(subPM, fips=="24510")
sumpm<- with(subpm, tapply(Emissions, as.factor(year), sum, na.rm=TRUE))

png("plot5.png")
plot(names(sumpm), sumpm, type="o", ylab= expression("Total Emission, PM"[2.5]), 
     xlab = "Year", main ="Emissions from motor vehicle sources in Baltimore City(1999-2008)", col="red")
points(names(sumPM), sumPM, col="blue")

dev.off()
