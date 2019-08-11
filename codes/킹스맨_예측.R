library(randomForest)

a <- read.csv("킹스맨_train.csv" , sep =",")

train <- a[,-1]

model <- randomForest(log(aud_total) ~. , data = train , mtry = 10)

test <- read.csv("킹스맨_예측.csv" , sep =",")

pred = exp(predict(model,test))
