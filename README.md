# Churn-Rate-Prediction-Using-Decision-Tree-vs-Random-Forest-IYKRA-Homework
This is my homework for my Offline Training at IYKRA, Jakarta, Indonesia.

Churn Rate Prediction is a Classification Machine Learning Problem and I am Using Decision Tree and Random Forest technique. The main goal is to predict wether the current employee in one period of time will churn / resign or not. The label is churn vs no churn with the data points representing the employee and their features / characteristic in the company. This ML may be done per month or per quarter or per semester or per year to evaluate the company churn rate and create policy to reduce the churn rate.

Steps done in the code :
1. Split Training Data-Testing Data : 70% vs 30% from the total population
2. Feed / train the model with the Training Data
3. Create prediction from the model
4. Merge and compare the prediction and Testing Data
5. Create Confusion Matrix : prediction vs Testing Data
6. Compare Confusion Matrix Parameter : Decision Tree model vs Random Forest model
* extra : create Random Forest model with 500 trees (the first Random Forest model only consists of 100 trees)
* extra : create Random Forest model with different mtry (with For Loop function) - (mtry 3 to 9)
* Mtry: Number of variables randomly sampled as candidates at each split. Note that the default values are different for classification (sqrt(p) where p is number of variables in x) and regression (p/3) 
