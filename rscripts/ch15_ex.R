# 예제 : 캘리포니아 집 값 데이터

library(tidyverse)
library(reshape2)

# 1. 통계청 출산 데이터 (시계열, 회귀)
# 2. ~ 집 값 데이터 (캘리포니아, 보스턴x-인종데이터 포함되어 있음) => 대표적인 회귀
# 3. 손글씨 분류 => 대표적인 비정형(이미지) but 정형데이터 분류(0~9분류, 테이블로 만들어놓음)
# iris => 분류

house <- read.csv("./data/housing.csv")
head(house)

summary(house)

## 데이터 시각화(데이터 확인을 위한)
par(mfrow=c(2,5))
colnames(house)
#ggplot(data = melt(house), mapping = aes(x = value)) + geom_histogram(bins=30) + facet_wrap(-variable, scale = 'free_x' )

?ggplot

melt(house)

## 결측값 처리
# 세대주로 나눔
house$mean_bedroom = house$total_bedrooms / house$households
house$mean_rooms = house$total_rooms / house$households

drop = c('total_bedrooms', 'total_rooms')

house = house[, !(names(house) %in% drop)] 

head(house)
str(house) # chr->숫자로 변경

## 전처리(상식을 사용해서 가정에 대한 데이터를 별도로 분리)
categories = unique(house$ocean_proximity)
categories

cat_house = data.frame(ocean_proximity = house$ocean_proximity)
cat_house

for(cat in categories){
  cat_house[,cat] = rep(0, times=nrow(cat_house))
}
cat_house
head(cat_house)

for(i in 1:length(cat_house$ocean_proximity)){
  cat = as.character(cat_house$ocean_proximity[i])
  cat_house[,cat][i]=1
}
head(cat_house)

# 범주형
# 통계데이터를 실제 데이터를 가공해서 csv로 가공해서 범주형으로 바꿀거면 0,1
