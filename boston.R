library(mlbench)
library(caret)

data(BostonHousing)
trainIdx_boston <- createDataPartition(BostonHousing$medv, p=0.80, list = FALSE)
train_boston <- BostonHousing[trainIdx_boston,]
test_boston <- BostonHousing[-trainIdx_boston,]
train_boston$chas <- as.numeric(train_boston$chas)
test_boston$chas <- as.numeric(test_boston$chas)

control <- trainControl(method='repeatedcv',
                        number=10,
                        repeats=3)

GLM_model <- train(medv~.,
                   data=train_boston,
                   method='glm',
                   trControl=control,
                   metric='RMSE',
                   preProc=c('center', 'scale'))

library(accuinsight)

accu = accuinsight()
# accu$set_user_id("")
accu$add_experiment(GLM_model, test_boston)