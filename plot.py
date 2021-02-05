import pandas as pd
import matplotlib.pyplot as plt
import numpy as np

df = pd.read_table("german.data",header = None, sep=' ',names = ['chkngAcctStatus', 'durationMonths', 'creditHistory', 'loanPurpose', 'creditAmount', 'savingsTotal', 'crrntEmplmtSince', 'instllmtPct', 'persnlStatus', 'othrDebtorGuaranters', 'crrntResidenceSince', 'propertyType', 'age', 'otherInstllmtType', 'housingType', 'existingCredits','jobStatus', 'numDependents', 'registeredPhone', 'foriegnWorker', 'goodBad']) 

temp = df.pivot_table(values='goodBad',index=['creditHistory'],aggfunc=lambda x: x.map({1:0,2:1}).mean())

fig = plt.figure(figsize=(7,4))
ax2 = fig.add_subplot(111)
temp.plot(kind = 'bar')
ax2.set_xlabel('Credit_History')
ax2.set_ylabel('Bad%')
ax2.set_title("Probability of bad loans by credit history")
#saving the plot as image and then displaying that image (outside this chunk)

fig.savefig('credHist.jpg')