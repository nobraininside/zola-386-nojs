---
Title: Imposta Thunderbird per inviare email cifrate
Published: 2022-09-19 10:54:10
Author: Writer
Layout: blog
Tag: privacy,openpgp

---
In un precedente articolo abbiamo sottolineato l'urgenza di una [nuova pedagogia informatica](https://difesadigitale.blog/per-una-nuova-pedagogia-informatica) da sviluppare secondo tre linee direttrici:  acquisizione di nuove conoscenze, pratiche a tutela della privacy, autogestione dei propri servizi e server. Oggi vedremo come usare **OpenPGP** per cifrare le email ed evitare che siano leggibili da chiunque come se fossero cartoline. Useremo Thunderbird, il sistema più semplice e adatto all'uso quotidiano, anche se preferiamo software più spartani e solidi come Claws-Mail. L'importante è abituarsi a usare new OpenPGP, sennò saremo sempre alla mercè di *corporation*, *hacker* e Grande Fratello.<br />
[--more--]<br />

I) OPERAZIONI PRELIMINARI<br />
Per poter inviare un’email criptata con Thunderbird devi creare una chiave privata OpenPGP collegata alla tua casella email. L’operazione va fatta una sola volta, per ogni tuo indirizzo elettronico.

1. schermo del pc, menu in alto a sinistra:  CLIC Attività > Thunderbird
 
2. nella finestra di Thunderbird, in alto a sinistra: CLIC  icona panino > Account Settings<br />
[image pgp1-i.2-cut.png]

3. nella colonna a sinistra di Thunderbird: DOPPIO CLIC sulla casella email che vi interessa (apparirà una tendina con varie opzioni)

4. nella colonna a sinistra, sotto la casella email selezionata: CLIC End-to-End Encryption<br />
[image pgp2-i.4-cut.png]

5. nell’area principale a destra di Thunderbird: CLIC pulsante Add Key. Si aprirà una finestra<br />
[image pgp3-i.5-cut.png]

6. nella finestra aperta: SELEZIONA Create a new OpenPGP Key > Continue<br />
[image pgp4-i.6-cut.png]

7. CLIC Generate key > CLIC Confirm<br />
[image pgp5-i.7-cut.png]

Quando crei una chiave privata, contestualmente è generata una chiave pubblica. Quest’ultima può essere inviata per email ai vostri corrispondenti o, meglio ancora, caricata nelle “pagine bianche” delle chiavi pubbliche. A tal fine:

a) nella finestra di Thunderbird, in alto a sinistra: CLIC  icona panino > Tools > OpenPGP Key Manager. Si aprirà una nuova finestra.

b) nella nuova finestra CLIC sulla chiave da esportare. Nella stessa finestra, in alto a sinistra, CLIC File > Export public key(s) to file e salva il file in una cartella del tuo pc<br />
[image pgp6-i.b-cut.png]

c) apri il tuo browser (ad esempio FIrefox) e vai all’indirizzo keys.openpgp.org (è un annuario generale delle chiavi pubbliche delle email).<br />
[image pgp7-i.c.png]

d) in keys.openpgp.org: INSERSCI l’indirizzo email di cui hai creato le chiavi. Poi CLIC upload. > SELEZIONA il file con la chiave pubblica della casella (v. sopra al punto 2)
       

II) INVIA UN’EMAIL CRIPTATA
Puoi spedire email criptate se:

* hai creato le chiavi privata/pubblica della tua casella e pubblicato la chiave privata (v. sopra);
* la casella del destinatario ha  anch’essa le chiavi pubblica e privata OpenPGP;
* la chiave pubblica del destinatario è nota al tuo Thunderbird e accettata.

Per predisporre il tuo account all'invio di email cifrate, nella finestra di Thunderbird, in alto a sinistra: CLIC icona panino > Account Settings > End-to-End Encryption, poi vai a Default settings for sending messages e SPUNTA Disable encryption for sending messages + SPUNTA Sign unencrypted messages. In questo modo tutte le tue email allegheranno la tua chiave pubblica: se tra i tuoi destinatari qualcuno ha configurato OpenPGP nel suo client email, potrà avviare una corrispondenza cifrata con te; gli altri invece portanno ricevere le tue email come se nulla fosse... e magari saranno incuriositi da quell'allegato (la curiosità è l'origine del pensiero). <br />
D'altro canto, se oltre a firmare di default le tue email, vorrai anche cifrarle, ti basterà aprire la finestra di composizione della lettera e cliccare il pulsante Encrypt prima di spedirla.

Se quando invii un'email cifrate Thundebird non  trova automaticamente la chiave pubblica del destinatario:

A) apparirà un messaggio di errore. Chiudilo<br />
[image pgp8-ii.a.png]

B) chiedi al destinatario di spedirtela per email/chat o cercala su keys.openpgp.org e poi salvala<br />
[image pgp9-ii.b.png]

C) nella finestra di Thunderbird, in alto a sinistra: CLIC  icona panino > Tools > OpenPGP Key Manager <br />
[image pgp10-ii.c.png]

D) in OpenPGP manager: SELEZIONA Import public key(s) from file poi CLIC sulla chiave pubblica appena salvata nella cartella Persistent di Tails (il nome del file finisce con “...-public.asc). Apparirà una nuova finestra con richiesta di conferma.

E) Nella finestra Import following key(s) SPUNTA Accepted poi CLIC OK e ancora OK<br />
[image pgp11-ii.e.png]

Da ora in poi puoi inviare email criptate a quell’indirizzo come fossero normali email: non dovrai più ripetere – se non per aggungere nuovi destinatari di missive cifrate – le operazioni appena descritte.





