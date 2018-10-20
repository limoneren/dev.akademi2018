#install.packages("jsonlite")
#install.packages("caTools")
#install.packages("reshape2")
#install.packages("plyr")

library(jsonlite)
library(caTools)
library(reshape2)
library(plyr)

args = commandArgs(trailingOnly=TRUE) 
arg1 <- args[1]
arg2 <- args[2]

## parsing data to a matrix and seperating clicked ones

all_data <- fromJSON(txt = "all_data 3.json")


write.csv(all_data, file = "test.csv")
all_data_matrix <- as.matrix(all_data)

impression_and_clicked <- all_data[which(all_data[,14] == 'CLICK'),][,c(12,13,16)]
impression_and_clicked <- impression_and_clicked[ , c(3,2,1)]

write.csv(impression_and_clicked, file = "bid_price_prediction.csv", row.names = FALSE)

dataset = read.csv('bid_price_prediction.csv')

impression_and_clicked_matrix <- mapply(impression_and_clicked, FUN=as.character)

## (bid, budget) and (clicked or not) relationship

first_relationship <- all_data[,12:14]

X <- first_relationship[,1:2]
for(i in 1:nrow(first_relationship)){
  if(!is.na(X[i,1])){
  }
}

X <- mapply(X, FUN=as.numeric)
X <- matrix(data = X, nrow = 101557, ncol = 2)

y_truth <- matrix(0, nrow = nrow(first_relationship), ncol = 1)

for(i in 1:nrow(first_relationship)){
  current <- first_relationship[i,3] == "CLICK"
  if(!is.na(current)){
    if(current == TRUE) {
      y_truth[i,1] <- 1
    } else {
      y_truth[i,1] <- 0
    }
  } else {
    y_truth[i,1] <- 0
  }
  
}

N <- length(y_truth)

sigmoid <- function(X, w, w0) {
  return (1 / (1 + exp(-(X %*% w + w0))))
}

gradient_w <- function(X, y_truth, y_predicted) {
  return (-colSums(matrix(y_truth - y_predicted, nrow = nrow(X), ncol = ncol(X), byrow = FALSE) * X))
}

gradient_w0 <- function(y_truth, y_predicted) {
  return (-sum(y_truth - y_predicted))
}

scaled_range <- function(x){(x-min(x))/(max(x)-min(x))}

safelog <- function(x) {
  x[x == 0] <- 1
  return (log(x))
}
# X_1 <- scaled_range(X[,1])

# learning parameters
eta <- 0.01
epsilon <- 1e-3

# randomly initalize w and w0
set.seed(100)
w <- runif(ncol(X), min = -0.01, max = 0.01)
w0 <- runif(1, min = -0.01, max = 0.01)

# learn w and w0 using gradient descent
iteration <- 1
objective_values <- c()

while (0) {
  
  if(!is.na(w) & !is.na(w0)){
    y_predicted <- sigmoid(X, w, w0)
    
    objective_values <- c(objective_values, -sum(y_truth * safelog(y_predicted) + (1 - y_truth) * safelog(1 - y_predicted)))
    
    w_old <- w
    w0_old <- w0
    
    w <- w - eta * gradient_w(X, y_truth, y_predicted)
    w0 <- w0 - eta * gradient_w0(y_truth, y_predicted)
    
    if (sqrt((w0 - w0_old)^2 + sum((w - w_old)^2)) < epsilon) {
      break
    }
    
  }
  
  iteration <- iteration + 1
}

split = sample.split(dataset$ad_bid_price_kurus, SplitRatio = 0.8)
training_set = subset(dataset, split == TRUE)
test_set = subset(dataset, split == FALSE)

dataset$event_category = factor(dataset$event_category,
                       levels = c('İkinci El ve Sıfır Alışveriş', 'Emlak', 'Vasıta', 'Yedek Parça, Aksesuar, Donanım & Tuning', 'İş Makineleri & Sanayi', 'Hayvanlar Alemi'),
                       labels = c(1, 2, 3, 4, 5, 6))

regressor = lm(formula = ad_bid_price_kurus ~ .,
               data = training_set)

df <- data.frame(
    event_category =c(arg2),
    ad_daily_budget_kurus = c(as.numeric(arg1)),
    ad_bid_price_kurus = c(0)
  )
y_pred = predict(regressor, newdata = test_set)
y_pred2 = predict(regressor, newdata = df)

print(y_pred2)
