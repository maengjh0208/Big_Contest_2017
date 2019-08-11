library(FNN)
library(caret)
library(e1071)
library(MASS)
library(ForecastCombinations)


## function for MAPE
MAPE <- function(y,y_){
  error = abs(y-y_)/y
  return(mean(error))
}

set.seed(123)
ctrl <- trainControl(method = "cv", number = 10 , savePred=T)


## linear - regression
lm_data <- read.csv("킹스맨_1주차_lm.csv" , sep =",")
lm_data1 <- subset(lm_data,lm_data$p == 0)
lm_data1 <- lm_data1[,-14]
intrain <- createDataPartition(lm_data1$first_week_audience,p=0.75, list = FALSE)

lm_train <- lm_data[intrain,-1]
lm_test <- lm_data[-intrain,-1]
ind2 <- sample(NROW(lm_test), size = round(NROW(lm_test) * (3/4)))
lm_model <- lm(first_week_audience ~. , data = lm_train)

bc <- boxcox(lm_model)
lambda <- bc$x[which.max(bc$y)]

lm_train$first_week_audience <- lm_train$first_week_audience^lambda
lm_model <- train(first_week_audience ~. , data = lm_train , method = "lm" , trControl = ctrl )
lm_pred = predict(lm_model , lm_test)
target = lm_test$first_week_audience
MAPE(target,lm_pred^(1/lambda))

## knn - regression
knn_data <- read.csv("킹스맨_1주차_knn.csv" , sep = ",")

knn_train <- knn_data[intrain,-1]
knn_test <- knn_data[-intrain,-1]

knn_model <- knn.reg(knn_train[,-1],knn_test[,-1], y = log(knn_train$first_week_audience), k = 20)
knn_pred = knn_model$pred
target = knn_test$first_week_audience

MAPE(target,exp(knn_pred))

## svm - regression
svm_data <- read.csv("킹스맨_1주차_svm.csv" , sep = ",")

svm_train <- svm_data[intrain,-1]
svm_test <- svm_data[-intrain,-1]

OptModelsvm <- tune(svm, log(first_week_audience) ~., data=svm_train,ranges=list(elsilon=seq(0,1,0.1), cost=1:100))
svm_model = OptModelsvm$best.model
svm_pred = predict(svm_model, svm_test)
target = svm_test$first_week_audience

MAPE(target,exp(svm_pred))

## random forest - regression
rf_data <- read.csv("킹스맨_1주차_rf.csv" , sep =",")
rf_data <- rf_data[,-30]
rf_train <- rf_data[intrain,-1]
rf_test <- rf_data[-intrain,-1]

rf_train$first_week_audience <- log(rf_train$first_week_audience)
rf_model <- train(first_week_audience ~. , data = rf_train , method = "rf", trControl = ctrl)
rf_pred <- predict(rf_model , rf_test)
MAPE(target,exp(rf_pred))


## Forecasting combination
indiv_forecasts <- cbind(exp(knn_pred),exp(rf_pred))
ind_nam <- c("knn_pred","rf_pred") 
colnames(indiv_forecasts) <- ind_nam

scheme= c("simple", "ols", "robust", "variance based", "cls", "best")

combine_f <- list() 

for (i in scheme) { 
  combine_f[[i]] <- Forecast_comb(obs = target[ind2], 
                                  fhat = indiv_forecasts[ind2,],
                                  fhat_new = indiv_forecasts[-ind2, ], 
                                  Averaging_scheme = i) 
  tmp <- MAPE(target[-ind2],combine_f[[i]]$pred)
  cat(i, ":", tmp, "\n") 
}

combine_f$robust

cbind(target[-ind2],combine_f$simple$pred)
