# day04_05_ggplot.R

# - 해들리위컴 교수에 의해 개발
# - R은 ggplot 이전과 이후로 나뉜다.
# - 해들리 위컴의 말에 따르면 
#   기본 그래픽 시스템은 그림을 그리기 위해 좋은 툴이고
#   ggplot은 데이터를 이해하기 위해 더 좋은 툴이다.

install.packages('ggplot2')
library(ggplot2)
library(dplyr)

# 분석할 데이터 확인
diamonds


# 시각화하기
ggplot(diamonds)

# ggplot은 무슨 데이터(어떤 시각적 특성으로)를 
# 어떻게 표현할 것인지
# aes(aesthetics): 미학요소
# - color: 그래프의 색깔
# - fill: 그래프를 채우는 색깔
# - x: x축
# - y: y축

# geom: 어떻게 표현할 것인지
# - geom_bar: 막대 그래프
# - geom_point: 포인트 그래프
# - geom_line: 선 그래프

# cut에 따른 분류
ggplot(diamonds, aes(x=cut)) + geom_bar()

# clarity에 따른 분류
ggplot(diamonds, aes(x=clarity)) + geom_bar()

# color
ggplot(diamonds, aes(x=color)) + geom_bar()


# color에 따른 갯수 비율 시각화하기
ggplot(diamonds, aes(x=1, fill=color)) + geom_bar()

# color에 따른 갯수 비율 pie 형태시각화하기
ggplot(diamonds, aes(x=1, fill=color)) + 
  geom_bar() + 
  coord_polar('y')


# color에 따른 count(갯수)가 아닌 금액(price)의 
# 합계로 시각화하기
ggplot(diamonds, aes(x=color, y=price)) + 
  geom_bar(stat = 'identity')


# 등급별 평균가격을 구하여 시각화하기
diamonds %>%
  group_by(color) %>%
  summarise(mean_price=mean(price)) %>%
  ggplot(aes(x=color, y=mean_price)) + 
  geom_bar(stat = 'identity')


# color보다 price에 영향을 끼치는 
# 요소가 존재함을 알 수 있다.


# color에 따른 carat의 평균을 구하기
diamonds %>%
  group_by(color) %>%
  summarise(mean_price=mean(price), 
            mean_carat=mean(carat))


# carat에 따른 price 시각화하기
ggplot(diamonds, aes(x=carat, y=price)) + 
  geom_point()


ggplot(diamonds, aes(x=carat, y=price, color=color)) + 
  geom_point()


# J의 carat이 평균적으로 D보다 더 크기에
# 평균 price가 J가 더 크다는 것을 알 수 있다.



# 추세선 그리기
ggplot(diamonds, aes(x=carat, y=price, color=color)) + 
  geom_point() +
  geom_smooth()




































