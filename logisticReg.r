#Read in the data   
cdata <- read.table("german.data", h=F, sep = ' ')

#Add readable column names
colnames(cdata) <- c("chkngAcctStatus", "durationMonths", "creditHistory", "loanPurpose", "creditAmount", "savingsTotal", "crrntEmplmtSince", "instllmtPct", "persnlStatus", "othrDebtorGuaranters", "crrntResidenceSince", "propertyType", "age", "otherInstllmtType", "housingType", "existingCredits","jobStatus", "numDependents", "registeredPhone", "foriegnWorker", "goodBad")

set.seed(252)
split <- createDataPartition(y = cdata$goodBad, p = 0.7, list = F)
train <- cdata[split,] 
test <- cdata[-split,]
startMdl <- glm(goodBad ~., train, family = binomial)
stepMdl <- step(startMdl, trace = FALSE, steps = 5000, k= log(nrow(train)))
#display summary
summary(stepMdl)
varImp(stepMdl, scale = FALSE)
stepPr  = predict(stepMdl, newdata = test, type = "response")
stepPred = prediction(stepPr, test$goodBad)
stepPerf = performance(stepPred, "tpr", "fpr")
plot(stepPerf, colorize =TRUE, main = "ROC Curve", col = 2, lwd = 2, print.cutoffs.at=seq(0,1,by=0.1), text.adj=c(-0.2,1.7))
abline( a =0, b = 1, lwd = 2, lty = 2, col = "gray")
round(auc(test$goodBad, stepPr), digits = 2)
set.seed(123)
ctrl <- trainControl(method = "repeatedcv",repeats = 3,classProbs = TRUE,summaryFunction = twoClassSummary)

cvFit <- train(goodBad ~ .,data = train, method = "glm", family = binomial, tuneLength = 5, trControl = ctrl,
           metric = "ROC")

#display summary
summary(cvFit)
varImp(cvFit, scale = FALSE)
cvPr  = predict(cvFit, newdata = test, type = "prob")
cvPred = prediction(cvPr[,2], test$goodBad)
cvPerf = performance(cvPred, "tpr", "fpr")
plot(cvPerf, colorize =TRUE, main = "ROC Curve", col = 2, lwd = 2, print.cutoffs.at=seq(0,1,by=0.1), text.adj=c(-0.2,1.7))
abline( a =0, b = 1, lwd = 2, lty = 2, col = "gray")
round(auc(test$goodBad, cvPr[,2]), digits = 2)
