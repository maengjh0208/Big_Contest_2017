library(MASS)


a <- read.csv("movies2.csv" , sep = ",")
a <- subset(a,is.na(a$positive)==FALSE)

train_data <- a[,-1]
date = 1:nrow(train_data)
linear_model1 <- lm(first_week_audience ~. , data = train_data)
plot(date, train_data$first_week_audience)
summary(linear_model1)

bc <- boxcox(linear_model1)
which.max(bc$y)
lambda <- bc$x[which.max(bc$y)]
lambda <- 0.1818
linear_model2 <- lm((first_week_audience)^lambda ~., data = train_data)
plot(date, (train_data$first_week_audience)^lambda)
summary(linear_model2)
plot(linear_model2)


