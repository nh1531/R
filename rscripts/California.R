# 회귀 => 값을 예측하는 것
## 단순 회귀
# 모든 회귀문제는 단순 선형 회귀 모델을 기반. 베이스 라인

# 캘리포니아 집 값을 예측
## 예측 과정 (1,2번이 중요)
# 1. 데이터를 불러오기 확인 -> 시각적인 확인
# 2-1. 전처리 과정 -> NA 처리 / 전처리 완료한 파일명 : clean_data_날짜(2번까지 끝남)
# 2-2. 후처리 과정 -> 표준화와 정규화
# 3. 데이터를 분리 -> 학습 데이터와 검증 데이터
# 4. 학습 -> 기울기와 절편
# 5. 검증 -> 모델을 검증 (학습되지 않은 데이터에도 올바른지 검증, 아니면 3번부터 다시)

library(tidyverse)
library(reshape2)

# 1. 데이터를 불러오기 확인 -> 시각적인 확인
housing = read.csv("./data/housing.csv")
head(housing)

# 머신러닝 데이터는 전부 숫자로 바꿔야 함. 문자->숫자
# mean 평균, median 중앙값

colnames(housing)
# melt 옆으로 긴 데이터를 녹이면 아래로 붙음
ggplot(data = melt(housing), mapping = aes(x = value)) +
        geom_histogram(bins = 30) +
         facet_wrap(~variable, scales = 'free_x') 
# 기술통계로는 경향이 보이지 않음. 그래프로 시각화 필요-> 경향 확인
# 편향이 강하면 평균 쓰지 않음. 중앙값 사용

# 2-1. 전처리
housing$total_bedrooms[is.na(housing$total_bedrooms)] <- median(housing$total_bedrooms, na.rm=TRUE)
sum(is.na(housing))

# 연속적. 소수점. 산점도
# 불연속적. 정수. 히스토그램
housing$mean_bedrooms <- housing$total_bedrooms/housing$households
housing$mean_rooms <- housing$total_rooms/housing$households
head(housing)

categories <- unique(housing$ocean_proximity)
cat_housing <- data.frame(ocean_proximity = housing$ocean_proximity)
head(cat_housing)

for(cat in categories){
  cat_housing[,cat] = rep(0, times= nrow(cat_housing))
}
for(i in 1:length(cat_housing$ocean_proximity)){
  cat <- as.character(cat_housing$ocean_proximity[i])
  cat_housing[,cat][i] <- 1
}
head(cat_housing)
tail(cat_housing)

cat_columns <- names(cat_housing)
keep_columns <- cat_columns[cat_columns != 'ocean_proximity']
cat_housing <- select(cat_housing,one_of(keep_columns))
tail(cat_housing)

# 정규화와 표준화
# 단위를 맞춰야 함 (사람:명, 방:1개..)
# 아웃라이어가 많으면 정규화 사용하는 것이 좋음
# 정규화는 반드시 필요
# 표준화-평평한 데이터, 정규화-뾰쪽한 데이터

# 7:3 학습7 검증3, 학습은 랜덤 데이터로. select 하면 안됨

# 3. 학습
set.seed(42)
sample <- sample.int(n = nrow(cleaned_housing), size = floor(.8*nrow(cleaned_housing)), replace = F)
train <- cleaned_housing[sample, ] #just the samples
test  <- cleaned_housing[-sample, ] #everything but the samples
head(train)

# 원데이터 복원가능한지 확인
nrow(train) + nrow(test) == nrow(cleaned_housing) #true가 나와야 함. false면 데이터가 빠진것

glm_house = glm(median_house_value~median_income+mean_rooms+population, data=cleaned_housing)
k_fold_cv_error = cv.glm(cleaned_housing , glm_house, K=5) # 데이터가 1개니까 랜덤으로 5번 돌림
k_fold_cv_error$delta # delta 차이값

# RMSE 값이 낮게 나오는 것이 좋음. 오차값이니까
# 설명 가능한 RMSE 값

# 로지스틱 회귀 -> 회귀가 아니고 분류임
# random forest 설명가능. 전처리를 안해도 값이 나옴. 분류인데 회귀도 사용 가능
# xgboost
