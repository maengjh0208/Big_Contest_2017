install.packages("caret")
library(caret)

a <- read.csv("킹스맨_1주차.csv" , sep =",")

head(a)

train <- a[,-1]
y <- train[,1]
x <- train[,-1]

normalization <- preProcess(x)
x <- predict(normalization, x)
x <- as.data.frame(x)


ga_ctrl <- gafsControl(functions = rfGA,
                       method = "cv",
                       repeats = 10)
set.seed(10)
obj <- gafs(x = x, 
            y = y,
            iters = 100 ,
            gafsControl = ga_ctrl,
            ## Now pass options to `train`
            method = "svmRadial") ## feature selecting SVM model 

bestFeatures <- obj$ga$final

print(bestFeatures)