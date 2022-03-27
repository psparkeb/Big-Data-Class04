# day04_04_visual.R

# cars 데이터 이용하기
# - R에 내장되어있는 데이터
cars %>% head()

summary(cars)


# plot(): x와 y 2개의 값을 기준으로 좌표를 그리는 함수
plot(1, 1)
plot(2, 2)

plot(c(1, 2), c(2, 3))


# 실습하기. cars의 데이터를 이용하여 스피드(speed)에 따른
#           제동거리(dist)를 plot으로 시각화해주세요.
plot(cars$speed, cars$dist)

plot(cars$speed, cars$dist, type='p')
plot(cars$speed, cars$dist, type='l')


# barplot: 표현 값에 비례하여 높이와 길이를 가지는 그래프
# 갯수(수량)을 표현하는 그래프
hotdogs <- read.csv('https://raw.githubusercontent.com/luxdolorosa/data_set/master/hot_dog/hot-dog-contest-winners.csv')

hotdogs %>%head()
str(hotdogs)

# 우승자들이 핫도그를 얼마나 먹었는지
barplot(hotdogs$Dogs.eaten)
barplot(hotdogs$Dogs.eaten, names.arg = hotdogs$Year)
barplot(hotdogs$Dogs.eaten, 
        names.arg = hotdogs$Year,
        col=rainbow(20)
        )

plot(hotdogs$Year, hotdogs$Dogs.eaten)

# 실습하기. 국가별 우승횟수를 barplot
cnt <- table(hotdogs$Country)
barplot(cnt)


# pie: 원 그래프
# - 전체에 대한 각 부분의 비율
banana <- read.csv('https://raw.githubusercontent.com/luxdolorosa/data_set/master/banana/banana.csv', 
         header = F)

banana
pie(banana$V2, labels=banana$V1)


# hotdog 우승국가의 비율을 pie 그리기
table(hotdogs$Country) %>% pie()
























































