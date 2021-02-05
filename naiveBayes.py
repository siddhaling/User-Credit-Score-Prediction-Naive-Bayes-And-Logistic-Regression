from pandas import Series, DataFrame
import pandas as pd
import numpy as np
import os
import matplotlib.pylab as plt
from sklearn.cross_validation import train_test_split
from sklearn.tree import DecisionTreeClassifier
from sklearn.metrics import classification_report
import sklearn.metrics
 # Feature Importance
from sklearn import datasets
from sklearn.ensemble import ExtraTreesClassifier
from sklearn.preprocessing import LabelEncoder
from sklearn.naive_bayes import GaussianNB

#Function for one-hot encoding (dummy variable) of categorical variables

def encodeFeatures(df):
        columnsToEncode = list(df.select_dtypes(include=['category','object']))
        le = LabelEncoder()
        for feature in columnsToEncode:
            try:
                df[feature] = le.fit_transform(df[feature])
            except:
                print('Error encoding '+feature)
        return df


df = pd.read_table("german.data",header = None, sep=' ',names = ['chkngAcctStatus', 'durationMonths',          'creditHistory', 'loanPurpose', 'creditAmount', 'savingsTotal', 'crrntEmplmtSince', 'instllmtPct', 'persnlStatus', 'othrDebtorGuaranters', 'crrntResidenceSince', 'propertyType', 'age', 'otherInstllmtType', 'housingType', 'existingCredits','jobStatus', 'numDependents', 'registeredPhone', 'foriegnWorker', 'goodBad']) 


df['goodBad']=df["goodBad"] - 1

dfPred = encodeFeatures(df)

predictors = dfPred.drop('goodBad', 1)

targets = df['goodBad']


np.random.seed(123)
pred_train, pred_test, tar_train, tar_test  =   train_test_split(predictors, targets, test_size=.4)

model = GaussianNB()

model.fit(pred_train, tar_train)


# Train the model using Naive Bayesian classifier

predNB=model.predict(pred_test)

# Confustion Matrix
print "Confustion Matrix:" 
print sklearn.metrics.confusion_matrix(tar_test,predNB)
print "\n"
print "Accuracy: " + str(sklearn.metrics.accuracy_score(tar_test, predNB))
