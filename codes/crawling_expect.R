library(rvest)
library(stringr)
setwd("C:/Users/Big Data Guru/Desktop")

a <- read.csv("300등까지.csv" , sep =",")
title <- gsub(":","",a$title)
title <- gsub(" ","",title)
title <- gsub("/","",title)

positive.list <- character()
negative.list <- character()
people.list <- character()
i <- 1
while(i <= length(a[,1])){
  
  url.1 <- "https://search.naver.com/search.naver?where=nexearch&query="
  url.2 <- title[i]
  url.3 <- "&sm=top_hty&fbm=1&ie=utf8"
  url <- paste(url.1,url.2,url.3, sep = "")
  ## link parsing 하기 ##
  htxt <- read_html(url)
  comments = html_nodes(htxt,'.sh_movie_link')
  address <- html_attr(comments,'href')
  
  url_1 <- "http://movie.naver.com/movie/bi/mi/point.nhn?code="
  url_2 <- str_sub(address , start = str_locate(address,"code=")[2]+1)
  
  newurl = paste(url_1,url_2, sep="")
  htxt <- read_html(newurl)
  ## 긍정반응 ##
  parsing.1 = html_nodes(htxt,'#interest_cnt_point')
  positive <- html_text(parsing.1)
  positive <-  repair_encoding(positive)
  positive <- str_sub(positive,start=str_locate(positive,"보고싶어요")[2]+1)
  ## 부정반응 ##
  parsing.2 = html_nodes(htxt,'#not_interest_cnt_point')
  negative <- html_text(parsing.2)
  negative <-  repair_encoding(negative)
  negative <- str_sub(negative,start=str_locate(negative,"글쎄요")[2]+1)
  ## 참여 ##
  parsing.3 = html_nodes(htxt,'#beforePointArea .user_count')
  people <- html_text(parsing.3)
  people <-  repair_encoding(people)
  people <- str_sub(people,start=str_locate(people,"참여")[2]+2 , end = str_length(people)-1)
  
  positive.list <- append(positive.list,positive)
  negative.list <- append(negative.list,negative)
  people.list <- append(people.list,people)
  
  i <- i + 1
}
a$title[c(-69,-185,-198,-220,-228)]
s <- data.frame(a$title[c(-69,-185,-198,-220,-228)],positive.list,negative.list,people.list)
a$title[228] 

write.csv(s,"개봉전 호감도.csv" , sep = ",")
