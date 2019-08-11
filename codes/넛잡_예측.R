
a <- read.csv("³ÓÀâ_train.csv" , sep =",")

train <- a[,-1]

model <- randomForest(log(eightdays_aud) ~. , data = train , mtry = 13)

test <- read.csv("³ÓÀâ_¿¹Ãø.csv" , sep =",")

pred = exp(predict(model,test))
