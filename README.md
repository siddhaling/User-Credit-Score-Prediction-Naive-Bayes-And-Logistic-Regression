# User-Credit-Score-Prediction-Naive-Bayes-And-Logistic-Regression

Due to the incessant expansion of the financial and banking institutions, credit based products play an increasingly important role in the economy. With the Economic globalization and the emergence of new platforms through which services are provided, such as the internet, a large number of customers are empowered to select creditors without regional limitations. This however complicates the banking processes.
A key factor in the success of any lending organization, Banks in particular, is the appraisal of the borrowers credit-worthiness during the credit scoring process. The borrower's credit- worthiness can be accessed by analysing credit scores. Current debt, length of credit, types of credit and payment history are some of the categories that can influence a borrower’s credit score.
Credit Risk assessment is a key process conducted by Banks, which helps them to forecast if a loan applicant can be a defaulter at a later stage. Identifying the credit defaulter accurately is next to impossible however the severity of the loss resulting from failure to meet contractual obligations or repay a loan, can be reduced by proper assessment and management of the credit risk involved.
In this paper we opted to utilize the strategies of Data Science so we could find a long run solution to address the complexities involved in the Credit Scoring techniques. The techniques involved in Data Science helps in collecting a large set of data, processing it and generating inferences from it. Moreover, they help in finding a pattern in the dataset, that wouldn’t have been feasible otherwise. we utilize a few of these methods to examine the complexities in the Credit Scoring Method.

## About the Dataset:
The ‘Credit Approval Data Set’ available on UCI Machine Learning Repository is used.The dataset has 21 columns showing the fiscal and demographic statistics for use in credit scoring. https://archive.ics.uci.edu/ml/datasets/credit+approval

The last column (goodBad) is the indicator variable on loan defaults, which has been used as the target in the learning algorithms. The following are the descriptive tags given to these variables:
    1. chkngAcctStatus
    2. durationMonths
    3. creditHistory
    4. loanPurpose
    5. creditAmount
    6. savingsTotal
    7. crrntEmplmtSince
    8. instllmtPct
    9. persnlStatus
    10. othrDebtorsGuaranters
    11. crrntResidenceSince
    12. propertyType
    13. age
    14. otherInstllmtType
    15. housingType
    16. existingCredits
    17. jobStatus
    18. numDependents
    19. registeredPhone
    20. foriegnWorker
    21. goodBad
![alt text](https://github.com/siddhaling/User-Credit-Score-Prediction-Naive-Bayes-And-Logistic-Regression/blob/main/images/1.jpg)

Collected data is pre-processed before the modeling phase. Sampling is used so that the models have a chance to figure out the characteristics of both the ‘good’ and the ‘bad’ credit records. Feature selection is then done to make the data mining and machine learning process more efficient. The purpose of feature selection is to build simple but comprehensive models with better predictive accuracy and better understanding of data. The Machine Learning Algorithms applied in this paper include Naive Bayes and Logistic Regression. The results are then obtained and assessed.

The following is the code for the pre-processing of the data set. 
The first operation reads in the data. Next we add comprehensive column names & change target variables with values ‘Good’ or ‘Bad’.
#Read in the data   
cdata <- read.table("german.data", h=F, sep = ' ')
#Add readable column names
colnames(cdata) <- c("chkngAcctStatus", "durationMonths", "creditHistory", "loanPurpose", "creditAmount", "savingsTotal", "crrntEmplmtSince", "instllmtPct", "persnlStatus", "othrDebtorGuaranters", "crrntResidenceSince", "propertyType", "age", "otherInstllmtType", "housingType", "existingCredits","jobStatus", "numDependents", "registeredPhone", "foriegnWorker", "goodBad")
#Change the target variable into categorical with values 'Good' and 'Bad' 
cdata$goodBad<-as.factor(ifelse(cdata$goodBad == 1, "Good", "Bad"))

The distribution Target Variables on a histogram as follows;
cdata %>% plot_ly(x = cdata$goodBad, type = "histogram") %>% layout(title = "Histogram of 'Good' vs 'Bad'")

![alt text](https://github.com/siddhaling/User-Credit-Score-Prediction-Naive-Bayes-And-Logistic-Regression/blob/main/images/2.jpg)

A base plot is created across Total savings and the target:
plot(cdata$savingsTotal, cdata$goodBad, 
     main="Savings account/bonds ~ Good-Bad",
     xlab="Savings/Bonds",
     ylab="Good-Bad", legend = T)

![alt text](https://github.com/siddhaling/User-Credit-Score-Prediction-Naive-Bayes-And-Logistic-Regression/blob/main/images/3.jpg)
Then the next piece of code shows the median loan duration in months against defaults:
cdata_df <- tbl_df(cdata)

cdata_df %>% group_by(goodBad) %>% summarise(meanMonths = mean(durationMonths), medianMonths = median(durationMonths))  %>% plot_ly(x = ~goodBad, y = ~medianMonths, type = "bar") %>% layout(title = " median loan duration in months vs goodBad")

![alt text](https://github.com/siddhaling/User-Credit-Score-Prediction-Naive-Bayes-And-Logistic-Regression/blob/main/images/4.jpg)

We then created Scatter plot of Credit Amount and Age with color separation of Good and Bad loans:

cdata_df %>% plot_ly(x = ~age, y = ~creditAmount, color = ~goodBad, colors = c("red", "blue"), type = "scatter", mode = "markers" ) %>% layout(title = "Age vs creditAmount by goodBad")

![alt text](https://github.com/siddhaling/User-Credit-Score-Prediction-Naive-Bayes-And-Logistic-Regression/blob/main/images/5.jpg)

A histogram of the probability of ‘Bad’ loans by credit history.
df = pd.read_table("german.data",header = None, sep=' ',names = ['chkngAcctStatus', 'durationMonths', 'creditHistory', 'loanPurpose', 'creditAmount', 'savingsTotal', 'crrntEmplmtSince', 'instllmtPct', 'persnlStatus', 'othrDebtorGuaranters', 'crrntResidenceSince', 'propertyType', 'age', 'otherInstllmtType', 'housingType', 'existingCredits','jobStatus', 'numDependents', 'registeredPhone', 'foriegnWorker', 'goodBad']) 

temp = df.pivot_table(values='goodBad',index=['creditHistory'],aggfunc=lambda x: x.map({1:0,2:1}).mean())

fig = plt.figure(figsize=(7,4))
ax2 = fig.add_subplot(111)
temp.plot(kind = 'bar')
ax2.set_xlabel('Credit_History')
ax2.set_ylabel('Bad%')
ax2.set_title("Probability of bad loans by credit history")

![alt text](https://github.com/siddhaling/User-Credit-Score-Prediction-Naive-Bayes-And-Logistic-Regression/blob/main/images/6.jpg)

The methods used for classification of data are logistic regression and Naive Bayes Classification.Python programming language was used to code for the Naive Bayes Classification and R programming was used for Logistic Regression.These techniques are built to classify or identify whether a bank can approve a loan based on the Credit Score.
Naive Bayes Model is  imported and the Naive Bayes Classifier object is created. Function fit() is used to fit the model on the training set.  Performance is predicted using predict() function.Confusion Matrix is generated and for further evaluation precision and recall can be computed from confusion matrix.

 Predictions on whether a field is true or false can be done using Logistic Regression. It fits an S shaped logistic function through the data instead of a line. The S shaped curve ranges from 0 to 1 and shows the probability on the x-axis. This statistical technique predicts the occurrence of an event using a probability model that uses a linear combination of independent variables. The objective is to describe the data and the relationship between one dependent variable and one or more independent variables.
 
 True positive rate is plotted against the false positive rate. Receiver Operating Characteristic Curve depicts the relationship between sensitivity and specificity. AUC represents the area under the curve. We will be using Repeated K-Fold cross validation. The splitting of the data into k fold is repeated for a specified number of times. Classification error shows the percentage of samples that were incorrectly classified. Out-of-sample forecasting uses testing data to make predictions.
 
 This Naive Bayesian Code gives an output of 76.5% accuracy as shown.
 
 ![alt text](https://github.com/siddhaling/User-Credit-Score-Prediction-Naive-Bayes-And-Logistic-Regression/blob/main/images/7.jpg)
 
 Precision = 0.6260
 Recall = 0.6457

Area Under the Curve value for this Logistic Regression model is Area Under the Curve value for this Logistic Regression model is 78%. AUC performs well while measuring predictive accuracy. This shows that there's a 78% chance that the model is able to differentiate between the positive class and negative class.

![alt text](https://github.com/siddhaling/User-Credit-Score-Prediction-Naive-Bayes-And-Logistic-Regression/blob/main/images/8.jpg)
