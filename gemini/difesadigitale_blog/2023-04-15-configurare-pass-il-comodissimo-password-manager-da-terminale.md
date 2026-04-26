---
Title: Configurare pass, il comodissimo password manager da terminale
Published: 2023-04-15 16:02:08
Author: yellowadmin
Layout: blog
Tag: terminale, cli
---
In un articolo precedente abbiamo spiegato [come installare pass](installare-sshpass-gnupg-e-pinentry-su-macos-openbsd-e-linux) in diversi sistemi operativi. Ora vediamo come configurare il password manager.

Per prima cosa, devi generare un set di chiavi di cifratura (chiave pubblica e privata): 
[--more--]<br />

1. come utente semplice digita in un terminale `gpg --full-generate-key`;
2. Alla domanda *Please select what kind of key you want* rispondi scegliendo l'opzione `(1) RSA and RSA (default)`;
3. Alla domanda *What keysize do you want?* rispondi `4096`;
4. Poi scegli la durata delle tue chiavi (*Key is valid for?*). Puoi rispondere ad esempio `100` per una validità di 100 giorni, `20w` per 20 settimane `10m` per 10 mesi o `3y` per 3 anni. Meglio in ogni caso evitare `0`, che sta per validità illimitata;
5. Ora inserisci i tuoi dati. Nel campo `Real Name` inserisci il tuo username (ad esempio *pincopallino*) e conferma digitando `O`. Gli altri campi si possono lasciare vuoti.

Ora le chiavi sono state generate. Per inizializzare *pass* digita `pass init <username>` (ad esempio `pass init pincopallino`).

Adessi sei pronto a usare pass: <br />

* per aggiungere una password digita `pass insert <nome>` (ad esempio: pass insert email) e poi inserisci la password da memorizzare;
* per mostrare una password digita `pass show <nome>`;
* per copiare una password senza mostrarla digita `pass - c <nome>`. Avrai 45 secondi per incollare la password nell'apposita casella (per esempio se ti colleghi alla tua webmail digiterai iin terminale `pass -c email` e poi *Ctrl+V* o *Cmd-V* per incollarla nella schermata di accesso alla webmail;
* per modificare una password esistente `pass edit <nome>`;
* per rimuovere una pasword esistente `pass rm <nome>`;
* per conoscere gli altri comandi `man pass`.


