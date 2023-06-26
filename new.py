import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.ensemble import RandomForestClassifier
from sklearn.metrics import accuracy_score

# Importa il dataset
df = pd.read_csv('./data/heart.csv')

# Rimuovi i valori mancanti (NA)
df = df.dropna()

# Elimina la colonna "x"
df = df.drop('x', axis=1)

# Controlla il formato dei dati
colonne_numeriche = ['age', 'trestbps', 'chol', 'thalach', 'oldpeak']
colonne_stringa = ['sex', 'cp', 'fbs', 'restecg', 'exang', 'slope', 'ca', 'thal']

for colonna in colonne_numeriche:
    df[colonna] = pd.to_numeric(df[colonna], errors='coerce')

for colonna in colonne_stringa:
    df[colonna] = df[colonna].astype(str)

# Stampa il DataFrame aggiornato
print(df.head())

features = ['age', 'sex', 'cp', 'trestbps', 'chol', 'fbs', 'restecg', 'thalach', 'exang', 'oldpeak', 'slope', 'ca', 'thal']
target = 'target'

X = df[features]
y = df[target]
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

# Crea un modello di classificazione (ad esempio, Random Forest)
model = RandomForestClassifier()

# Addestra il modello
model.fit(X_train, y_train)

# Esegui previsioni sul set di test
y_pred = model.predict(X_test)

# Calcola l'accuratezza del modello
accuracy = accuracy_score(y_test, y_pred)
print("Accuratezza del modello: {:.2f}%".format(accuracy * 100))

# Effettua previsioni sui dati personali
personal_data = {'age': 45, 'sex': 1, 'cp': 2, 'trestbps': 130, 'chol': 220, 'fbs': 0, 'restecg': 1, 'thalach': 180, 'exang': 0, 'oldpeak': 1.5, 'slope': 2, 'ca': 0, 'thal': 2}
personal_df = pd.DataFrame([personal_data])
prediction = model.predict(personal_df)

if prediction[0] == 1:
    print("Hai una probabilità maggiore di avere un attacco di cuore.")
else:
    print("Hai una probabilità minore di avere un attacco di cuore.")
