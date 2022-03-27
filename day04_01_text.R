# day04_01_text

# - KoNLP 설치하기


# r 버전 확인
version

# java 버전
Sys.getenv('JAVA_HOME')

# devtools
install.packages('devtools')


# remotes 
install.packages('remotes')


# KoNLP를 설치하기
remotes::install_github('luxdolorosa/KoNLP', 
                        upgrade = 'never', 
                        INSTALL_opts=c('--no-multiarch'))

# KoNLP설치 확인하기
library(KoNLP)


# 실습하기. moon_UTF8.txt 파일을 f라는 변수에 저장해주세요
f <- readLines('https://raw.githubusercontent.com/luxdolorosa/data_set/master/etc/moon_UTF8.txt'
               , encoding = 'UTF-8')
f
head(f)


# 파이프라인 문법
# - 물이 흐릇듯이 앞의 결과가 %>% 뒤로 연결되는 문법
install.packages('dplyr')
library(dplyr)

a <- 1
a + 1

1 %>% +1
f %>% head()

# 실습하기. 1을 문자로 변경하고, 타입을 출력해주세요
# - 문자변경(as.character), 타입출력(class)
1 %>% as.character() %>% class()


# 형태소 분석
# - 어떤 어절을 분석하는 것. 
#   동사, 명사, 형용사인지 등을 품사를 붙이는 것

SimplePos09('안녕하세요. 빅데이터 분석 전문가 시간입니다.')


# 형태소 분석을 이용해서 연설문에 품사 붙이기
moon_ko <- f %>% SimplePos09()

moon_ko %>% head()


# 구조 변경하기
# - reshape2: 구조 변경을 도와주는 패키지
install.packages('reshape2')
library(reshape2)

moon_ko %>% head(1)
moon_ko %>% melt %>% head(10)

# melt의 결과 컬럼
# value: 실제 값
# L2: 내부 list의 이름
# L1: 외부 list의 이름

# moon_ko를 tibble로 변경하기
m_df <- moon_ko %>% melt() %>% as_tibble()

m_df
# 실습하기. m_df의 데이터 중에서 value 컬럼만
# m_df1 에 저장해주세요
m_df[, 'value']
m_df[, 1]
select(m_df, 1)
select(m_df, 'value')
m_df %>% select(1)
m_df %>% select('value')

m_df1 <- m_df[, 'value']
m_df1

# 명사만 추출하기
# - /N이 붙은 데이터만 추출하기
# - 정규식을 이용하여 명사 추출하기

tmp_txt <- c('사실/N', 'korea/N', '알/P', '코리아/N정보/P')

install.packages('stringr')
library(stringr)

tmp_txt
# 한글이면서 /N이 붙은 데이터만 추출하기
tmp_txt %>% str_match('([가-힣]+)/N')

# 정규식
# - a-z: 모든 영소문자
# - A-Z: 모든 영대문자
# - 0-9: 모든 숫자
# - 가-힣: 모든 한글


# 연설문에 정규식을 적용하여 명사 추출하기
# - noun이라는 새로운 열을 만들어서 명사값을 입력하기
# - mutate(): 복제라는 함수를 이용하여 열을 만들기
m_df2 <- m_df1 %>% 
  mutate(noun=str_match(value, '([가-힣]+)/N')[, 2]) %>%
  na.omit()


# noun열의 단어별 갯수 카운트하기
m_df2 %>% count(noun, sort=T)


# 것, 수, 위처럼 1글자인 
# 데이터는 조회하지 않기
str_length('가')
str_length('가나')

m_df3 <- m_df2 %>% 
  filter(str_length(noun) >= 2) %>%
  count(noun, sort=T)


# 실습하기. m_df3에서 n이 2이상인 데이터만
#           조회해주세요.
m_df3 %>% filter(n >= 2)


# 워드클라우드
install.packages('wordcloud2')
library(wordcloud2)

m_df3 %>% wordcloud2()

m_df3 %>% 
  filter(n >= 2) %>%
  wordcloud2()





















