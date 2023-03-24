#7.2
resident2<-na.omit(dataset$resident)

#7.3
dataset2$gender2[dataset2$gender == 1]<-'남자'
dataset2$gender2[dataset2$gender == 2]<-'여자'
head(dataset[c("gender", "gender2")])
pie(table(dataset2$gender2))

#7.4
dataset2$age3[dataset2$age <= 30]<-1
dataset2$age3[dataset2$age >30 & dataset2$age <= 55]<-2
dataset2$age3[dataset2$age > 55]<-3
head(dataset2[c("age", "age2", "age3")])

#8.1
head(quakes)
str(quakes)

summary(quakes$depth)
depthgroup <- equal.count(quakes$depth, number = 3, overlap =0)
depthgroup

summary(quakes$mag)
maggroup <- equal.count(quakes$mag, number = 2, overlap = 0)
maggroup

xyplot(mag ~ depth | depthgroup * magnitudegroup, data = quakes)

#8.2
xyplot(max.temp + min.temp ~day | month, data = SeatacWeather, type = "l")