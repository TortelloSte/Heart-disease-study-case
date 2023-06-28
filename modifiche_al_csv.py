import pandas as pd
import matplotlib.pyplot as plt
import numpy as np
import seaborn as sns
import os

df = pd.read_csv('./data/heart.csv')
df = df.drop('x', axis=1)

df = df.rename(columns={'age': 'età'})
df = df.drop(df[df['età'] < 0].index)

media = df['età'].mean()
moda = df['età'].mode()[0]
mediana = df['età'].median()


conteggio_età = df['età'].value_counts().sort_index()

plt.bar(conteggio_età.index, conteggio_età.values)
plt.xlabel('Età')
plt.ylabel('Numero di Utenti')
plt.title('Distribuzione delle età degli utenti')

plt.savefig(os.path.join('./graph', 'grafico_età.png'))
plt.close()

df = df.rename(columns={'sex': 'sesso'})

df['sesso'] = df['sesso'].astype(str)
df['sesso'] = df['sesso'].replace({'1': 'M', '0': 'F'})
df = df[df['sesso'].isin(['M', 'F'])]

conteggio_sesso = df['sesso'].value_counts()

plt.pie(conteggio_sesso, labels=conteggio_sesso.index, autopct='%1.1f%%')
plt.title('Distribuzione del genere')

plt.savefig(os.path.join('./graph', 'grafico_genere.png'))
plt.close()

df = df.rename(columns={'cp': 'chest pain'})
df['chest pain'] = df['chest pain'].astype(str)
df['chest pain'] = df['chest pain'].str.replace('\.0', '')  
df['chest pain'] = df['chest pain'].str[0]

conteggio_cp = df['chest pain'].value_counts().sort_index()



plt.bar(conteggio_cp.index, conteggio_cp.values)
plt.xlabel('Tipo di dolore toracico')
plt.ylabel('Numero di Utenti')
plt.title('Distribuzione del tipo di dolore toracico')

plt.savefig(os.path.join('./graph', 'grafico_dolore_toracico.png'))
plt.close()


df = df.rename(columns={'trestbps': 'pressione_riposo'})
df = df[(df['pressione_riposo'] >= 100) & (df['pressione_riposo'] <= 180)]

media = df['pressione_riposo'].mean()
moda = df['pressione_riposo'].mode()[0]
mediana = df['pressione_riposo'].median()
minimo = df['pressione_riposo'].min()
massimo = df['pressione_riposo'].max()

# print(f'media = {media}', f'moda = {moda}', f'mediana = {mediana}', f'minimo = {minimo}', f'massimo = {massimo}')

conteggio_pressione = df['pressione_riposo'].value_counts().sort_index()

plt.bar(conteggio_pressione.index, conteggio_pressione.values)
plt.xlabel('Pressione Sanguigna a Riposo (mm Hg)')
plt.ylabel('Numero di Utenti')
plt.title('Distribuzione della Pressione Sanguigna a Riposo')

plt.savefig(os.path.join('./graph', 'grafico_pressione_sangue.png'))
plt.close()




df = df.rename(columns={'chol': 'colesterolo_siero'})
df['colesterolo_siero'] = pd.to_numeric(df['colesterolo_siero'], errors='coerce')
df = df[df['colesterolo_siero'] <= 300]

conteggio_colesterolo = df['colesterolo_siero'].value_counts().sort_index()

plt.bar(conteggio_colesterolo.index, conteggio_colesterolo.values)
plt.xlabel('Colesterolo Sierico (mg/dl)')
plt.ylabel('Numero di Utenti')
plt.title('Distribuzione del Colesterolo Sierico')

plt.savefig(os.path.join('./graph', 'grafico_colesterolo.png'))
plt.close()


df = df.rename(columns={'fbs': 'zucchero_sangue_a_digiuno'})
df = df[df['zucchero_sangue_a_digiuno'].isin([0, 1])]
df['zucchero_sangue_a_digiuno'] = df['zucchero_sangue_a_digiuno'].astype(int)
conteggio_zucchero = df['zucchero_sangue_a_digiuno'].value_counts()

labels = ['Non digiuno (> 120 mg/dl)', 'Digiuno (≤ 120 mg/dl)']

plt.pie(conteggio_zucchero, labels=labels, autopct='%1.1f%%')
plt.title('Distribuzione dello Zucchero nel Sangue a Digiuno')

annotation_text = '1 = Zucchero > 120 mg/dl\n0 = Zucchero ≤ 120 mg/dl'
plt.annotate(annotation_text, xy=(0.5, 0.5), xycoords='axes fraction',
             fontsize=12, ha='center')

plt.savefig(os.path.join('./graph', 'grafico_zucchero_sangue.png'))
plt.close()

df =df.rename(columns={'restecg': 'risultati_ECG_riposo'})

unique_values = df["risultati_ECG_riposo"].unique()

value_counts = df["risultati_ECG_riposo"].value_counts()
plt.bar(value_counts.index, value_counts.values)
plt.xticks(value_counts.index, ['Normale', 'Anomalia ST-T', 'Ipertrofia ventricolare sinistra'])

plt.xlabel("")
plt.ylabel("Conteggio")
plt.title("Distribuzione dei risultati ECG a riposo")
plt.savefig(os.path.join('./graph', 'grafico_ECG_riposo.png'))
plt.close()

df = df.rename(columns={"thalach": "tasso_cardiaco_massimo_raggiunto"})

value_counts = df["tasso_cardiaco_massimo_raggiunto"].value_counts()
'''
plt.bar(value_counts.index, value_counts.values)
plt.xlabel("Valori")
plt.ylabel("Conteggio")
plt.title("Distribuzione del tasso cardiaco massimo raggiunto")
'''
# viste le analisi fatte ora andiamo ad usare la tecnica della rimozione degli outlier!

Q1 = df["tasso_cardiaco_massimo_raggiunto"].quantile(0.25)
Q3 = df["tasso_cardiaco_massimo_raggiunto"].quantile(0.75)
IQR = Q3 - Q1


lower_bound = Q1 - 1.5 * IQR
upper_bound = Q3 + 1.5 * IQR
filtered_df = df[(df["tasso_cardiaco_massimo_raggiunto"] >= lower_bound) &
                  (df["tasso_cardiaco_massimo_raggiunto"] <= upper_bound)]

value_counts = filtered_df["tasso_cardiaco_massimo_raggiunto"].value_counts()


plt.bar(value_counts.index, value_counts.values)

plt.xlabel("Valori")
plt.ylabel("Conteggio")
plt.title("Distribuzione del tasso cardiaco massimo raggiunto (senza outlier)")

plt.savefig(os.path.join('./graph', 'grafico_tasso_cardiaco_massimo_raggiunto.png'))
plt.close()


df = df.rename(columns={"exang": "angina_indotta"})

value_counts = df["angina_indotta"].value_counts()
plt.bar(["No", "Sì"], value_counts)

plt.xlabel("Valori")
plt.ylabel("Conteggio")
plt.title("Distribuzione dell'angina indotta dall'esercizio")
plt.savefig(os.path.join('./graph', 'grafico_angina_indotta.png'))
plt.close()


df = df.rename(columns={"oldpeak": "depressione_ST"})
sns.kdeplot(df["depressione_ST"])

plt.xlabel("ST Depression")
plt.ylabel("Densità")
plt.title("Distribuzione della depressione ST indotta dall'esercizio")
plt.savefig(os.path.join('./graph', 'grafico_depressione_ST.png'))
plt.close()