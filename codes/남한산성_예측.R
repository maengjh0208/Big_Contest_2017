a <- read.csv("남한산성_train.csv" , sep =",")

train <- a[,-1]

model <- randomForest(log(eightdays_aud) ~. , data = train , mtry = 13)

test <- read.csv("남한산성_예측.csv" , sep =",")

pred = exp(predict(model,test))
