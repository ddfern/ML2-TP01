library(MASS)
library(randomForest)
data("Boston")

set.seed(123)
train <- sample(1:nrow(Boston), nrow(Boston) / 2)
X.train <- Boston[train, -14] # medv = y-variable in column 14
X.test <- Boston[-train, -14]
Y.train <- Boston[train, 14]
Y.test <- Boston[-train, 14]


rf.boston1 <- randomForest(X.train, Y.train, X.test, Y.test, mtry = 12, ntree = 500)
rf.boston2 <- randomForest(X.train, Y.train, X.test, Y.test, mtry = 6, ntree = 500)
rf.boston3 <- randomForest(X.train, Y.train, X.test, Y.test, mtry = sqrt(12), ntree = 500)
plot(1:500, rf.boston1$test$mse, col = "orange", type = "l", xlab = "Number of Trees", ylab = "Test MSE", ylim = c(10, 50))
lines(1:500, rf.boston2$test$mse, col = "black", type = "l")
lines(1:500, rf.boston3$test$mse, col = "red", type = "l")
legend("topright", c("m = p", "m = p/2", "m = sqrt(p)"), col = c("orange", "black", "red"), cex = 1, lty = 1)

# The MSE decreases as the number of trees increase and the test MSE stabilizes over time
# MSE is higher when all predictors are included compared to only half of the predictors or even less
# The minimum test MSE is observed when the square root of the number of predictors is used