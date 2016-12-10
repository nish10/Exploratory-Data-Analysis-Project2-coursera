library(ggplot2)
pm<- readRDS("summarySCC_PM25.rds")
# subset by Baltimore city
subpm<- subset(pm, fips=="24510")
subpm$year<- as.factor(subpm$year)

bytype<- split(subpm,subpm$type)
sum1<- tapply(bytype[[1]]$Emissions,bytype[[1]]$year, sum)
names<- as.numeric(names(sum1))
sum1<- as.vector(sum1)
sum2<- tapply(bytype[[2]]$Emissions,bytype[[2]]$year, sum)
sum2<- as.vector(sum2)
sum3<- tapply(bytype[[3]]$Emissions,bytype[[3]]$year, sum)
sum3<- as.vector(sum3)
sum4<- tapply(bytype[[4]]$Emissions,bytype[[4]]$year, sum)
sum4<- as.vector(sum4)

# "http://stackoverflow.com/questions/17148679/construct-a-manual-legend-for-a-complicated-plot" helpful link
# for legend formation

cols <- c("NONPOINT"="#0000FF","NON-ROAD"="#00FF00","ON-ROAD"="#FF1493","POINT"="#800080")
p<- ggplot()+ geom_point(aes(names, sum1,color="NONPOINT"))+geom_line(aes(names, sum1,color="NONPOINT"))+
              geom_point(aes(names, sum2,color="NON-ROAD"))+geom_line(aes(names, sum2,color="NON-ROAD"))+
              geom_point(aes(names, sum3,color="ON-ROAD"))+geom_line(aes(names, sum3,color="ON-ROAD"))+
              geom_point(aes(names, sum4,color="POINT"))+geom_line(aes(names, sum4,color="POINT"))+
              scale_colour_manual(name="Type",values=cols)+
              labs(title="Emissions from 1999–2008 for Baltimore City", x="Year", y=expression("Total Emission, PM"[2.5]))
png("plot3.png")  
print(p)
dev.off()