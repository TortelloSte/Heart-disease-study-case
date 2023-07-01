import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt
import os 

df = pd.read_csv('./data/new_heart.csv')

# ora che i dati sono stati corretti, andiamo a esplorarli in maniera approfondita

sns.countplot(x="target", data=df, palette="bwr")
plt.savefig(os.path.join('./graph/grafici_ML', 'target.png'))

no = len(df[df.target == 0])
yes = len(df[df.target == 1])
print("Percentuale dei pazienti senza malattia cardiaca: {:.2f}%".format((no / len(df.target)) * 100))
print("Percentuale dei pazienti con malattia cardiaca: {:.2f}%".format((yes / len(df.target)) * 100))


sns.countplot(x='sex', data=df, palette="mako_r")
plt.xlabel("Sex (0 = female, 1= male)")
plt.show()

print(df['sex'].value_counts())