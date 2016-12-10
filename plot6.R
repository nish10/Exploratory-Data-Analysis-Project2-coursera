library(ggplot2)
pm<- readRDS("summarySCC_PM25.rds")
code<- readRDS("Source_Classification_Code.rds")

# index of Short.Name variable that contains "Vehicles" in it
a<- grep("motor",code$Short.Name, ignore.case = TRUE)
b<- code$SCC[a]

subPM<- subset(pm, pm$SCC %in% b)

Bal<- subset(subPM, fips=="24510")
Los<- subset(subPM, fips=="06037")

sumBal<- with(Bal, tapply(Emissions, as.factor(year), sum))
names<- as.numeric(names(sumBal))
sumBal<- as.vector(sumBal)
sumLos<- with(Los, tapply(Emissions, as.factor(year), sum))
sumLos<- as.vector(sumLos)

cols <- c("Baltimore City"="#FF1493","Los Angeles County"="#800080")
p<- ggplot()+ geom_point(aes(names, sumBal,color="Baltimore City"))+geom_line(aes(names, sumBal,color="Baltimore City"))+
              geom_point(aes(names, sumLos,color="Los Angeles County"))+geom_line(aes(names, sumLos,color="Los Angeles County"))+
              scale_colour_manual(name="County",values=cols)+
              labs(title="Emissions from Baltimore City and L.A. county", x="Year", y=expression("Total Emission, PM"[2.5]))

png("plot6.png")  
print(p)
dev.off()