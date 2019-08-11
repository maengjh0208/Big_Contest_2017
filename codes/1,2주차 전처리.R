totalmoive = read.csv("14-17.08 康拳穿利包按荐.csv", sep =",")
moviename = as.character(totalmoive$title)
filename = paste(moviename,".csv", sep="")

## 1林瞒 包按荐 ##
newdata = data.frame()

for(i in 1:length(moviename)){
  
  movie = read.csv(filename[i], sep =",")
  col_name = colnames(movie)
  colname = col_name[-c(5,13,14,15)]
  colname[3] = "first_week_audience"
  colname[4] = "first_day_screen"
  colname[11] = "first_week_date"
  
  f_week_aud = sum(movie[1:7,3])
  f_day_screen = sum(movie[1,5])
  subfile = movie[7,]
  subfile[3] = f_week_aud
  subfile[4] = f_day_screen
  subfile = subfile[,-c(5,13,14,15)]
  colnames(subfile) = colname
  newdata = rbind(newdata,subfile)
  
}

write.csv(newdata, "1林瞒 包按.csv" , row.names = F , sep = ",")


## 2林瞒 包按荐 ##
newdata = data.frame()

for(i in 1:length(moviename)){
  
  movie = read.csv(filename[i], sep =",")
  col_name = colnames(movie)
  colname = col_name[-c(5,13,14,15)]
  colname[3] = "second_week_audience"
  colname[4] = "first_day_screen"
  colname[11] = "second_week_date"
  
  s_week_aud = sum(movie[8:14,3])
  f_day_screen = sum(movie[1,5])
  subfile = movie[14,]
  subfile[3] = s_week_aud
  subfile[4] = f_day_screen
  subfile = subfile[,-c(5,13,14,15)]
  colnames(subfile) = colname
  newdata = rbind(newdata,subfile)
  
}

write.csv(newdata, "2林瞒 包按.csv" , row.names = F , sep = ",")
