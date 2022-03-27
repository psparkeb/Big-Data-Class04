# day04_02_crawling.R

# http://big-data-insight.com/


# 멀티 페이지 크롤링하기
# - 반복되는 구간을 찾기

# http://big-data-insight.com/article?id=41
# http://big-data-insight.com/article?id=42
# http://big-data-insight.com/article?id=43

# 크롤링 대상 url 만들기
my_url <- NULL

for(x in c(41:43)) {
  p <- paste0('http://big-data-insight.com/article?id=', x)
  my_url <- c(my_url, p)
}

# 1번방의 url을 이용하여 크롤링하기
my_url


library(rvest)


read_html(my_url[1]) %>%
  html_node('.details_1') %>%
  html_text()

# 반복문으로 3개 url에서 데이터 수집하기
txts <- NULL
for(my_data in my_url) {
  tmp <- read_html(my_data) %>%
    html_node('.details_1') %>%
    html_text()
  txts <- c(txts, tmp)
}
txts


















































































































