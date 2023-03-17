getwd()

dataset <- read.csv("./data/dataset.csv", header=T)
dataset
print(dataset)
View(dataset)

head(dataset)
tail(dataset)

names(dataset) #컬럼
attributes(dataset)

str(dataset) # 데이터 자료형 num-double

dataset$age

x <- dataset$age # int [1:300] [ ]-> 배열. 연속된 데이터가 들어가있음

plot(dataset$price)
dataset["gender"] # 딕셔너리. key-value. 조회가능
dataset[2]
#R->1부터 시작. 컬럼으로 조회 안한다고 생각. key값으로 조회. 

dataset[c("job","price")] #c->()

#결측치는 제거해야 함
#NA 
#제거, 보관(제거x,양이 적을 때), 예측
summary(dataset)

sum(dataset$price, na.rm = T)

price2 <- na.omit(dataset$price)
price2