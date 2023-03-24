# 7.2
getwd() # 어느 위치

#index 제거하고 출력해야함
dataset <- read.csv("./data/dataset.csv", header=T) # 파일 읽기
#head(dataset)
dataset2 <- subset(dataset, price >= 2 & price <= 8) #subset(data, 조건식)
#str(dataset2)

pos <- dataset2$position
cpos <- 6 - pos #  6 - pos : Vector

dataset2$position <- cpos
#[] 안에 true, false값 으로 값 변경 가능
dataset2$position[dataset2$position == 1] <-'1급'
dataset2$position[dataset2$position == 2] <-'2급'
dataset2$position[dataset2$position == 3] <-'3급'
dataset2$position[dataset2$position == 4] <-'4급'
dataset2$position[dataset2$position == 5] <-'5급'

#range(1,5) # range 범위값
#?range # 패키지 확인(base..), ex 확인

range(dataset2$resident, na.rm = T) # 값의 범위
dataset2 <- subset(dataset2, !is.na(dataset2$resident)) 
head(dataset2)

View(dataset2)

# 7.3
dataset2$gender2[dataset2$gender == 1] <-'남자'
dataset2$gender2[dataset2$gender == 2] <-'여자'
pie(table(dataset2$gender2)) # 레이블 사용 하려면 table 처럼 위에 설명이 있어야 함
?table

# Vector(한줄), Matrix(면), Table(컬럼에 뭐가 적혀있는거), DF(data frame 안쪽에 있는 내부구조 연산 가능하게
# 만들어놓은 자료구조)
# true, false로 적어야 함. 0,1로 구분하면 안됨

# 8장 1
data(quakes)
?quakes

library(lattice)

??equal.count # ?? -> 어디에 있는지 알려줌
equal.count(quakes$depth, number=5, overlap=0)  # 구획 많이 됨 3,5로
depthgroup <- equal.count( quakes$depth,
                           number=3,
                           overlap=0)
magnitudegroup <- equal.count(quakes$mag,
                              number=2,
                              overlap=0)
xyplot(lat ~ long | magnitudegroup * depthgroup, data = quakes) # 조건식

# 8장 2
install.packages("latticeExtra")
library(latticeExtra)
xyplot(min.temp + max.temp ~ day | month, data = SeatacWeather)
