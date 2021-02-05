#Read in the data   
cdata <- read.table("german.data", h=F, sep = ' ')

#Add readable column names
colnames(cdata) <- c("chkngAcctStatus", "durationMonths", "creditHistory", "loanPurpose", "creditAmount", "savingsTotal", "crrntEmplmtSince", "instllmtPct", "persnlStatus", "othrDebtorGuaranters", "crrntResidenceSince", "propertyType", "age", "otherInstllmtType", "housingType", "existingCredits","jobStatus", "numDependents", "registeredPhone", "foriegnWorker", "goodBad")

#Change the target variable into categorical with values 'Good' and 'Bad' 
cdata$goodBad<-as.factor(ifelse(cdata$goodBad == 1, "Good", "Bad"))

cdata %>% plot_ly(x = cdata$goodBad, type = "histogram") %>% layout(title = "Histogram of 'Good' vs 'Bad'")

#A base plot is created across Total savings and the target:

plot(cdata$savingsTotal, cdata$goodBad, 
     main="Savings account/bonds ~ Good-Bad",
     xlab="Savings/Bonds",
     ylab="Good-Bad", legend = T)

#Then the next piece of code shows the median loan duration in months against defaults:

cdata_df <- tbl_df(cdata)

cdata_df %>% group_by(goodBad) %>% summarise(meanMonths = mean(durationMonths), medianMonths = median(durationMonths))  %>% plot_ly(x = ~goodBad, y = ~medianMonths, type = "bar") %>% layout(title = " median loan duration in months vs goodBad")

#We then created Scatter plot of Credit Amount and Age with color separation of Good and Bad loans:
cdata_df %>% plot_ly(x = ~age, y = ~creditAmount, color = ~goodBad, colors = c("red", "blue"), type = "scatter", mode = "markers" ) %>% layout(title = "Age vs creditAmount by goodBad")

