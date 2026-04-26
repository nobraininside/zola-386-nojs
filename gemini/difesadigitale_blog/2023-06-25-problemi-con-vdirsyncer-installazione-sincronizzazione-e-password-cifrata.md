---
Title: Problemi con vdirsyncer: installazione, sincronizzazione e password cifrata
Published: 2023-06-25 13:44:26
Author: yellowadmin
Layout: blog
Tag: sync, cli
---
Vdirsyncer è un ottimo programma, semplice e veloce. Può avere tuttavia alcuni problemi: a) in fase di installazione; b) per il settaggio della sincronizzazione; c) se non vuoi inserire la password in chiaro ma cifrata. Vediamo come risolverli:

**Installazione manuale**

Se il tuo package manager non riesce ad installare vdirsyncer, per una serie di conflitti irrisolti, esiste una procedura alternativa molto semplice con il comando *virtualenv* :

1. esegui come user  `virtualenv ~/.vdirsyncer_env` per creare una cartella in cui verrà installato *vdirsyncer* (qui ho scelto di creare nella home una cartella nascosta di nome *.vidirsyncer_env*, ma puoi darle il nome e l'ubicazione che preferisci: basta che poi adatti in conseguenza il codice ai passaggi successivi);

2. esegui come user `~/.vdirsyncer_env/bin/pip install vdirsyncer` per installare *vdirsyncer* con tutte le sue dipendenze;
[--more--]<br />
3. inserisci in .*bashrc* o in .*bash_profile* `alias vdirsyncer="~/.vdirsyncer_env/bin/vdirsyncer"` per avviare il programma.

4. crea la cartella *~/.config/vdirsyncer*, cartella che deve contenere i parametri di connessione del programma e non va assolutamente confusa con *~/.vdirsyncer_env/bin/vdirsyncer*, in cui si trovano invece gli eseguibili e le dipendenze.

5. in ~/.config/vdirsyncer crea la cartella *status* e il file *config* nel quale inserirai tutti i parametri di connessione fra cartelle locali e remote (te ne darò un esempio alla fine di questo articolo).

**Auth**

Se devi sincronizzare i tuoi file con Baikal, devi inserire il parametro `auth = "digest"` in  *~/.config/vdirsyncer/config*. Può accadere tuttavia, per un bug interno di Baikal, che la sincronizzazione non funzioni. In questo caso devi:

1. inserire il paramentro `auth = "basic"` in *vdirsyncer*.

2. andare nel pannello amministrazione di Baikal e settare *basic* al posto di *digest* come modalità di sinronizzazione ammessa (ricordati poi di riavviare la sessione perché il tuo alias venga preso in conto dal sistema).

**Password cifrata**

Se vuoi evitare di scrivere la password in chiaro nel file di configurazione *~/.config/vdirsyncer/config*  puoi usare il programma *pass*, di cui abbiamo parlato in [questo articolo](https://difesadigitale.blog/edit/configurare-pass-il-comodissimo-password-manager-da-terminale). Supponendo che tu abbia salvato come *sync/baikal*, nella cartella cifrata *pass* del tuo computer, la password di accesso al tuo server remoto Baikal, dovrai inserire in vdirsyncer il seguente comando, al posto di `password = "la_mia_password"`:

* `password.fetch = ["command", "pass", "show", "sync/baikal"]`.Nella parentesi quadra, *command* dice a vdirsyncer di eseguire il programma specificato dopo (*pass*), e la terza indicazione è l'argomento di *pass*, cioè l'indicazione della password da ricuperare.

**file di configurazione**

Per riassumere quanto spiegato sopra, ecco un esempio di file di configurazione di *vdirsyncer* con i parametri appena spiegati:

```
[general]
status_path = "~/.config/vdirsyncer/status/"

[pair contacts_baikal]
a = "contacts_baikal_local"
b = "contacts_baikal_remote"
collections = ["from a", "from b"]

[storage contacts_baikal_local]
type = "filesystem"
path = "~/.contacts/"
fileext = ".vcf"

[storage contacts_baikal_remote]
type = "carddav"
# normalmente qui sotto va inserito il parametro "digest" ma se non funzione metti "basic"
# e setta "basic" anche nel pannello di amministrazione remoto di Baikal
auth = "basic"
url = "https://<metti qui l'url del tuo server>/html/dav.php/addressbooks/<metti qui il tuo username su Baikal>/"
username = "<il tuo username>"
password.fetch = ["command", "pass", "show", "sync/baikal"]


[pair calendars_baikal]
a = "calendars_baikal_local"
b = "calendars_baikal_remote"
collections = ["from a", "from b"]
metadata = ["color"]

[storage calendars_baikal_local]
type = "filesystem"
path = "~/.calendars/"
fileext = ".ics"

[storage calendars_baikal_remote]
type = "caldav"
# normalmente qui sotto va inserito il parametro "digest" ma se non funziona metti "basic"
# e setta "basic" anche nel pannello di amministrazione remoto di Baikal
auth = "basic"
url = "https://<metti qui l'url del tuo server>/html/dav.php/calendars/<metti qui il tuo username su Baikal>/"
username = "<il tuo username>"
password.fetch = ["command", "pass", "show", "sync/baikal"]
```

**Primo avvio**

NOTA BENE: una volta installato il programma, dovrai avviarlo una prima volta. Ricorda che l'eseguibile è nella cartella di cui sopra al punto 1), quindi dovrai digitare, da terminale in cartella home, ` .vdirsyncer_env/bin/vdirsyncer discover` (o semplicemente `vdirsyncer discover`, se hai creato un alias e riavviato la sessione). 
Successivamente, per sincronizzare, ti basterà digitare ` .vdirsyncer_env/bin/vdirsyncer sync` (o semplicemente `vdirsyncer sync`).


