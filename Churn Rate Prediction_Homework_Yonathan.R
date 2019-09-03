# Load packages
library(rpart) # package yang memuat fungsi rpart (decision tree)
library(randomForest) # package yang memuat fungsi randomForest
library(tidyverse) # package untuk formatting table

# Load data
df_employee <- read.csv("https://raw.githubusercontent.com/arikunco/machinelearning/master/dataset/HR_comma_sep.csv")
tail(df_employee)

# Split test and train
df_employee$left <- as.factor(df_employee$left)
urutan <- sample(1:nrow(df_employee),as.integer(0.7*nrow(df_employee)))
trainDataLog <- df_employee[urutan,]
summary(trainDataLog)
testDataLog <- df_employee[-urutan,]
summary(testDataLog)

# Decision Tree
# Decision Tree Training
tree <- rpart(left ~ ., 
              data = data.frame(trainDataLog), method = "class")
tree
summary(tree)

# Decision Tree Prediction
pred1 <- predict(tree, data.frame(testDataLog),type="class" )
pred1

dfpred1 <- data.frame(prediksi=pred1)
dfpred1
testDataLog

# Membuat confusion matrix dengan fungsi table()
conf1 <- table(testDataLog[,'left'],pred1)
conf1
sum(conf1)

# Meng-Assign TP, FN, FP and TN dari conf 
TP1 <- conf1[1, 1] 
TP1
FN1 <- conf1[1, 2] 
FN1
FP1 <- conf1[2, 1] 
FP1
TN1 <- conf1[2, 2] 
TN1

# Menghitung akurasi 
acc1 <- (TP1+TN1)/(TP1+FN1+FP1+TN1)
acc1
mean(pred1 == testDataLog$left)

# Menghitung presisi
prec1 <- TP1 / (TP1+FP1)
prec1

# Menghitung recall
rec1 <- TP1 / (TP1+FN1)
rec1

# Bagaimana menghitung specificity? 
spec1 <- TN1 / (TN1+FP1)
spec1

# Membuat dataframe parameter Decision Tree
paramTree <- data.frame(Parameter = c("Akurasi", "Presisi", "Recall", "Specificity"), DecisionTree = c(acc1, prec1, rec1, spec1))
paramTree

# Random Forest
# Random Forest Training 
randomFor <- randomForest(left ~ ., data = data.frame(trainDataLog), ntree=100, importance = TRUE)
randomFor
summary(randomFor)

# Random Forest Prediction
pred2 <- predict(randomFor, data.frame(testDataLog),type="class")
pred2

dfpred2 <- data.frame(prediksi=pred2)
dfpred2
testDataLog

# Membuat confusion matrix dengan fungsi table()
conf2 <- table(testDataLog[,'left'], pred2)
conf2
sum(conf2)

# Meng-Assign TP, FN, FP and TN dari conf 
TP2 <- conf2[1, 1] 
TP2
FN2 <- conf2[1, 2] 
FN2
FP2 <- conf2[2, 1] 
FP2
TN2 <- conf2[2, 2] 
TN2

# Menghitung akurasi 
acc2 <- (TP2+TN2)/(TP2+FN2+FP2+TN2)
acc2
mean(pred2 == testDataLog$left)

# Menghitung presisi
prec2 <- TP2 / (TP2+FP2)
prec2

# Menghitung recall
rec2 <- TP2 / (TP2+FN2)
rec2

# Bagaimana menghitung specificity? 
spec2 <- TN2 / (TN2+FP2)
spec2

# Membuat dataframe parameter Random Forest
paramForest <- data.frame(Parameter = c("Akurasi", "Presisi", "Recall", "Specificity"), RandomForest = c(acc2, prec2, rec2, spec2))
paramForest
paramTree

# Parameter Decision Tree vs Random Forest
paramAll <- left_join(paramTree, paramForest, by="Parameter")
paramAll

# Dari paramAll, dapat ditarik kesimpulan metodologi Random Forest lebih baik dari Decision Tree karena semua parameter Random Forest lebih baik dari Decision Tree

# Random Forest 500 Tree
# Random Forest Training 
randomFor2 <- randomForest(left ~ ., data = data.frame(trainDataLog), ntree=500, importance = TRUE)
randomFor2
summary(randomFor2)

# Random Forest Prediction
pred22 <- predict(randomFor2, data.frame(testDataLog),type="class")
pred22

dfpred22 <- data.frame(prediksi=pred22)
dfpred22
testDataLog

# Membuat confusion matrix dengan fungsi table()
conf22 <- table(testDataLog[,'left'], pred22)
conf22
sum(conf22)

# Meng-Assign TP, FN, FP and TN dari conf 
TP22 <- conf22[1, 1] 
TP22
FN22 <- conf22[1, 2] 
FN22
FP22 <- conf22[2, 1] 
FP22
TN22 <- conf22[2, 2] 
TN22

# Menghitung akurasi 
acc22 <- (TP22+TN22)/(TP22+FN22+FP22+TN22)
acc22
mean(pred22 == testDataLog$left)

# Menghitung presisi
prec22 <- TP22 / (TP22+FP22)
prec22

# Menghitung recall
rec22 <- TP22 / (TP22+FN22)
rec22

# Bagaimana menghitung specificity? 
spec22 <- TN22 / (TN22+FP22)
spec22

# Membuat dataframe parameter Random Forest
paramForest2 <- data.frame(Parameter = c("Akurasi", "Presisi", "Recall", "Specificity"), RandomForest500 = c(acc2, prec2, rec2, spec2))
paramForest2
paramForest
paramTree

# Parameter Decision Tree vs Random Forest vs Random Forest 500
paramAll2 <- left_join(paramAll, paramForest2, by="Parameter")
paramAll2

# Dari paramAll2, dapat ditarik kesimpulan metodologi Random Forest dengan 500 tree memberikan prediksi yang sama dengan Random Forest dengan 100 tree

# Using For loop to identify the right mtry for model
a=c()
for (i in 3:9) {
  randomFori <- randomForest(left ~ ., data = data.frame(trainDataLog), ntree = 500, mtry = i, importance = TRUE)
  predi <- predict(randomFori, data.frame(testDataLog), type = "class")
  print(mean(predi == data.frame(testDataLog)$left))
  a[i-2] = mean(predi == data.frame(testDataLog)$left)
}
a
dfmtry <- data.frame(mtry = c(3:9), akurasi = a)
dfmtry

# Dari dfmtry, dapat ditarik kesimpulan :
## Akurasi paling tinggi adalah dengan mtry = 4
## Akurasi menurun saat mtry dinaikkan lebih dari 4
## Walaupun Akurasi berubah-ubah, tetapi rata-rata sekitar 99% jadi model sudah baik dengan mtry berapa pun
## Waktu running dengan ntree yang lebih banyak akan membutuhkan waktu yang lebih banyak
## waktu running dengan looping membutuhkan waktu yang lebih banyak
## Waktu running dengan fungsi membanding (==) satu per satu file membutuhkan waktu yang lebih banyak

# Tes hitung akurasi mtry = 3 dan mtry = 4 manual
randomFor3 <- randomForest(left ~ ., data = data.frame(trainDataLog), ntree = 500, importance = TRUE)
pred3 <- predict(randomFor3, data.frame(testDataLog), type = "class")
mean(pred3 == data.frame(testDataLog)$left)

randomFor4 <- randomForest(left ~ ., data = data.frame(trainDataLog), ntree = 500, mtry = 4, importance = TRUE)
pred4 <- predict(randomFor4, data.frame(testDataLog), type = "class")
mean(pred4 == data.frame(testDataLog)$left)
