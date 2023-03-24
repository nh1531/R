install.packages("tidyverse")
install.packages("ggplot2")

library(tidyverse)
library(readxl) #엑셀

df <- read_excel("./practice/시군구_성_월별_출생_19972021.xlsx")
str(df)

View(df)

#월별 출생아수 97.01-21.12까지 
# 파이프 %>%
df2 <- df %>% # 원래 데이터를 놔두고 df2에 값을 넣음. 원본 데이터 훼손x
  filter(!is.na(시점)) %>% # 시점에서 na가 아닌 값만
  select(시점, 전국) %>%
  separate(시점, into = c("년도", "월"))

df2 <- df2 %>%
  group_by(월) %>% #월은 컬럼 "월"로 적으면 안됨
  summarise(평균출생수 = mean(전국))

df2 %>%
  qlot(x=월, y=평균출생수, data=.) # . -> 참조연산자
# 점 그래프 출력

