import pandas as pd
import matplotlib.pyplot as plt
import numpy as np
import seaborn as sns
import os

df = pd.read_csv('./data/heart.csv')
df = df.drop('x', axis=1)


'''
age - age in years 
sex - (1 = male; 0 = female) 
cp - chest pain type 
trestbps - resting blood pressure (in mm Hg on admission to the hospital) 
chol - serum cholestoral in mg/dl 
fbs - (fasting blood sugar > 120 mg/dl) (1 = true; 0 = false) 
restecg - resting electrocardiographic results 
thalach - maximum heart rate achieved 
exang - exercise induced angina (1 = yes; 0 = no) 
oldpeak - ST depression induced by exercise relative to rest 
slope - the slope of the peak exercise ST segment 
ca - number of major vessels (0-3) colored by flourosopy 
thal - 3 = normal; 6 = fixed defect; 7 = reversable defect 
target - have disease or not (1=yes, 0=no)
'''



df = df.drop(df[df['age'] < 0].index)

media = df['age'].mean()
moda = df['age'].mode()[0]
mediana = df['age'].median()


conteggio_age = df['age'].value_counts().sort_index()

plt.bar(conteggio_age.index, conteggio_age.values)
plt.xlabel('age')
plt.ylabel('Numero di Utenti')
plt.title('Distribuzione delle age degli utenti')

plt.savefig(os.path.join('./graph/grafici_analisi', 'grafico_age.png'))
plt.close()


df['sex'] = df['sex'].astype(str)
df['sex'] = df['sex'].replace({'1': 'M', '0': 'F'})
df = df[df['sex'].isin(['M', 'F'])]
df['sex'] = df['sex'].replace({'M': '1', 'F': '0'})


conteggio_sex = df['sex'].value_counts()

plt.pie(conteggio_sex, labels=conteggio_sex.index, autopct='%1.1f%%')
plt.title('Distribuzione del genere')

plt.savefig(os.path.join('./graph/grafici_analisi', 'grafico_genere.png'))
plt.close()

df['cp'] = df['cp'].astype(str)
df['cp'] = df['cp'].str.replace('\.0', '')  
df['cp'] = df['cp'].str[0]

conteggio_cp = df['cp'].value_counts().sort_index()



plt.bar(conteggio_cp.index, conteggio_cp.values)
plt.xlabel('Tipo di dolore toracico')
plt.ylabel('Numero di Utenti')
plt.title('Distribuzione del tipo di dolore toracico')

plt.savefig(os.path.join('./graph/grafici_analisi', 'grafico_dolore_toracico.png'))
plt.close()


df = df.rename(columns={'trestbps': 'trestbps'})
df = df[(df['trestbps'] >= 100) & (df['trestbps'] <= 180)]

media = df['trestbps'].mean()
moda = df['trestbps'].mode()[0]
mediana = df['trestbps'].median()
minimo = df['trestbps'].min()
massimo = df['trestbps'].max()


conteggio_pressione = df['trestbps'].value_counts().sort_index()

plt.bar(conteggio_pressione.index, conteggio_pressione.values)
plt.xlabel('Pressione Sanguigna a Riposo (mm Hg)')
plt.ylabel('Numero di Utenti')
plt.title('Distribuzione della Pressione Sanguigna a Riposo')

plt.savefig(os.path.join('./graph/grafici_analisi', 'grafico_pressione_sangue.png'))
plt.close()




df = df.rename(columns={'chol': 'chol'})
df['chol'] = pd.to_numeric(df['chol'], errors='coerce')
df = df[df['chol'] <= 300]

conteggio_colesterolo = df['chol'].value_counts().sort_index()

plt.bar(conteggio_colesterolo.index, conteggio_colesterolo.values)
plt.xlabel('Colesterolo Sierico (mg/dl)')
plt.ylabel('Numero di Utenti')
plt.title('Distribuzione del Colesterolo Sierico')

plt.savefig(os.path.join('./graph/grafici_analisi', 'grafico_colesterolo.png'))
plt.close()


df = df.rename(columns={'fbs': 'fbs'})
df = df[df['fbs'].isin([0, 1])]
df['fbs'] = df['fbs'].astype(int)
conteggio_zucchero = df['fbs'].value_counts()

labels = ['Non digiuno (> 120 mg/dl)', 'Digiuno (≤ 120 mg/dl)']

plt.pie(conteggio_zucchero, labels=labels, autopct='%1.1f%%')
plt.title('Distribuzione dello Zucchero nel Sangue a Digiuno')

annotation_text = '1 = Zucchero > 120 mg/dl\n0 = Zucchero ≤ 120 mg/dl'
plt.annotate(annotation_text, xy=(0.5, 0.5), xycoords='axes fraction',
             fontsize=12, ha='center')

plt.savefig(os.path.join('./graph/grafici_analisi', 'grafico_zucchero_sangue.png'))
plt.close()

df =df.rename(columns={'restecg': 'restecg'})

unique_values = df["restecg"].unique()

value_counts = df["restecg"].value_counts()
plt.bar(value_counts.index, value_counts.values)
plt.xticks(value_counts.index, ['Normale', 'Anomalia ST-T', 'Ipertrofia ventricolare sinistra'])

plt.xlabel("")
plt.ylabel("Conteggio")
plt.title("Distribuzione dei risultati ECG a riposo")
plt.savefig(os.path.join('./graph/grafici_analisi', 'grafico_ECG_riposo.png'))
plt.close()

df = df.rename(columns={"thalach": "thalach"})

value_counts = df["thalach"].value_counts()
'''
plt.bar(value_counts.index, value_counts.values)
plt.xlabel("Valori")
plt.ylabel("Conteggio")
plt.title("Distribuzione del tasso cardiaco massimo raggiunto")
'''
# viste le analisi fatte ora andiamo ad usare la tecnica della rimozione degli outlier!

Q1 = df["thalach"].quantile(0.25)
Q3 = df["thalach"].quantile(0.75)
IQR = Q3 - Q1


lower_bound = Q1 - 1.5 * IQR
upper_bound = Q3 + 1.5 * IQR
filtered_df = df[(df["thalach"] >= lower_bound) &
                  (df["thalach"] <= upper_bound)]

value_counts = filtered_df["thalach"].value_counts()


plt.bar(value_counts.index, value_counts.values)

plt.xlabel("Valori")
plt.ylabel("Conteggio")
plt.title("Distribuzione del tasso cardiaco massimo raggiunto (senza outlier)")

plt.savefig(os.path.join('./graph/grafici_analisi', 'grafico_thalach.png'))
plt.close()


df = df.rename(columns={"exang": "exang"})

value_counts = df["exang"].value_counts()
plt.bar(["No", "Sì"], value_counts)

plt.xlabel("Valori")
plt.ylabel("Conteggio")
plt.title("Distribuzione dell'angina indotta dall'esercizio")
plt.savefig(os.path.join('./graph/grafici_analisi', 'grafico_exang.png'))
plt.close()


df = df.rename(columns={"oldpeak": "oldpeak"})
sns.kdeplot(df["oldpeak"])

plt.xlabel("ST Depression")
plt.ylabel("Densità")
plt.title("Distribuzione della depressione ST indotta dall'esercizio")
plt.savefig(os.path.join('./graph/grafici_analisi', 'grafico_oldpeak.png'))
plt.close()

df = df.rename(columns={"slope": "slope"})

unique_values = df["slope"].unique()

value_counts = df["slope"].value_counts()

plt.bar(value_counts.index, value_counts.values)

plt.xlabel("Valori")
plt.ylabel("Conteggio")
plt.title("Distribuzione dell'inclinazione del segmento ST")
plt.savefig(os.path.join('./graph/grafici_analisi', 'grafico_inclinazione_ST.png'))
plt.close()


df = df.rename(columns={"ca": "ca"})
unique_values = df["ca"].unique()
value_counts = df["ca"].value_counts()
df = df[df["ca"] != 4]
unique_values = df["ca"].unique()

sns.kdeplot(df["ca"])
plt.xlabel("Numero di vasi principali")
plt.ylabel("Densità")
plt.title("Distribuzione del numero di vasi principali")
plt.savefig(os.path.join('./graph/grafici_analisi', 'grafico_n_vasi.png'))
plt.close()


# ora qui faccio le ultime analisi sulla colonna num che è il target dove poi faremo le analisi di machine learning!


unique_values = df["target"].unique()
value_counts = df["target"].value_counts()

df = df.rename(columns={"target": "target"})
value_counts = df["target"].value_counts()

plt.figure(figsize=(8, 6))
plt.bar(value_counts.index, value_counts.values)

plt.xlabel("Diagnosi Malattia Cardiaca")
plt.ylabel("Conteggio")
plt.title("Distribuzione Diagnosi Malattia Cardiaca")
plt.savefig(os.path.join('./graph/grafici_analisi', 'grafico_diagnosi.png'))
plt.close()


# Ssalvo il dataframe in csv per poter applicare il ML da qui in poi in un altro file!
df.to_csv('./data/new_heart.csv', index=False)
