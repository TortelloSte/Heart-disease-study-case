### Esame R
### Stefano Perdicchia, Parma Samuele, Tosi Marco

# install.packages("kableExtra")
# ho aggiunto la libreria kableExtra per usare kable e kable_styling
library(tidyverse) # ho aggiunto la libreria tidyverse cosi puoi usare la funzione %>% che serve per concatenare più valori in una sola funzione
library(kableExtra)

# carico il dataset heart.csv (consegnato per svolgere l'esame), controllo che la directory sia impostata correttamente! (se no non carica il file .csv)
heart_disease_dataset <- read.csv(file = "Heart.csv", header = TRUE, stringsAsFactors = FALSE)
# procedo con l'analisi della struttura del dataset appena importato.
str(heart_disease_dataset)
dim(heart_disease_dataset)
summary(heart_disease_dataset)
# troviamo la prima analisi del Dataset fornito nel report, in breve possiamo notare come:
# siano presenti le 15 colonne, e 303 righe di dati.
# possiamo affermare con certezza che questo Dataset riguardi e prenda in considerazione i dati di persone probabilmente malate a livello cardiaco.
# infine possiamo notare come analizzando in primo luogo la struttura ci siano dati che hanno bisogno di essere sistemati (ora procederemo nella fase di Data cleaning)
# infatti osservando il summary() notiamo come nelle colonne -cp e -fbs siano presenti dei valori NA's quindi da sistemare, e che inoltre le colonne sex e chol (che dovrebbero essere di origine numerica), sono invece colonne con class: char, un'altro dato da sistemare capendone il problema

# Dopo aver fatto una prima analisi dei dati, ho notato che ci sono diversi dati inconsistenti, in primo luogo richiamando alla struttura appunto possiamo notare come:
# la colonna Sex e la colonna Chol siano segnate come chr, il che non va bene, quindi andiamo a sistemare i dati per poterli trasformare in numerici
# inizio con la rimozione dei valori errati
heart_disease_dataset$sex[heart_disease_dataset$sex == "unspecified"] <- NA
heart_disease_dataset$chol[heart_disease_dataset$chol == "undefined"] <- NA
# ora vado a ricontrollare la struttura per vedere se abbiamo sistemato il problema qundi richiamo la funzione str()
str(heart_disease_dataset)
# possiamo notare come non sia cambiata la classe, allora andiamo a controllare se i dati sono stati stistemati all'interno del dataset
View(heart_disease_dataset)
# controllando le due colonne si può notare come i dati siano stati sistemati quindi procendo con il cambio di classe in modo manuale
heart_disease_dataset$sex <- as.numeric(heart_disease_dataset$sex)
heart_disease_dataset$chol <- as.numeric(heart_disease_dataset$chol)
# dopo aver effettuato questa operazione andiamo a controllare la struttura del dataaset heart.csv cosi da poter vedere se le classi sono cambiate
str(heart_disease_dataset)
# adesso possiamo notare come le variabili siano state sistemate, procediamo con l'esame.

# dopo aver sistemato i dati andiamo a modificare il nome delle colonne presenti, cosi che ad uno sguardo meno attento si riesca a capire per che cosa stanno i dati inseriti
# prima di tutto inseriamo in un vettore i nomi delle colonne:
names <- c(
  "Number",
  "Age",
  "Sex",
  "Chest_Pain_Type",
  "Resting_Blood_Pressure",
  "Serum_Cholesterol",
  "Fasting_Blood_Sugar",
  "Resting_ECG",
  "Max_Heart_Rate_Achieved",
  "Exercise_Induced_Angina",
  "ST_Depression_Exercise",
  "Peak_Exercise_ST_Segment",
  "Num_Major_Vessels_Flouro",
  "Thalassemia",
  "Diagnosis_Heart_Disease"
)
# abbiamo cosi creato il vettore contenente i nomi delle colonne che ora dobbiamo attribuire al dataset di esame
# per trasformare i nomi delle colonne, dopo aver creato il vettore andiamo ad applicarlo ed imporlo al dataset cosi facendo:
colnames(heart_disease_dataset) <- names
# possiamo notare come ora il nostro dataset abbia modificato i nomi delle colonne, infatti:
# controllo visivamente inoltre che le colonne abbiano acquisito il nome corretto
summary(heart_disease_dataset)
# per svolgere questo controllo possiamo inoltre utilizzare la funzione glimpse applicata al dataset che abbiamo trasformato per fare un controllo di quelli che sono i nuovi nomi, infatti:
heart_disease_dataset %>% glimpse()
# come ci aspettavamo il nostro dataset ha acquisito i nuovi nomi per le 15 colonne, infatti grazie all'utilizzo della funzione abbiamo notato come:
# indichi che rimangono ancora 303 rige da sistemare e 15 colonne con i dati inseriti all'interno, e che non siano presenti colonne nulle!

# andando avanti con l'analisi della struttura notiamo che ci sono da sistemate i Livelli di alcune delle colonne, adesso per ogni colonna da sistemare indichiamo i livelli corretti. Questa modifica verrà notate nel riquadro in alto a destra se si apre la struttura del dataset

heart_dataset_clean_tbl <- heart_disease_dataset %>%
  mutate_at(c(
    "Resting_ECG",
    "Fasting_Blood_Sugar",
    "Sex",
    "Diagnosis_Heart_Disease",
    "Exercise_Induced_Angina",
    "Peak_Exercise_ST_Segment",
    "Chest_Pain_Type",
    "Thalassemia"
  ), as_factor) %>%
  mutate(Num_Major_Vessels_Flouro = as.numeric(Num_Major_Vessels_Flouro)) %>%
  select(
    Age,
    Resting_Blood_Pressure,
    Serum_Cholesterol,
    Max_Heart_Rate_Achieved,
    ST_Depression_Exercise,
    Num_Major_Vessels_Flouro,
    everything()
  )

heart_dataset_clean_tbl$Thalassemia[heart_dataset_clean_tbl$Thalassemia == "0"] <- NA
any(is.na(heart_dataset_clean_tbl))
heart_dataset_clean_tbl <- na.omit(heart_dataset_clean_tbl)
any(is.na(heart_dataset_clean_tbl))
# per fare questo passaggio inizialmente devo sistemare i dati inconsistenti!
# i livelli delle colonne vengono sitemati poco più avanti, che ora sto sistemando i dati del dataset fornito
# dopo questa funzione possiamo notare come i livelli delle quattro colonne siano stati sistemati, adesso possiamo andare avanti con l'esecuzione del programma, il punto successivo richiede di stilare una breve descrizione degli attributi presenti, questo si troverà appunto sul Report di esame.
# inoltre abbiamo gia eseguito la pulizia dei dati, rimuovendo i dati NA dal dataset stesso. cosi per andare avanti ed ottimizzare i tempi, ho concatenato la funzzione del drop na e dei livelli in una sola
# per scrupolo controlliamo:
any(is.na(heart_dataset_clean_tbl))
# avendo come esito alla domanda ad R TRUE, siamo contenti che i dati siano da sistemare e procediamo alla rimozione dei valori NA.
heart_dataset_clean_tbl <- na.omit(heart_dataset_clean_tbl)
# controllo quindi nuovamente se ci sono dei dati da rimuovere ulteriormente, o se il file risulta pulito
any(is.na(heart_dataset_clean_tbl))
# avendo ricevuto come esito dalla console il valore FALSE, siamo ora sicuri che il dataset è stato pulito completamente dai valori NA!
# per fare uno studio maggiormente approfondito sui dati decido personalmente di concatenare piu funzioni in maniera tale da ottenere come risultato
# i dati a tabella delle colonne Diagnosi di un problema cardiaco, e i dati sulla thalassemia.
heart_dataset_clean_tbl %>%
  group_by(Diagnosis_Heart_Disease) %>%
  count() %>%
  ungroup() %>%
  kable(align = rep("c", 2)) %>%
  kable_styling("full_width" = F)
heart_dataset_clean_tbl %>%
  group_by(Thalassemia) %>%
  count() %>%
  ungroup() %>%
  kable(align = rep("c", 2)) %>%
  kable_styling("full_width" = F)
# facendo questa analisi possiamo notare che:
# i valori della colonna Diagnosis_heart_disease sono corretti e completi, in quanto la somma dei dati di pazienti malati e non malati corrisponde al numero totale di colonne presenti nel dataset
# al contrario notiamo come ci siano nella colonna thalassemia due valori che corrispondono allo 0, e che sono valori nulli. da ricordare per i punti successivi cosi da sistemare i dati in maniera corretta.
# adesso per sistemare i dati procedo con la rimozione della colonna number (che è un semplice ordinamento dei dati dal primo all'ultimo e che risulta inutile ai fini dello studio)
heart_dataset_clean_tbl <- heart_dataset_clean_tbl %>% select(-Number)
# possiamo notare ora richiamando la struttura del dataset che la colonna è stata rimossa con successo, e che ora possiamo procedere con la trasformazione dei dati in dati consistenti
str(heart_dataset_clean_tbl)
attributes(heart_dataset_clean_tbl)
# attraverso la funzione attributes() vado a fare un controllo finale di questa prima parte di esame per controllare che i dati siano stati tutti sistemati. infatti risultano i nomi delle colonne corretti, il fatto che il mio dataset sia effettivamente un dataframe come classe e che ci sono esattaemnte 293 righe come dovrebbe essere.
# inoltre ci viene detto quali delle righe avevano dei valori NA e con quale attributo sono stati rimossi, ossia la funzione omit dei valori NA o nulli.

# A questo punto dello studio devo occuparmi della trasformazione dei dati, quindi per fare un lavoro fatto bene andrò a controllare colonna per colonna i dati cosi da rendere i dati il piu corretti possibili e andando a graficare tutto sia prima che dopo.
# facendo queste trasformazioni avrò alla fine un dataset con tutti i dati consistenti, vuol dire un dataset che abbia all'interno i dati migliori per poter effettuare in un futuro delle previsioni, ma procediamo per gradi:
# prima di procedere però inizio con un grafico che vada a rappresentare tutti i dati presenti, in questo modo:
# inizialmente richiamo il dataset in una maniera più comoda e ci lavoro all'interno richiamando i dati che in precedenza avevamo posto come fattori:
hd_long_fact_tbl <- heart_dataset_clean_tbl %>%
  select(
    Sex,
    Chest_Pain_Type,
    Fasting_Blood_Sugar,
    Resting_ECG,
    Exercise_Induced_Angina,
    Peak_Exercise_ST_Segment,
    Thalassemia,
    Diagnosis_Heart_Disease
  ) %>%
  mutate(
    Sex = recode_factor(Sex,
      `0` = "female",
      `1` = "male"
    ),
    Chest_Pain_Type = recode_factor(Chest_Pain_Type,
      `0` = "typical",
      `1` = "atypical",
      `2` = "non-angina",
      `3` = "asymptomatic"
    ),
    Fasting_Blood_Sugar = recode_factor(Fasting_Blood_Sugar,
      `0` = "<= 120 mg/dl",
      `1` = "> 120 mg/dl"
    ),
    Resting_ECG = recode_factor(Resting_ECG,
      `0` = "normal",
      `1` = "ST-T abnormality",
      `2` = "LV hypertrophy"
    ),
    Exercise_Induced_Angina = recode_factor(Exercise_Induced_Angina,
      `0` = "no",
      `1` = "yes"
    ),
    Peak_Exercise_ST_Segment = recode_factor(Peak_Exercise_ST_Segment,
      `0` = "up-sloaping",
      `1` = "flat",
      `2` = "down-sloaping"
    ),
    Thalassemia = recode_factor(Thalassemia,
      `1` = "normal",
      `2` = "fixed defect",
      `3` = "reversible defect"
    )
  ) %>%
  gather(key = "key", value = "value", -Diagnosis_Heart_Disease)
# visualizzo i dati tramite il barplot
hd_long_fact_tbl %>%
  ggplot(aes(value)) +
  geom_bar(aes(
    x = value,
    fill = Diagnosis_Heart_Disease
  ),
  alpha    = .6,
  position = "dodge",
  color    = "pink",
  width    = .8
  ) +
  labs(
    x = "",
    y = "",
    title = "Variabili in Fattori"
  ) +
  theme(
    axis.text.y  = element_blank(),
    axis.ticks.y = element_blank()
  ) +
  facet_wrap(~key, scales = "free", nrow = 4) +
  scale_fill_manual(
    values = c("#fde725ff", "#20a486ff"),
    name   = "Heart\nDisease",
    labels = c("No HeartD", "Yes HeartD")
  )
# come nella prima parte, anche per tutte le variabili numeriche andiamo a creare il plot che vada a rappresentare i dati su cui poi andremo a lavorare
hd_long_cont_tbl <- heart_dataset_clean_tbl %>%
  select(
    Age,
    Resting_Blood_Pressure,
    Serum_Cholesterol,
    Max_Heart_Rate_Achieved,
    ST_Depression_Exercise,
    Num_Major_Vessels_Flouro,
    Diagnosis_Heart_Disease
  ) %>%
  gather(
    key = "key",
    value = "value",
    -Diagnosis_Heart_Disease
  )
# sviluppo il boxplot di tutte le variabili numeriche cosi che gli outlier siano piu facilemnte riconoscibili e che i dati possano essere sistamati in maniera più comoda
hd_long_cont_tbl %>%
  ggplot(aes(y = value)) +
  geom_boxplot(aes(fill = Diagnosis_Heart_Disease),
    alpha = .6,
    color = "pink",
    fatten = .7
  ) +
  labs(
    x = "",
    y = "",
    title = "Variabili numeriche"
  ) +
  scale_fill_manual(
    values = c("#fde725ff", "#20a486ff"),
    name   = "Heart\nDisease",
    labels = c("No HeartD", "Yes HeartD")
  ) +
  theme(
    axis.text.x  = element_blank(),
    axis.ticks.x = element_blank()
  ) +
  facet_wrap(~key,
    scales = "free",
    ncol   = 2
  )
# ora che i dati sono stati ben graficati procedo con il rendere consistenti i dati.
# procediamo con la prima colonna del dataset, ossia quella che fa riferimento all'eta del paziente
# possiamo notare come ci siano dei dati infeririori a 0, iniziamo con il grafico dei dati in maniera attuale:
hist(heart_dataset_clean_tbl$Age)
# grazie a questo istogramma possiamo notare che i dati, come detto in precedenza sono da sistemare, quindi procediamo:
heart_dataset_clean_tbl <- subset(heart_dataset_clean_tbl, Age > 0)
hist(heart_dataset_clean_tbl$Age)
# adesso i dati di questa colonna sono stati sistemati, procediamo con la colonna successiva, ossia quella che fa riferimento al Resting_blood_pressure
hist(heart_dataset_clean_tbl$Resting_Blood_Pressure)
# possiamo notare che i dati sono ben distribuiti, per renderli ancora più precisi direi di assumere che il dato minimo deve essere pari a 70, i valori inferirio assumeranno la media dei valori complessivi della colonna
sum(heart_dataset_clean_tbl$Resting_Blood_Pressure < 70)
heart_dataset_clean_tbl$Resting_Blood_Pressure[heart_dataset_clean_tbl$Resting_Blood_Pressure < 70] <- mean(heart_dataset_clean_tbl$Resting_Blood_Pressure)
hist(heart_dataset_clean_tbl$Resting_Blood_Pressure)
# adesso possiamo notare come i dati siano stati sistemati e che dalla console risultava un solo valore inferiore a 70, che abbiamo prontamente sistemato
# adesso procediamo con la terza colonna, ossia quella che fa riferimento al Serum_cholesterol, andiamo a graficarlo e ad analizzare i dati
hist(heart_dataset_clean_tbl$Serum_Cholesterol)
# anche in questo caso possiamo notare come i dati siano ben distribuiti tranne i dati che si trovano sopra la fascia dei 500, quindi anche qui interveniamo in maniera analoga alla precedente
sum(heart_dataset_clean_tbl$Serum_Cholesterol > 500)
heart_dataset_clean_tbl$Serum_Cholesterol[heart_dataset_clean_tbl$Serum_Cholesterol > 500] <- mean(heart_dataset_clean_tbl$Serum_Cholesterol)
hist(heart_dataset_clean_tbl$Serum_Cholesterol)
# come prima sulla console risulta un solo dato da sistemare e in maniera analoga a quella precedente abbiamo sistmato i dati, rendendo consistenti, procediamo con la quarta colonna
# all'interno della quarta colonna notiamo esserti i dati relativi al Max_Heart_rate_achived, che come da consegna ci viene detti di non prendere i dati superiori a 222, e di procedere in maniera analoghe alle precedenti, cosi procediamo in questo modo:
hist(heart_dataset_clean_tbl$Max_Heart_Rate_Achieved)
sum(heart_dataset_clean_tbl$Max_Heart_Rate_Achieved > 222)
heart_dataset_clean_tbl$Max_Heart_Rate_Achieved[heart_dataset_clean_tbl$Max_Heart_Rate_Achieved > 222] <- mean(heart_dataset_clean_tbl$Max_Heart_Rate_Achieved)
hist(heart_dataset_clean_tbl$Max_Heart_Rate_Achieved)
# possiamo notare come da console indichi che ci sono tre dati da sistemare, e in modo analogo ai precedenti vengno sistemati e possiamo notare la differenza dei grafici, con i dati che sono risultati sistemati! Adesso procediamo con l'analisi della prossima colonna
# la prossima colonna che prendiamo in esame è quella relativa al ST Depression Induced by Exercise Relative to Rest: ST Depression of subject.
hist(heart_dataset_clean_tbl$ST_Depression_Exercise)
sum(heart_dataset_clean_tbl$ST_Depression_Exercise > 5)
heart_dataset_clean_tbl$ST_Depression_Exercise[heart_dataset_clean_tbl$ST_Depression_Exercise > 5] <- mean(heart_dataset_clean_tbl$ST_Depression_Exercise)
hist(heart_dataset_clean_tbl$ST_Depression_Exercise)
# abbiamo notato che i dati sono stati sistemati, e cerano solamente due dati anche in questo caso che sono stati sistamti! Inoltre si noti che molti dati siano uguali a 0.0, pero puossiamo dedurre essere un valore atteso, quindi che non necessita di ulteriori modifiche, procedo con la colonna successiva
hist(heart_dataset_clean_tbl$Num_Major_Vessels_Flouro)
# questa tabella in realta si riporta a dei valori specifici, ossia che ad ogni numero corrisponde un dato medico. come dai dati che incontreremo  da qui in avanti, quindi i grafici servono solamente per andare a vedere qunati valori sono presenti all'interno del datset in quando valori che hanno una classe definita factor
# per correttezza e completezza andro a fare il grafico di tutte le tabelle che ne riguardano:
# visualizzo i dati tramite il barplot
heart1 <- heart_dataset_clean_tbl %>%
  select(
    Sex,
    Chest_Pain_Type,
    Fasting_Blood_Sugar,
    Resting_ECG,
    Exercise_Induced_Angina,
    Peak_Exercise_ST_Segment,
    Thalassemia,
    Diagnosis_Heart_Disease
  ) %>%
  mutate(
    Sex = recode_factor(Sex,
      `0` = "female",
      `1` = "male"
    ),
    Chest_Pain_Type = recode_factor(Chest_Pain_Type,
      `0` = "typical",
      `1` = "atypical",
      `2` = "non-angina",
      `3` = "asymptomatic"
    ),
    Fasting_Blood_Sugar = recode_factor(Fasting_Blood_Sugar,
      `0` = "<= 120 mg/dl",
      `1` = "> 120 mg/dl"
    ),
    Resting_ECG = recode_factor(Resting_ECG,
      `0` = "normal",
      `1` = "ST-T abnormality",
      `2` = "LV hypertrophy"
    ),
    Exercise_Induced_Angina = recode_factor(Exercise_Induced_Angina,
      `0` = "no",
      `1` = "yes"
    ),
    Peak_Exercise_ST_Segment = recode_factor(Peak_Exercise_ST_Segment,
      `0` = "up-sloaping",
      `1` = "flat",
      `2` = "down-sloaping"
    ),
    Thalassemia = recode_factor(Thalassemia,
      `1` = "normal",
      `2` = "fixed defect",
      `3` = "reversible defect"
    )
  ) %>%
  gather(key = "key", value = "value", -Diagnosis_Heart_Disease)
heart1 %>%
  ggplot(aes(value)) +
  geom_bar(aes(
    x = value,
    fill = Diagnosis_Heart_Disease
  ),
  alpha    = .6,
  position = "dodge",
  color    = "pink",
  width    = .8
  ) +
  labs(
    x = "",
    y = "",
    title = "Variabili in Fattori"
  ) +
  theme(
    axis.text.y  = element_blank(),
    axis.ticks.y = element_blank()
  ) +
  facet_wrap(~key, scales = "free", nrow = 4) +
  scale_fill_manual(
    values = c("#fde725ff", "#20a486ff"),
    name   = "Heart\nDisease",
    labels = c("No HeartD", "Yes HeartD")
  )
# inoltre per una completezza dei grafici inserisco anche un boxplot con i dati relativi ai grafici soprastanti, in maniera tale da controllare se i dati sono stati sistemati:
heart2 <- heart_dataset_clean_tbl %>%
  select(
    Age,
    Resting_Blood_Pressure,
    Serum_Cholesterol,
    Max_Heart_Rate_Achieved,
    ST_Depression_Exercise,
    Num_Major_Vessels_Flouro,
    Diagnosis_Heart_Disease
  ) %>%
  gather(
    key = "key",
    value = "value",
    -Diagnosis_Heart_Disease
  )
heart2 %>%
  ggplot(aes(y = value)) +
  geom_boxplot(aes(fill = Diagnosis_Heart_Disease),
    alpha = .6,
    color = "pink",
    fatten = .7
  ) +
  labs(
    x = "",
    y = "",
    title = "Variabili numeriche"
  ) +
  scale_fill_manual(
    values = c("#fde725ff", "#20a486ff"),
    name   = "Heart\nDisease",
    labels = c("No HeartD", "Yes HeartD")
  ) +
  theme(
    axis.text.x  = element_blank(),
    axis.ticks.x = element_blank()
  ) +
  facet_wrap(~key,
    scales = "free",
    ncol   = 2
  )
# possiamo quindi notare come i dati siano sistemati, sono presenti per ora degli outlier in quanto i quantili venfono ricalcolati, ora procediamo anche alla sistemazione dei grafici che riguardano i quantili invece.
# all'interno della tracci di esame viene constatato che: devo assumere come outlier i dati relativi alla pressione sanguigna, quindi alla: Restin blood pressure, i valori presenti a riposo (appunto resting), che non rispettano la 1.5xIQR Rule vanno sistemati e quindi rimossi, adesso procediamo con questa analisi
# inizialmente ricerco all'interno del sommario i dati che mi interessano
summary(heart_dataset_clean_tbl)
# inserisco il promo boxplot con i dati relativi alla pressione sanguigna a riposo
boxplot(heart_dataset_clean_tbl$Resting_Blood_Pressure)
# da un aprima analisi del grafico possiamo notare come ci siano diversi dati che non corrispondono alla nostra regola che dobbiamo rispettare, quindi procediamo con l'eliminazione di questi dati:
# prima di tutto sistemiamo il terzo quantile
q3 <- quantile(heart_dataset_clean_tbl$Resting_Blood_Pressure, .75)
# in secondo luogo ci troviamo a sistemare quello che è il primo quantile quindi
q1 <- quantile(heart_dataset_clean_tbl$Resting_Blood_Pressure, .25)
# facciamo la differenza interquantile che sara proprio il nostro IQR e che andremo poi a sfruttare per farne i calcoli
iqr <- (q3 - q1)
# andiamo a dare un valore minimo e massimo in questo modo, richiamado i quantili q1 e q3 e poi andiamo a moltiplicarli con iqr
minimo <- (q1 - (1.5 * iqr))
# massimo:
massimo <- (q3 + (1.5 * iqr))
# adesso prima di procedere vado a contare quanti valori non consistenti sono presenti prima di proseguire con l aloro eliminazione
sum(heart_dataset_clean_tbl$Resting_Blood_Pressure < minimo | heart_dataset_clean_tbl$Resting_Blood_Pressure > massimo)
# rimuovo gli oultier grazie ad un filtro
heart104 <- heart_dataset_clean_tbl[heart_dataset_clean_tbl$Resting_Blood_Pressure > minimo & heart_dataset_clean_tbl$Resting_Blood_Pressure < massimo, ]
# display the boxplot
boxplot(heart104$Resting_Blood_Pressure)
# adesso possiamo controllare se all'inteerno del dataset i dati siano consistenti
summary(heart104)
# in poche parole cosa abbiamo analizzato? possiamo notare come erano presenti 7 dati che erano sopra la linea, e rimanevano esclusi come outlier
# quello che abbiamo fatto è il procedimento di base per la creazione di un nuovo dataset che abbia i dati di questa colonna consistenti, infatti nel nuovo boxplot che ne figura ci sono i dati che sono corretti!
# per andare avanti a fare la nostra analisi andremo a vedere quali altri dati hanno bisogno di essere sistemati sempre mediante la stessa regola:
summary(heart104)
# possiamo analizzare allo stesso modo la colonna relativa al colesterolo, andiamo a graficare il boxplot e vedere se è necessaria qualche trasformazione
boxplot(heart104$Serum_Cholesterol)
# anche in questo caso si può notare come ci siano dei valori outlier, quindi procediamo con la correzione dei dati come fatto in precedenza e rinominiamo il dataset in maniera ottimale
# sistemiamo il terzo quartile come fatto in precedenzza
q3 <- quantile(heart104$Serum_Cholesterol, .75)
# e anche il primo quantile
q1 <- quantile(heart104$Serum_Cholesterol, .25)
# andiamo a calcolare la differenza interqantile
iqr <- (q3 - q1)
# troviamo il valore minimo
minimum <- (q1 - (1.5 * iqr))
# e anche il valore massimo
maximum <- (q3 + (1.5 * iqr))
# andiamo a vedere quanti sono i dati che sono da sistemare
sum(heart104$Serum_Cholesterol < minimum | heart104$Serum_Cholesterol > maximum)
# possiamo vedere come in questo caso i dati che sono da eliminare sono: 4
# rora mi accingo a rimovere i dati inconsistenti attraverso un filtro, e andando a rinominare il dataset
newheart <- heart104[heart104$Serum_Cholesterol > minimum & heart104$Serum_Cholesterol < maximum, ]
# andiamo ora a mostrare il boxplot con i dati che ci aspettiamo essersi sistemati
boxplot(newheart$Serum_Cholesterol)
# possiamo notare che i dati esterni sono stati eliminati, infatti il grafico è stato sistemato a dovere
# andiamo ora a controllare che anche in questo caso i dati risultino consistenti
summary(newheart)
# infine come ultimo dato che andiamo ad analizzare per sistemare i quantili è la colonna relativa al Max_Heart_Rate_Achived
# quindi come nei casi precedenti andiamo a sistemare i dati fino a creare un nuovo dataset che comprenda tutti i dati, e i dati che da ora in poi saranno corretti e consistenti.
boxplot(newheart$Max_Heart_Rate_Achieved)
# da qui possiamo notare che rispetto ai grafici precedenti ci sono meno dati in outline, andiamo a sistemare e preparare i dati:
q3 <- quantile(newheart$Max_Heart_Rate_Achieved, .75)
q1 <- quantile(newheart$Max_Heart_Rate_Achieved, .25)
# calcoliamo la differenza interquantile
iqr <- (q3 - q1)
minimum <- (q1 - (1.5 * iqr))
maximum <- (q3 + (1.5 * iqr))
# conto quante osservazioni sono presenti che vanno sistemate per rendere i dati consistenti.
sum(newheart$Max_Heart_Rate_Achieved < minimum | newheart$Max_Heart_Rate_Achieved > maximum)
# possiamo notare come ci aspettvamo che in questo caso solo un dato è da sistemare, dato che all'interno della console ci viene riferito che il dao da sistemare è unico
# rimuoviamo attraverso un filtro e ricreiamo il dataset
Heart_Disease <- newheart[newheart$Max_Heart_Rate_Achieved > minimum & newheart$Max_Heart_Rate_Achieved < maximum, ]
# ora andiamo a rivedere il boxplot per vedere se il dato è stato correttamente sistemato
boxplot(Heart_Disease$Max_Heart_Rate_Achieved)
# Possiamo vedere come ora tutti i dati siano stati sistemati e possiamo procedere con la traccia di esame, ma prima di andare avanti ricontrolliamo il summary per vedere se ora i dati siano corretti e consistenti
summary(Heart_Disease)
# da or in poi il nostro dataset di riferimento si chiamera Heart_Disease,e tutti i dati al suo interno sono sistemati, tecnicamente corretti e consistenti
# grafici per fare la analisi descrittiva
library(ggplot2)
PieChest <- ggplot(Heart_Disease, aes(x = "", fill = Chest_Pain_Type)) +
  geom_bar() +
  theme(axis.text.x = element_text(vjust = 0.6)) +
  coord_polar(theta = "y", start = 0) +
  labs(
    title = "",
    y = "",
    x = ""
  )
print(PieChest)
# chest e diagnosi
bar_dolore <- ggplot(Heart_Disease, aes(Chest_Pain_Type)) +
  geom_bar(position = "dodge", aes(fill = Diagnosis_Heart_Disease), width = 0.5) +
  theme(axis.text.x = element_text(angle = 65, vjust = 0.6)) +
  labs(
    title = "",
    y = "Frequenza"
  )
print(bar_dolore)
# sesso e diagnosi
bar_sesso <- ggplot(Heart_Disease, aes(Sex)) +
  geom_bar(position = "dodge", aes(fill = Diagnosis_Heart_Disease), width = 0.5) +
  theme(axis.text.x = element_text(angle = 65, vjust = 0.6)) +
  labs(
    title = "",
    y = "Frequenza"
  )
print(bar_sesso)

# Analizzo la relazione tra l'eta' e l'avere una malattia cardiaca
bar_eta <- ggplot(Heart_Disease, aes(Age)) +
  geom_bar(aes(fill = Diagnosis_Heart_Disease), width = 0.5) +
  theme(axis.text.x = element_text(angle = 65, vjust = 0.6)) +
  labs(
    title = "",
    x = "eta",
    y = "Frequenza",
  )
print(bar_eta)

plot_etaxpressione <- ggplot(Heart_Disease, aes(x=Age, y=Resting_Blood_Pressure, shape=Sex, color=Sex)) +
  geom_point() +
  labs(
    title = "",
    subtitle = "",
    x = "Eta'",
    y = "Pressione sanguigna a riposo",
    caption = ""
  )
print(plot_etaxpressione)

## Analizzo la relazione tra la pendenza del segmento ST, la frequenza cardiaca massima e l'avere una malattia cardiaca:
boxplot_pendenzaxfreqcard <- ggplot(Heart_Disease, aes(x = Peak_Exercise_ST_Segment, y = Max_Heart_Rate_Achieved, fill = Diagnosis_Heart_Disease)) +
  geom_boxplot() +
  labs(
    title = "",
    subtitle = "",
    x = "Pendenza ST",
    y = "Frequenza cardiaca massima",
    caption = ""
  )
print(boxplot_pendenzaxfreqcard)

torta_talassemia <- ggplot(Heart_Disease, aes(x = "", fill = Thalassemia)) +
  geom_bar() +
  theme(axis.text.x = element_text(vjust = 0.6)) +
  coord_polar(theta = "y", start = 0) +
  labs(
    title = "",
    y = "",
    x = ""
  )
print(torta_talassemia)
bar_talassemia <- ggplot(Heart_Disease, aes(Thalassemia)) +
  geom_bar(position = "dodge", aes(fill = Diagnosis_Heart_Disease), width = 0.5) +
  theme(axis.text.x = element_text(angle = 65, vjust = 0.6)) +
  labs(
    title = "",
    y = "Frequenza"
  )
print(bar_talassemia)




library(tidyverse)
########à Analisi descrittiva
# il prossimo punto dell'esame è quello di condurre un analisi destriva completa ed approfondita riguardate i dati che abbiamo analizzato in precedenza
# successivamente quando saranno svolti tutti i punti successivi dell'esame andremo a fare una analisi anche sui dati successivi.
# per la parte di analisi desrittiva sarà tutto riportato nel report, qui mi limito ad inserire le tre funzioni per visualizzare i dati e che successivamente andro a riportare:
str(Heart_Disease)
dim(Heart_Disease)
summary(Heart_Disease)
# grazie a queste tre semplici fuzioni possiamo appunto stilare una analisi dei dati e fare le nostre prime considerazioni, invede per vedere i dati usiamo
view(Heart_Disease)
# cosi possiamo visivamente vedere il dataset stesso.
# inoltre posso fare uno studio più approfondito applicndo la libreria ggplot2 cosi da poter fare un miglior grafico
# utilizazndo il metodo di Kendall basato sul rango
library(ggplot2)
# e installo una estensione della libreria stessa cosi da avere un grafico con maggiore accuratezza dei dati:
library(GGally)
# install.packages("ggcorrplot")
# installo la libreria per poter inserire correttamente il grafico successivo
library(ggcorrplot)
# dopo aver installato la libreria posso procedere alla rappresentazione delle fuzioni numeriche presenti all'interno del dataset, e inanzitutto devo ricreare il dataset solamente con le variabili numeriche
Heart_Disease_1 <- Heart_Disease %>% select(
  Age,
  Resting_Blood_Pressure,
  Serum_Cholesterol,
  Max_Heart_Rate_Achieved,
  ST_Depression_Exercise,
  Num_Major_Vessels_Flouro
)
Heart_Disease_1 <- round(cor(Heart_Disease_1), 1)
ggcorrplot(Heart_Disease_1, lab = TRUE) +
  scale_fill_gradientn(colors = c("lightyellow", "yellow", "orange", "red", "red3")) +
  theme_classic() +
  theme(axis.text.x = element_text(
    angle = -30,
    vjust = 1,
    hjust = 0
  )) +
  theme(axis.text.y = element_text(
    angle = 50,
    vjust = 0,
    hjust = 1
  ))
# Questa matrice mostra tutte le relazioni presenti all'interno delle variabili numeriche!
# inserisco i grafici di correlazione
Heart_Disease %>% ggcorr(
  high = "#20a486ff",
  low = "#fde725ff",
  label = TRUE,
  hjust = .75,
  size = 3,
  label_size = 3,
  nbreaks = 5
) +
  labs(
    title = "Correlation Matrix",
    subtitle = "Pearson Method Using Pairwise Obervations"
  )
Heart_Disease %>% ggcorr(
  method = c("pairwise", "kendall"),
  high = "#20a486ff",
  low = "#fde725ff",
  label = TRUE,
  hjust = .75,
  size = 3,
  label_size = 3,
  nbreaks = 5
) +
  labs(
    title = "Correlation Matrix",
    subtitle = "Kendall Method Using Pairwise Observations"
  )
# possiamo notare come direttamente all'interno della console elimini le colonne che non sono numeriche e quindi droppa i dati in quanto non utili alla rappresentazione di questo tipo di grafico
# Ci sono differenze molto minori tra i risultati di Pearson e Kendall. Nessuna variabile sembra essere altamente correlata. Pertanto, sembra ragionevole rimanere con le 14 variabili originali mentre procediamo nella sezione di modellazione.

# Successivamente alla parte di analisi descrittiva svolta in maniera approfondita sullo studio dei dati sopra riportati
# possiamo andare a tracciare i prossimi punti dell'esame, possiamo quindi passare allo studio della regressione lineare dei dati presenti all'interno del dataset
# Ho deciso di condurre questa parte di studio prendendo i dati che riguardano: la age del paziente e i dati riguardati il livello di colesterolo
# quindi possiamo procedere allo studio della regressione lineare
# regressione lineare tra Age e Serum_Cholesterol
# è importante ai fini dei dati controllare che le unita di misura siano impostate correttamente
Age <- Heart_Disease$Age
Chol <- Heart_Disease$Serum_Cholesterol
# prima di procedere devo richiamare i dati che mi interessano
plot(Age, Chol,
  xlab =

    "Age (year)", ylab

  = "Cholesterol (mg/dl)"
)
# inverto l'ordine dei dati per fare la regressione lineare in maniera tale che esca un dato corretto
reg <- lm(Chol ~ Age)
# per disegnare la retta di regressione lineare
abline(reg, col = "red")
segments(Age, fitted(reg), Age, Chol,
  col = "blue", lty = 2
)
title(main = "Regr.lin tra Age e
Serum_Cholesterol")
# in questo modo abbiamo creato il grafico per condurre una analisi della regressione lineare, adesso infatti possiamo andare a controllare i dati che ci rimandano al grafico:
cor(Age, Chol)
# a quanto pare il modello non si adatta quasi per niente ai dati che abbiamo analizzato, infatti possiamo notare nella console che il dato che ci esce è pari a 0.16, e che quindi i dati non sono tra di loro connessi per varie ragioni, allora decidiamo di procedere facendo la regressione lineare tra altri due dati, sperando in un accordo maggiore
# allora procediamo con la regressione lineare tra Colesterolo e massimo battito cardiaco, per vedere se i due dati si influenzano tra di loro
chol1 <- Heart_Disease$Serum_Cholesterol
maxi1 <- Heart_Disease$Max_Heart_Rate_Achieved
# prima di procedere devo richiamare i dati che mi interessano
plot(chol1, maxi1,
  xlab =

    "Cholesterol (mg/dl)", ylab

  = "max_heart_rate"
)
# inverto l'ordine dei dati per fare la regressione lineare in maniera tale che esca un dato corretto
reg1 <- lm(maxi1 ~ chol1)
# per disegnare la retta di regressione lineare
abline(reg1, col = "red")
segments(chol1, fitted(reg1), chol1, maxi1,
  col = "blue", lty = 2
)
title(main = "Regr.lin tra colesterolo e
massimo battito cardiaco")
# in questo modo abbiamo creato il grafico per condurre una analisi della regressione lineare, adesso infatti possiamo andare a controllare i dati che ci rimandano al grafico:
cor(chol1, maxi1)
# addirittura in questo caso il valore che ci esce all'interno della console è un valore negativo, questo mi fa capire che i dati anche in questo caso non hanno un rapporto, quindi andiamo avanti fino a trovare i casi migliori.
# decido di prendere in esame in questo caso i dati che riguardano la pressione a riposo e l'eta del paziente
blood <- Heart_Disease$Resting_Blood_Pressure
eta <- Heart_Disease$Age
# prima di procedere devo richiamare i dati che mi interessano
plot(blood, eta,
  xlab =

    "pressione sanguigna (mmHg)", ylab

  = "age (year)"
)
# inverto l'ordine dei dati per fare la regressione lineare in maniera tale che esca un dato corretto
reg2 <- lm(eta ~ blood)
# per disegnare la retta di regressione lineare
abline(reg2, col = "red")
segments(blood, fitted(reg2), blood, eta,
  col = "blue", lty = 2
)
title(main = "Regr.lin tra pressione a riposo e
eta del paziente")
# in questo modo abbiamo creato il grafico per condurre una analisi della regressione lineare, adesso infatti possiamo andare a controllare i dati che ci rimandano al grafico:
cor(blood, eta)
# possiamo vedere come in questo caso i dati siano maggiormente in rapporto rispetot ai due tentativi precedenti, ma sono valori ancora troppo bassi, dato che non supera il 0.26, in mancanza di ulteriori dati che starebbero meglio all'interno della regressione lineare deciso di procedere con l'esame andando avanti e tenendo come dati
# il rapporto che intercorre tra l'eta del paziente e la sua pressione sanguigna a riposo
summary(reg2)
# ho chiesto in output i valori presenti all'interno della regressione lineare in maniera tale da poter visionare i dati
# infatti a noi interessano i dati che riguardano i residui e i coefficienti, in modo tale da poterli graficare
# ora procedo con i grafici dei residui infatti
plot(reg2$fitted, reg2$residuals,
  main = "Residui"
)
abline(0, 0)
# notiamo che il grafico cambia davvero poco, questo anche perchè i dati non sono effettivamente rapportabili!
# Infine, la distribuzione in quantili dei residui è confrontabile con quella di una normale
qqnorm(reg2$residuals)
qqline(reg2$residuals)
# svolta anche se con dati che non soddisfano le nostre aspettativo, ho concluso questa parte di esame, ora procedo con la creazione di un nuovo dataset che riesca a tenere all'interno nuovi dati
# introduco un grafico che metta in relazione i dati sulla pressione sanguigna e sul livello di colesterolo, in relazione al fatto che un paziente sia malato o meno
prova <- ggplot(Heart_Disease, aes(x = Serum_Cholesterol, y = Resting_Blood_Pressure)) +
  geom_point(aes(col = Diagnosis_Heart_Disease))
prova
# adesso provo a fare la regressione lineare mettendo in relazione questi due dati:
summary(Heart_Disease)
# inseriamo inanzi tutto un plot che vada a rapportare i dati che ho analizzato sopra, cosi da vedere quali dati sono maggiormente compatibili tra di loro prima di procedere alla regressione lineare
databox <- data.frame(Heart_Disease$Age, Heart_Disease$Resting_Blood_Pressure, Heart_Disease$Serum_Cholesterol, Heart_Disease$Max_Heart_Rate_Achieved)
boxplot(databox)
# andiamo infine a sviluppare lo scatterplot
# Scatterplot
gg1 <- ggplot(Heart_Disease, aes(x = Serum_Cholesterol, y = Resting_Blood_Pressure)) +
  geom_point(aes(col = Diagnosis_Heart_Disease, size = Peak_Exercise_ST_Segment)) +
  geom_smooth(method = "loess", se = F) +
  xlim(c(100, 430)) +
  ylim(c(75, 200)) +
  labs(
    subtitle = "Resting_Blood_Pressure Vs Serum_Cholesterol",
    y = "Resting_Blood_Pressure",
    x = "Serum_Cholesterol",
    title = "Scatterplot",
    bins = 30
  )
plot(gg1)
# dopo aver osservato questi dati andiamo a controllare e quindi a fare ulteriori prove per poter predirre quali pazienti possono avere un attacco cardiaco
# baseline model
table(Heart_Disease$Diagnosis_Heart_Disease)
# andiamo a dividere i valori con 1(155) con il numero totale di pazienti all'interno del dataset, cosi da vedere la percentuale di pazienti che soffrono di un attacco cardiaco
155 / 271
# in questo caso abbiamo che il 57% dei pazienti presenti soffre di problemi cardiaci
# quindi procedo al nuovo studio della regressione lineare data
blood2 <- Heart_Disease$Resting_Blood_Pressure
colesterolo <- Heart_Disease$Serum_Cholesterol
# prima di procedere devo richiamare i dati che mi interessano
plot(blood2, colesterolo,
  xlab =

    "pressione sanguigna (mmHg)", ylab

  = "colesterolo (mg/dl)"
)
# inverto l'ordine dei dati per fare la regressione lineare in maniera tale che esca un dato corretto
regressione <- lm(colesterolo ~ blood2)
# per disegnare la retta di regressione lineare
abline(regressione, col = "red")
segments(blood2, fitted(regressione), blood2, colesterolo,
  col = "blue", lty = 2
)
title(main = "Regr.lin tra pressione a riposo e
Colesterolo del paziente")
# ora andiamo a vedere se i dati hanno una buona relazione
cor(blood2, colesterolo)
# i dati non sono in relazione
## conclusione sulla regressione lineare:
# possiamo notare come tutti i dati presenti all'interno del dataset non abbiano una forte relazione e quindi tutti i calcoli presenti sulla regressione risultano con poco impatto tra di loro
# il dato migliore che abbiamo ottenuto si ottiene con il rapporto con l'eta del paziente e il resting_blood_pressure (pressione sanguigna)
# [1] 0.2608977
# volendo posso applicare uno studio di regressione logistica, quindi non lineare per vontrollare l'area sotto la curva e quindi l'accuratezza dei dati (cosa che non implemento per adesso vista la non richiesta e la non necessita di questi dati)
# ora procedo con l'analisi dei dati riportati
plot(regressione$fitted, regressione$residuals,
  main = "Residui"
)
abline(0, 0)
# notiamo che il grafico cambia davvero poco, questo anche perchè i dati non sono effettivamente rapportabili!
# Infine, la distribuzione in quantili dei residui è confrontabile con quella di una normale
qqnorm(regressione$residuals)
qqline(regressione$residuals)
# faccio un ultimo tentativo per la regressione lineare, tr eta del paziente e max heart rate
eta2 <- Heart_Disease$Age
maxi2 <- Heart_Disease$Max_Heart_Rate_Achieved
# prima di procedere devo richiamare i dati che mi interessano
plot(eta2, maxi2,
  xlab =

    "Age (year)", ylab

  = "max_heart_rate"
)
# inverto l'ordine dei dati per fare la regressione lineare in maniera tale che esca un dato corretto
regrr <- lm(maxi2 ~ eta2)
# per disegnare la retta di regressione lineare
abline(regrr, col = "red")
segments(eta2, fitted(reg1), eta2, maxi2,
  col = "blue", lty = 2
)
title(main = "Regr.lin tra eta e
massimo battito cardiaco")
# in questo modo abbiamo creato il grafico per condurre una analisi della regressione lineare, adesso infatti possiamo andare a controllare i dati che ci rimandano al grafico:
cor(eta2, maxi2)
# possiamo notare come i dati ci indichino una percentuale del -39% che però come dato a noi va bene, dato che la differenza sostanziale della negativita è l'inclinazione della retta
# quindi possiamo assumere questi come dati che andremo ad utilizzare per fare le successive analisi.
plot(regrr$fitted, regrr$residuals,
  main = "Residui"
)
abline(0, 0)
# notiamo che il grafico cambia davvero poco, questo anche perchè i dati non sono effettivamente rapportabili!
# Infine, la distribuzione in quantili dei residui è confrontabile con quella di una normale
qqnorm(regrr$residuals)
qqline(regrr$residuals)
# richiamo il summary per controllare bene i dati
summary(regrr)
plot(eta2 ~ maxi2, data = Heart_Disease)
regressionelineare <- lm(eta2 ~ maxi2, data = Heart_Disease)
summary(regressionelineare)
# Nella prima parte dei risultati è riportata la descrizione dei residui del modello, cioè della distanza che c’è tra la retta di regressione e i singoli punti.
# Nella seconda parte sono riportati le stime dei coefficienti (in corrispondenza della colonna Estimate).
# finisco lo studio della regressione lineare andando a dare i valori di R e di R^2
R <- cor(Heart_Disease$Age, Heart_Disease$Max_Heart_Rate_Achieved)
R
R2 <- R^2
R2
# possiamo vedere che questo  è il coefficiente di determinazione per giudicare la bontà di accostamento.
# essendo valori piccoli e noon vicini a 1 sapremo che il modello si adatta molto poco ai dati presi in esame
# purtroppo pero questi sono i dati migliori che possiam vedere in esame!

# per creare un dataframe con solo dieci osservazioni che non siano presenti all'interno del nostro basta creare una funzione e trasformala, in modo tale da lavorare e fare previsioni sui dati
# in output dovrei ricevere i dati di predicione
# la funzione che ho usato predict() serve per prevedere i valori in base ai dati che ho inserito io in input,
# per fare previsioni bisogna applicare la regressione lineare, visto che da richiesta devo creare solamente una colonna mi dovro basare sulla regressione lineare calcolata in maniera precedente. quindi applico quella per avere dei risultati in output sulla console di comando

#Effettuo delle previsioni
# Creo il dataframe
summary(Heart_Disease$Serum_Cholesterol)
previsioni <- data.frame("Cholesterol" <- c(123, 124, 125, 126, 127, 128, 129, 130, 131, 132))
# Creo la regressione lineare
reg <- lm(Serum_Cholesterol ~ Cholesterol, Heart_Disease = Heart_Disease)
# Effettuo delle previsioni
predict(reg, previsioni)

# in questo modo ho fatto le previsioni delle 10 osservazioni che abbiamo inserito al'interno del nuovo dataset
# ora arriviamo alla parte di allenamento del dataset, in primo luogo dobbiamo utilizzare i dati usati sulla regressione lineare applicando i dati un algoritmo di forza bruta (eseguendo 15mila combinazioni con i dati stessi)
# quindi utilizziamo come dati della regresisone lineare la pressione sanguigna e il colesterolo, quindi prima di tutto proviamo ad applicare l'algoritmo
plot(Heart_Disease$Serum_Cholesterol)
plot(Heart_Disease$Resting_Blood_Pressure)
# riguardo la dispersione dei dati all'iterno dei due grafici con i dati che mi interessano
gg2 <- ggplot(Heart_Disease, aes(x = Serum_Cholesterol, y = Resting_Blood_Pressure)) +
  geom_point(aes(col = Diagnosis_Heart_Disease)) +
  geom_smooth(method = "loess", se = F) +
  xlim(c(100, 430)) +
  ylim(c(75, 200)) +
  labs(
    subtitle = "Resting_Blood_Pressure Vs Serum_Cholesterol",
    y = "Resting_Blood_Pressure",
    x = "Serum_Cholesterol",
    title = "Scatterplot",
    bins = 30
  )
plot(gg2)

# analizzando i dati adesso procediamo con gli algoritmi richiesti ai fini dell'esame
# install.packages("stuart")
library(stuart)
# ho importato questa libreria per poter utilizzare il comando di bruteforce, e poter implementare l'algoritmo in maniera corretta
library(tidyverse) # importo l libreria per utilizzarne le funzioni
# Sis.time dell'inizio del brute force, visto che viene richiesta nei punti successivi la implemento ad inizio e fine di ogni algoritmo
inizio <- Sys.time()
inizio
# Analizzo la struttura e i dati delle variabili "età" e "Massimo battito cardiaco", che sono gli stessi utilizzati per fare la regressione lineare!
summary(Heart_Disease$Age)
summary(Heart_Disease$Max_Heart_Rate_Achieved)
head(Heart_Disease$Age)
head(Heart_Disease$Max_Heart_Rate_Achieved)
# Imposto un seed e dei valori simulati, di cui vado a sostituire 
# -a, L'intercept
# -b, Lo scope
# Con quelli trovati con la regressione lineare negli scorsi punti
set.seed(2022)
lm(Heart_Disease$Max_Heart_Rate_Achieved  ~ Heart_Disease$Age)
n <- 1000
x <- rnorm(n)
a <- 25.190
b <- 0.883
e <- 4
y <- a + b*x + rnorm(n, sd = e)
# Creo le tabelle per i valori x e y
sim_d <- tibble(x = x, y = y)
sim_d
# Visualizzo il grafico creato con i punti x e y nel tibble "sim_d"
ggplot(sim_d, aes(x, y)) +
  geom_point()
# Stimo la relazione tra x e y utilizzando la tecnica dei "Minimi quadrati ordinari" ("OLS")
sim_ols <- lm(y ~ x)
summary(sim_ols)
# Implemento una funzione che mi permetta di calcolare "l'Errore Quadratico Medio" ("MSE")
mse <- function(a, b, x = sim_d$x, y = sim_d$y) {
  # Modello della prediction, con intercept e slope conosciuti
  prediction <- a + b*x 
  # Distanza tra l'osservazione e la predizione
  residuals <- y - prediction 
  # Eleviamo al quadrato per evitare che la somma sia zero (rendendolo positivo quindi)
  squared_residuals <- residuals^2 
  # Somma delle distanze quadrate
  ssr <- sum(squared_residuals) 
  ssr
  # Media delle distanze quadrate
  ssr <- mean(squared_residuals)
  ssr
}
# Per verificare che funzioni confrontiamo il MSE con l'OLS
mse(a = coef(sim_ols)[1], b = coef(sim_ols)[2])
mean(resid(sim_ols)^2)
# Sono uguali
# Quindi ora abbiamo una funzione generale che può essere utilizzata 
# per valutare l'obiettivo della nostra funzione per qualsiasi combinazione di intercept/slope. 
# Possiamo quindi, in teoria, valutare infinite combinazioni e trovare il valore più basso. 
# In questo caso, diverse centinaia di combinazioni.
grid <- expand.grid(a = seq(-25, 25, 0.1), b = seq(-0.8, 0.8, 0.01)) %>% 
  as_tibble()
grid
# Sarebbe davvero difficile per un pc analizzare 15.251 combinazioni.
# Calcoliamo il MSE per ogni combinazione.
mse_grid <- grid %>% 
  rowwise(a, b) %>% 
  summarize(mse = mse(a, b), .groups = "drop")
mse_grid
# Ora ci serve trovare la combinazione che riduce al minimo l'MSE
mse_grid %>% 
  arrange(mse) %>% 
  slice(1)
# La compariamo con l'OLS
coef(sim_ols)
# Molto simili
# Creiamo una funzione per calcolare il gradiente (derivata parziale) 
# per qualsiasi valore dei due parametri. Simile alla funzione `mse()` 
# ma in modo che sia abbastanza generale da poter fornire altri dati.
compute_gradient <- function(a, b, x = sim_d$x, y = sim_d$y) {
  n <- length(y)
  predictions <- a + (b * x)
  residuals <- y - predictions
  da <- (1/n) * sum(-2*residuals)
  db <- (1/n) * sum(-2*x*residuals)
  c(da, db)}
# Creiamo una funzione che utilizza la funzione precedente per calcolare il gradiente
# ma che in realtà fa solo un passo in quella direzione. 
# Lo facciamo moltiplicando prima le nostre derivate parziali per il nostro learning rate, 0.1 in questo caso
gd_step <- function(a, b, learning_rate = 0.1) {
  grad <- compute_gradient(a, b, x, y)
  step_a <- grad[1] * learning_rate
  step_b <- grad[2] * learning_rate
  
  c(a - step_a, b - step_b)
}
# Ora scegliamo un punto di partenza ("0"), e ogni volta che eseguiamo la funzione,
# il risultato si avvicinerà sempre di più all'intercept e lo slope che dobbiamo ottenere
walk <- gd_step(0, 0)
walk
walk <- gd_step(walk[1], walk[2])
walk
walk <- gd_step(walk[1], walk[2])
walk
# Velocizziamo utilizzando un semplice ciclo for
for(i in 1:25) {
  walk <- gd_step(walk[1], walk[2])
}
walk
# Riscriviamo le nostre funzioni per rendere i risultati più facili da memorizzare e ispezionare.
estimate_gradient <- function(pars_tbl, learning_rate = 0.1, x = sim_d$x, y = sim_d$y) {
  pars <- gd_step(pars_tbl[["a"]], pars_tbl[["b"]], learning_rate)
  tibble(a = pars[1], b = pars[2], mse = mse(a, b, x, y))}

# Inizializziamo e poniamo tutto in un ciclo for
grad <- estimate_gradient(tibble(a = 0, b = 0))
for(i in 2:50) {
  grad[i, ] <- estimate_gradient(grad[i - 1, ])
}
grad
# Ora aggiungiamo il numero di iterazione e creiamo un plot
grad <- grad %>% 
  rowid_to_column("iteration")

ggplot(grad, aes(iteration, mse)) +
  geom_line()
# Infine, poiché si tratta di una semplice regressione lineare, 
# possiamo tracciare la linea attraverso le iterazioni.
ggplot(sim_d, aes(x, y)) +
  geom_point() +
  geom_abline(aes(intercept = a, slope = b),
              data = grad,
              color = "gray60",
              size = 0.3) +
  geom_abline(aes(intercept = a, slope = b),
              data = grad[nrow(grad), ],
              color = "magenta")

# Sis.time della fine del brute force e lunghezza del periodo di tempo necessario
fine <- Sys.time()
fine
tempo <- fine - inizio
tempo
# possiamo notare il tempo in console per capire quanto il sistema ci ha messo a calcolare tutte le iterazioni che abbiamo chiesto
# sono soddisfatto dei dati in output che ho ricevuto, quidi procedo con l'esame
# possiamo notare come ci vogliano dai 2 ai 4 secondi per far girare questo algoritm, con il computer scolastico
# bisognerebbe provare ad utilizzarlo con un computer con un apotenza maggiore

# adesso devo attuare lo stesso metodo per applicare ai dati di esame Utilizzando le stesse due variabili del dataset scelte per la regressione lineare semplice, determinare attraverso l’algoritmo del gradiente
# andiamo ad applicare l'algritmo che ci viene dato per poter forzare i dati espressi precedentemente
library(tidyverse)
# quindi adiamo avanti applicando 'algoritmo del gradiente
## Sis.time dell'inizio del gradiente, come nel caso precedente per vedere in quanto tempo si sviluppa il programma
inizio2 <- Sys.time()
inizio2
## Analizzo la struttura e i dati delle variabili "eta" e "max_heart_rate"
summary(Heart_Disease$Age)
summary(Heart_Disease$Max_Heart_Rate_Achieved)
head(Heart_Disease$Age)
head(Heart_Disease$Max_Heart_Rate_Achieved)
## Imposto un seed e dei valori simulati, di cui vado a sostituire 
## -a, L'intercept
## -b, Lo scope
## Con quelli trovati con la regressione lineare negli scorsi punti e li vado ad applicare
set.seed(2022)
lm(Heart_Disease$Max_Heart_Rate_Achieved  ~ Heart_Disease$Age)
n <- 1000
x <- rnorm(n)
a <- 25.190
b <- 0.883
e <- 4
y <- a + b*x + rnorm(n, sd = e)
## Creo le tabelle per i valori x e y
sim_d <- tibble(x = x, y = y)
sim_d
## Visualizzo il grafico creato con i punti x e y nel tibble "sim_d"
ggplot(sim_d, aes(x, y)) +
  geom_point()
## Stimo la relazione tra x e y utilizzando la tecnica dei "Minimi quadrati ordinari" ("OLS")
sim_ols <- lm(y ~ x)
summary(sim_ols)
## Implemento una funzione che mi permetta di calcolare "l'Errore Quadratico Medio" ("MSE")
mse <- function(a, b, x = sim_d$x, y = sim_d$y) {
  ## Modello della prediction, con intercept e slope conosciuti
  prediction <- a + b*x 
  ## Distanza tra l'osservazione e la predizione
  residuals <- y - prediction 
  ## Eleviamo al quadrato per evitare che la somma sia zero (rendendolo positivo quindi)
  squared_residuals <- residuals^2 
  ## Somma delle distanze quadrate
  ssr <- sum(squared_residuals) 
  ssr
  ## Media delle distanze quadrate
  ssr <- mean(squared_residuals)
  ssr
}
## Per verificare che funzioni confrontiamo il MSE con l'OLS
mse(a = coef(sim_ols)[1], b = coef(sim_ols)[2])
mean(resid(sim_ols)^2)
## Sono uguali
## Quindi ora abbiamo una funzione generale che puÃ² essere utilizzata 
## per valutare l'obiettivo della nostra funzione per qualsiasi combinazione di intercept/slope. 
## Possiamo quindi, in teoria, valutare infinite combinazioni e trovare il valore piÃ¹ basso. 
## In questo caso, diverse centinaia di combinazioni.
grid <- expand.grid(a = seq(-25, 25, 0.1), b = seq(-0.8, 0.8, 0.01)) %>% 
  as_tibble()
grid
## Sarebbe davvero difficile per un pc analizzare 15.251 combinazioni.
## Calcoliamo il MSE per ogni combinazione.
mse_grid <- grid %>% 
  rowwise(a, b) %>% 
  summarize(mse = mse(a, b), .groups = "drop")
mse_grid
## Ora ci serve trovare la combinazione che riduce al minimo l'MSE
mse_grid %>% 
  arrange(mse) %>% 
  slice(1)
## La compariamo con l'OLS
coef(sim_ols)
## Molto simili
## Creiamo una funzione per calcolare il gradiente (derivata parziale) 
## per qualsiasi valore dei due parametri. Simile alla funzione `mse()` 
## ma in modo che sia abbastanza generale da poter fornire altri dati.
compute_gradient <- function(a, b, x = sim_d$x, y = sim_d$y) {
  n <- length(y)
  predictions <- a + (b * x)
  residuals <- y - predictions
  
  da <- (1/n) * sum(-2*residuals)
  db <- (1/n) * sum(-2*x*residuals)
  
  c(da, db)}
## Creiamo una funzione che utilizza la funzione precedente per calcolare il gradiente
## ma che in realta fa solo un passo in quella direzione. 
## Lo facciamo moltiplicando prima le nostre derivate parziali per il nostro learning rate, 0.1 in questo caso
gd_step <- function(a, b, learning_rate = 0.1) {
  grad <- compute_gradient(a, b, x, y)
  step_a <- grad[1] * learning_rate
  step_b <- grad[2] * learning_rate
  
  c(a - step_a, b - step_b)
}
## Ora scegliamo un punto di partenza ("0"), e ogni volta che eseguiamo la funzione,
## il risultato si avvicinera sempre di piÃ¹ all'intercept e lo slope che dobbiamo ottenere
walk <- gd_step(0, 0)
walk

walk <- gd_step(walk[1], walk[2])
walk

walk <- gd_step(walk[1], walk[2])
walk
## Velocizziamo utilizzando un semplice ciclo for
for(i in 1:25) {
  walk <- gd_step(walk[1], walk[2])
}
walk
## Riscriviamo le nostre funzioni per rendere i risultati piu¹ facili da memorizzare e ispezionare.
estimate_gradient <- function(pars_tbl, learning_rate = 0.1, x = sim_d$x, y = sim_d$y) {
  pars <- gd_step(pars_tbl[["a"]], pars_tbl[["b"]], learning_rate)
  tibble(a = pars[1], b = pars[2], mse = mse(a, b, x, y))}
## Se la differenza tra il vecchio e il nuovo MSE Ã¨ inferiore al valore Epsilon (o se viene raggiunto il numero massimo di iterazioni), l'algoritmo si fermerÃ 
mse_old <- 0
mse_new <- .1
epsilon <- .0005
iteration <- 50
## Inizializziamo e poniamo tutto in un ciclo while (con condizioni quindi)
grad <- estimate_gradient(tibble(a = 0, b = 0))
i <- 2
while(abs(mse_new - mse_old) > epsilon & i <= iteration) {
  grad[i, ] <- estimate_gradient(grad[i - 1, ])
  mse_old <- grad[i - 1, ncol(grad)]
  mse_new <- grad[i, ncol(grad)]
  i = i + 1
}
grad
## Ora aggiungiamo il numero di iterazione e creiamo un plot
grad <- grad %>% 
  rowid_to_column("iteration")

ggplot(grad, aes(iteration, mse)) +
  geom_line()
## Infine, poichÃ© si tratta di una semplice regressione lineare, 
## possiamo tracciare la linea attraverso le iterazioni.
ggplot(sim_d, aes(x, y)) +
  geom_point() +
  geom_abline(aes(intercept = a, slope = b),
              data = grad,
              color = "gray60",
              size = 0.3) +
  geom_abline(aes(intercept = a, slope = b),
              data = grad[nrow(grad), ],
              color = "magenta")
## Sis.time della fine del gradiente e lunghezza del periodo di tempo necessario
fine2 <- Sys.time()
fine2
tempo1 <- fine - inizio
tempo1
## Grazie alla differenza di tempo tra i due possiamo notare che l'algoritmo
## del gradiente risulta leggermente piu¹ veloce rispetto all'algoritmo di forza bruta

# adesso per finire sviluppiamo l'algoritmo di machine learning che cosi siamo pronti a completare l'esame
# Machine Learning
## Importiamo la libreria "caret" (visualizzazione dei dati finali)
install.packages("lattice")
library(caret)
## Visualizziamo i dati riguardo la talassemia
## Dimensioni
dim(Heart_Disease)
## Tipi di attributi
sapply(Heart_Disease, class)
## Prime 6 righe
head(Heart_Disease)
## Vediamo i Levels (Possibili valori) della variabile factor "talassemia"
levels(Heart_Disease$Thalassemia)
## Riepiloghiamo la distribuzione delle classi
## possiamo vedere che ogni classe ha lo stesso numero di istanze
percentage <- prop.table(table(Heart_Disease$Thalassemia)) * 100
cbind(freq = table(Heart_Disease$Thalassemia), percentage = percentage)
## Visualizziamo la distribuzione degli attributi, andremo a considerarli quasi tutti
summary(Heart_Disease)
## Dividiamo gli attributi in due classi (input e output), talassemia in output e tutto il resto in input
x <- Heart_Disease[,1:11, 13]
dim(x)
y <- Heart_Disease[, 12]
dim(t(y))
par(mfrow = c(1, 12))
## Distribuzione degli attributi input in ordine, primi 12 attributi tranne talassemia
for (i in 1:12) {
  boxplot(x[, i], main = names(Heart_Disease)[i])
}
## Ora creiamo un set di test con un seed casuale
set.seed(2022)
## Creiamo una matrice che utilizzi l'80% dei valori per allenarsi
training_index <- createDataPartition(Heart_Disease$Thalassemia, p = .80, list = FALSE)
## Selezione dell'80%
training_set <- Heart_Disease[training_index, ]
nrow(training_set)
## Utilizziamo il restante 20% per test
test_set <- Heart_Disease[-training_index, ]
nrow(test_set)
dim(test_set)
dim(training_index)
## Utilizziamo la "k(10) Cross Validation" per eseguire gli algoritmi
seed = set.seed(2022)
control <- trainControl(method = "cv", number = 10, seed = seed)
metric <- "Accuracy"
## Elenco degli algoritmi da confrontare tra di loro per ottenere il piÃ¹ efficiente
#1. Linear Discriminant Analysis (*LDA*);
#2. Classification and Regression Trees (*CART*);
#3. k-Nearest Neighbors (*kNN*);
#4. Multi-Layer Perceptron (*MLP*);
#5. Random Forest (*RF*);
#6. Support Vector Machines (*SVM*) with a linear kernel.
## Lineari
#lda
fit_lda <- train(Thalassemia ~ ., data = training_set, metric = metric, trControl = control, method = "lda")
## Non Lineari
# CART
fit_cart <- train(Thalassemia ~ ., data = training_set, metric = metric, trControl = control, method = "rpart")
# kNN
fit_knn <- train(Thalassemia ~ ., data = training_set, metric = metric, trControl = control, method = "knn")
## Avanzati
# Random Forest
fit_rf <- train(Thalassemia ~ ., data = training_set, metric = metric, trControl = control, method = "rf")
# SVM
fit_svm <- train(Thalassemia ~ ., data = training_set, metric = metric, trControl = control, method = "svmRadial")
## Riassumiamo e Ordiniamo l'accuratezza degli algoritmi
## sappiamo che si puo:  possibile vedere l'accuratezza di ogni algoritmo e anche altre metriche come Kappa (che non prenderemo in considerazione)
results <- resamples(list(lda = fit_lda, cart = fit_cart, knn = fit_knn, rf = fit_rf, svm = fit_svm))
summary(results)
dotplot(results)
## In questo caso, il piÃ¹ accurato Ã¨ l'SVM, visualizziamone i risultati
fit_svm$results
## Ora possiamo stimare l'accuratezza di svm sul test set e fare predizioni su di esso
predictions <- predict(fit_svm, test_set)
confusionMatrix(predictions, test_set$Thalassemia)

library(tidyverse)
install.packages("lattice")
library(caret)

# possiamo fare un ulteriore prova applicando un secondo algoritmo di machine learning:
# proviamo ad applicarlo
set.seed(5000) #serve a dividere il dataset casualmente

index <-
  createDataPartition(Heart_Disease$Max_Heart_Rate_Achieved, #divide il dataset su una variabile che vuoi
                      p = .8, #io l'ho diviso 80/20 di solito ho visto fare da 65 a 85
                      list = FALSE)

training_set <- Heart_Disease[index, ] #teniamo 80% per il training

test_set <- Heart_Disease[-index, ] #20% per il testing

seed = set.seed(5000) #seed lo usiamo dopo 
control <- trainControl(method = "cv", #
                        number = 10,   #Qui ho copiato dalle slide
                        seed = seed)   #
metric <- "Accuracy" #il metodo usato per valutare i risultati

pred1 <-
  train(
    Diagnosis_Heart_Disease ~ ., #valutiamo target con tutto il resto del dataset(.)
    data = training_set,  #usiamo il dataset di training
    metric = metric, #metric puoi usare direttamente accuracy
    trControl = control,  
    method = "rpart"  #qui ci sono vari metodi abbiamo visto lda, rpart, knn, mlp, rf, smvRadial
  )

results <- list(pred1) #salvo i risulati in una lista
summary(results)

pred1$results #da qui in poi basta che sostituisci i dati coi tuoi

predictions <- predict(pred1, test_set)

cm <-
  confusionMatrix(predictions,
                  test_set$Diagnosis_Heart_Disease %>% as.factor())
cm
cm$table
cm2 <- cm$table %>% as.data.frame() #qui mi sono inventato io per fare la matrice di confusione
library(ggplot2)
ggplot(cm2, aes(Prediction, Reference, fill = Freq)) +
  geom_tile() +
  scale_fill_gradientn(colors = c("lightyellow", "yellow", "orange", "orange3", "red3")) +
  geom_text(aes(label = Freq), color = "black", size = 4) +
  theme_classic()