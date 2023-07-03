import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt
import os 

df = pd.read_csv('./data/new_heart.csv')

# ora che i dati sono stati corretti, andiamo ad applicare qualche algoritmo di classificazione

# 1: RANDOM FOREST

from sklearn.ensemble import RandomForestClassifier
from sklearn.model_selection import train_test_split
from sklearn.metrics import accuracy_score
from sklearn.metrics import confusion_matrix


X = df.drop("target", axis=1)
y = df["target"]

X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

rf = RandomForestClassifier()

# Addestra il modello sulla porzione di training set
rf.fit(X_train, y_train)

# Esegui le previsioni sul test set
predictions = rf.predict(X_test)

# Calcola l'accuratezza del modello
accuracy = accuracy_score(y_test, predictions)
print("Accuracy:", accuracy)


cm = confusion_matrix(y_test, predictions)

# Crea un grafico della matrice di confusione
plt.figure(figsize=(8, 6))
sns.heatmap(cm, annot=True, cmap="Blues", fmt="d", xticklabels=["No malattia", "Malattia"], yticklabels=["No malattia", "Malattia"])
plt.xlabel("Previsto")
plt.ylabel("Effettivo")
plt.title("Matrice di Confusione")
plt.savefig(os.path.join('./graph/grafici_ML', 'grafico_matrice_confuzione.png'))
plt.close()

