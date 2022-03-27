# day04_03_crawling.R

library(rvest)
library(dplyr)

# 크롤링으로 수집할 페이지 url 만들기
my_url <- NULL

for(x in c(1:5)) {
  p <- paste0('https://jtbc.joins.com/search/news?page=', 
         x, 
         '&term=빅데이터')
  my_url <- c(my_url, p)
}

my_url


# my_url의 1번방으로 코드 만들기
my_url[1]

read_html(my_url[1]) %>% 
  html_nodes('.txt_ttl') %>%
  html_attr('href')    # href 속성을 가지고 와라

# 5페이지까지의 전체 기사 리스트 url 만들기
# - 1페이지 당 10개씩 총 50개의 url
my_links <- NULL
for(url in my_url) {
  link <- read_html(url) %>% 
    html_nodes('.txt_ttl') %>%
    html_attr('href')
  my_links <- c(my_links, link)
}

my_links

# 실습하기. my_links를 이용하여 기사 본문 데이터
# 50개를 수집해주세요
# txts 변수에 모아주세요.
txts <- NULL
for(link in my_links) {
  content <- read_html(link) %>%
              html_node('.article_content') %>%
              html_text()
  txts <- c(txts, content)
}
txts


# 파일 저장
write.csv(txts, 'c:/dev/my_crawling.csv')


# 뉴스 기사 읽어오기
txt1 <- read.csv('c:/dev/my_crawling.csv')


# 뉴스 기사 50개 중에서 20개로만 진행
mydata <- txt1[c(1:20), 2]



# 텍스트 마이닝 및 워드클라우드
library(KoNLP)
library(dplyr)
library(reshape2)

mydata %>% 
  SimplePos09() %>%
  melt() %>%
  as_tibble() %>%
  select(value) %>%
  mutate(noun=str_match(value, '([가-힣]+)/N')[, 2]) %>%
  na.omit() %>%
  filter(str_length(noun) >= 2) %>%
  count(noun, sort=T) %>%
  filter(n >= 10) %>%
  wordcloud2(
    minRotation = 0,
    maxRotation = 0,
    backgroundColor = 'black',
    color = 'random-light'
  )

















































