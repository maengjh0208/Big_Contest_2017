setwd("C:/Users/Big Data Guru/Desktop")

a <- read.csv("영화코드리스트.csv" , sep =",")


code <- as.character(a$movie_code)
moviename <- as.character(a$title_1)

num = c(375,458,487,551,554)
code[num]

setwd("C:/Users/Big Data Guru/Desktop/영화리뷰")

for(i in num){
  
  if(a$title_2[i] == ""){
  
  url_1 <- "http://movie.naver.com/movie/bi/mi/pointWriteFormList.nhn?code="
  url_2 <- code[i]
  url_3 <- "&type=after&onlyActualPointYn=N&order=newest&page="
  
  date_list <- as.character()
  review_list <- as.character()
  score_list <- as.integer()
  sentiment_list <- as.integer()
  
  j = 1
  
  while(1){
    
    url <- paste(url_1,url_2,url_3,j,sep="")
    url2 <- paste(url_1,url_2,url_3,j+1,sep="")
    htxt <- read_html(url)
    htxt2 <- read_html(url2)
    
    date = html_nodes(htxt,'.score_reple em:nth-child(2)')
    date = html_text(date)
    date = gsub(".","-",date,fixed=TRUE)
    date = as.Date(date)
    review = html_nodes(htxt,'.score_reple p')
    review = html_text(review)
    review = str_sub(review, start = 4)
    score = html_nodes(htxt,'.score_result .star_score em')
    score = html_text(score)
    score = as.integer(score)
    
    date_list <- append(date_list,date)
    review_list <- append(review_list,review)
    score_list <- append(score_list,score)
    
    review2 = html_nodes(htxt2,'.score_reple p')
    review2 = html_text(review2)
    review2 = str_sub(review2, start = 4)
    
    if(review[1] == review2[1])
      break
    
    j = j + 1
    
  }
  
  for(score in score_list){
    if(score<=4)
      sentiment_list <- append(sentiment_list, -1)
    else if(score>=9)
      sentiment_list <- append(sentiment_list, 1)
    else
      sentiment_list <- append(sentiment_list, 0)
  }
  
  df = data.frame(date_list,review_list,score_list,sentiment_list)
  colnames(df) = c("date","review","score","sentiment")
  
  write.csv(df,paste(moviename[i],".csv",sep=""),sep=",",row.names = FALSE)
  
  }
}