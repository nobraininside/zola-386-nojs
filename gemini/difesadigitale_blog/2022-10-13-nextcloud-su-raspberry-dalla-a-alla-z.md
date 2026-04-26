---
Title: Nextcloud su Raspberry dalla A alla Z
Published: 2022-10-13 17:30:36
Author: Writer
Layout: blog
Tag: cifratura, nextcloud, raspberry, 
---
Mi sono sempre chiesto se Nextcloud potesse girare su Raspberry Pi. In ambiente di produzione, intendo, perché installare un server che s'impalla ogni due minuti sarà pure uno sfizio ma, francamente, penso che nessuno abbia tempo da perdere. Alla fine bastava provare, e fuziona tutto a dovere: parlo di un'installazione di svariate centinaia di Giga e una manciata di utenti. Ecco la ricetta:  un Raspberry Pi 4 , una scheda SSD da 32 GB per il sistema operativo, un hard disk esterno per archiviare file e cartelle, un cavo di rete e un computer funzionante. Punto. Si fa tutto da remoto, da un terminale del pc principale.<br />
[--more--]<br />
**1. Installazione di Raspberry OS sulla scheda SSD**

* Inserisci la scheda SSD nell'apposito lettore del tuo computer;
* Installa il *Raspberry Pi imager*. A tal fine, se hai Linux apri un terminale e digita `sudo apt install rpi-imager`, se hai un altro OS scarica il programma da [qui](https://www.raspberrypi.com/software/);
* Avvia `rpi-imager` per installare il sistema operativo Raspberry sulla scheda SSD. Nelle schermate del programma:
  - [ ] scegli la versione Lite a 64 bit raspios-bullseye-arm64-lite.img;
  - [ ] seleziona il *device* - ossia la scheda SSD - su cui copiare raspios;
  - [ ] IMPORTANTE, clicca l'iconcina in basso a destra con l'ingranaggio e spunta le seguenti caselle, compilando ove necessario i campi corrispondenti: a) imposta nome host; b) abilita SSH; c) imposta nome utente; d) inserisci password; e) imposta configurazioni locali, fuso e layout tastiera; f) boot partition write-protected. 
* Copia l'immagine così impostata. Una volta conclusa l'operazione estrai la scheda SSD dal lettore del tuo pc e inseriscila nel tuo Raspberry.

**2. Operazioni preliminari sul Raspberry Pi**

* Collega il Raspberry al router tramite il cavo di rete e avvia il computerino (basta collegarlo alla corrente elettrica);
* Apri un terminale dal tuo computer principale;
* Trova l'IP del Raspberry. Per questo collegati dal tuo computer principale al pannello di configurazione del router (se non conosci IP e password del router chiedi a un motore di ricerca. Per esempio chi ha TIM può cercare su qwant.com "IP e password router TIM" ) . Nella *dashboard* del router trova l'elenco dei dispositivi LAN, cioè connessi via cavo: fra questi ci sarà il Raspberry col relativo IP - qualcosa come 192.168.1.007.
* Apri un terminale dal tuo computer principale e digita `ssh pi@192.168.1.007` (beninteso sostituendo questo IP fittizio con quello vero trovato nel router). Poi digita la password che hai inserito quando usavi rpi-imager;
* Rendi statico l'IP del Raspberry, così non dovrai cercarlo sul router ad ogni riavvio. A tal fine digita `sudo nano /etc/dhcpcd.conf` nel terminale collegato al Raspberry e vai alla sezione *# Example static IP configuration*, che modificherai come segue:<br />
`interface eth0`<br />
`static ip_address=192.168.1.007/24`<br />
`# static ip6_address=gh33:12t4:klle:a12e::ff/64`<br />
`static routers=192.168.1.1`<br />
`static domain_name_servers=192.168.1.1 9.9.9.9 9.9.9.10`<br />
Nel tuo file dovrai: a) mettere il vero IP del tuo Raspberry, seguito da /24; b) lasciare # davanti a static ip6_address; c) inserire il corretto IP del router; d) alla quarta riga inserire di nuovo l'IP del router seguito da uno spazio e, se vuoi, dai DNS di Bind 9 che ho messo qui (9.9.9.9 e 9.9.9.10).

Poi riavvia il Raspberry (`sudo reboot`) e ricollegati da terminale.

**3. Installazione di Nextcloud su Raspberry Pi**

Come consigliato dal blog [Unix etc](http://unixetc.co.uk/2017/11/25/automatic-nextcloud-installation-on-raspberry-pi/),  possiamo affidarci ad Ansible, un ottimo script che fa praticamente tutto da solo:

* Installa Ansible  (`sudo apt-get -y install ansible`) e lo script per Nextcloud:<br />
`wget https://raw.githubusercontent.com/webtaster/Nextcloud/master/build_nextcloud.yml`<br />
* Poi installa Nextcloud nella versione con Sqlite. Quest'ultimo è database adatto anche a chi ha molti GB di dati, purché abbia pochi utenti Nextcloud e/o connessioni simultanee, com'è il caso di una installazione casalinga o in un piccolo ufficio (se tuttavia preferisci MySql troverai le istruzioni nell'articolo citato di Unix etc). Ecco il comando di installazione:<br />
`sudo date ; ansible-playbook --become -c local -i "localhost," build_nextcloud.yml`<br />
* Una volta conclusa l'operazione, verifica che la cartella *data* sia stata creata correttamente e abbia il proprietario giusto (www-data). Questo è un punto importante, perché se questa cartella è configurata male il *wizard* da attivare alla tappa successiva non riuscirà ad accedervi per creare il database sqlite e si incepperà. Quindi, se la cartella non c'è e/o non è a posto digita i comandi seguenti:
  - [ ] `sudo mkdir /var/www/html/nextcloud/data` per crearla;
  - [ ] `sudo chown www-data:www-data /var/www/html/nextcloud/data` per attribuirle il giusto proprietario.
* In ultimo apri un browser nel tuo pc e digita nella barra degli indirizzi l'IP del tuo Raspberry (per esempio 192.168.1.007) per finalizzare l'installazione: apparirà il *wizard* di Nextcloud, con la sua classica pagina blu. Inserisci nome utente e password, clicca "Finalizza". FIne: tutto ciò che segue è facoltativo, anche se altamente consigliato.

**4. Post installazione di Nextcloud**

Una volta installato tutto, accedi a Nextcloud dal browser, clicca l'icona in alto a destra e vai a *Settings*. Nella pagina seguente vai alla colonna sinistra e seleziona *Overview*, la prima voce della sezione *Administration*: Nextcloud farà un controllo della configurazione e ti suggerirà alcune migliorie. Ecco quelle essenziali:

* Se manca php-intl, che serve a gestire i molteplici linguaggi, codifiche, impostazioni locali presenti in un sistema complesso, con molti moduli, come Nextcloud, l'*Overview* te lo segnalerà. Per installare l'estensione: 
  - [ ] digita:`sudo apt install php-intl`
  - [ ] riavvia apache: `sudo systemctl restart apache2`
* Se appare il messaggio *The "Strict-Transport-Security" HTTP header is not set to at least "15552000" seconds...* devi modificare il file di configurazione dell'interfaccia web di Nextcloud:
  - [ ] digita `sudo nano /etc/apache2/sites-available/000-default.com`
  - [ ] inserisci queste tre righe giusto sopra quella in cui è scritto *Directory /var/www/html/nextcloud*:<br />
`<IfModule mod_headers.c>`<br />
`Header always set Strict-Transport-Security "max-age=15552000; includeSubDomains"`<br />
`</IfModule>`<br />
  - [ ] riavvia il modulo: `sudo a2enmod headers`
  - [ ] riavvia apache: `sudo systemctl restart apache2`
* Se appare il messaggio *The PHP memory limit is below the recommended value of 512MB* devi modificare il valore indicato nel file di configurazione di php e, già che ci sei, aumentare la dimensione dei file trasferibili durante la sincronizzazione per velocizzare il tutto. Ecco come fare:
  - [ ] digita: `sudo find / -name php.ini` per trovare il file di configurazione di php;
  - [ ]  apri con l'editor il file trovato: `sudo nano /etc/php/7.4/apache2/php.ini` (al posto di "7.4" metti il numero di versione che hai trovato con `find`);
  - [ ] vai alla riga *memory_limit* (per trovarla con nano `Ctrl+w memory_limit`) e inserisci almeno 512M, meglio 1536M se hai Raspberry Pi 4 con RAM da due giga (l'idea è dedicare 3/4 della RAM a Nextcloud se il Raspberry non è dedicato ad altro, quindi 718M per ogni Giga di RAM). Salva il tutto e poi, per aumentare la velocità di trasferimento durante la sincronizzazione fai le tre piccole modifiche indicate qui di seguito;
  - [ ] vai alla riga *post_max_size* e inserisci il valore 25G;
  - [ ] vai alla riga *upload_max_filesize* e inserisci il valore 25G e salva tutto;
  - [ ]  apri con l'editor il file di configurazione Nextcloud (`sudo nano /var/www/html/nextcloud/config/config.php`) e aggiungi la riga  ` 'chunkSize' => '5120MB',` giusto sopra il` );` finale e salva tutto;
  - [ ] riavvia apache: `sudo systemctl restart apache2`
* Se appare il messaggio *PHP configuration option output_buffering must be disabled* devi modificare il file di configurazione di php:
  - [ ] `sudo nano /etc/php/7.4/apache2/php.ini` (sostituisci "7.4" col numero corretto);
  - [ ]  cerca la `riga output_buffering = 4096` e sostituisci il valore numerico con "0" (zero);
  - [ ] riavvia apache: `sudo systemctl restart apache2`
* Se appare il messaggio *Some app directories are owned by a different user than the web server one* seguito da un elenco di applicazioni, digita `sudo chown -R www-data:www-data /var/www/html/nextcloud/apps` per attribuire ad esse il giusto proprietario (lo user www-data).

**5. Rendere Nextcloud accessibile dall'esterno**

Per accedere alla pagina web di Nextcloud hai inserito nella barra degli indirizzi del tuo browser l'indirizzo IP interno alla tua rete domestica o dell'ufficio. Perché Nextcloud sia accessibile dall'esterno - dal tuo smartphone, ad esempio - hai bisogno di sottoscrivere un servizio DDNS.

La maggior parte delle utenze internet "normali", infatti, non ha un IP pubblico statico bensì uno variabile, per cui eventuali server che uno avesse in casa o in ufficio non sono raggiungibili, proprio a causa della continua variazione di quella stringa numerica. Il servizio DDNS associa invece all'indirizzo pubblico di casa vostra un nome di dominio , quindi se digitate il vostro URL raggiungete il vostro router: ad ogni variazione il servizio DDNS abbina il nome di dominio al vostro nuovo IP pubblico.<br />
NOTA BENE: non confondere IP pubblico e IP locale. Sono entrambi stringhe numeriche, ma il primo è visibile da fuori, è gestito dall'operatore e punta al tuo router; il secondo è visibile solo all'interno della tua LAN, può indicare qualunque device collegato al router ed è modificabile da te (unica eccezione l'IP interno del router - di solito 192.168.1.1 o 192.168.0.1 - che ci permette di collegare ad esso i dispositivi della nostra rete locale e non è modificabile).

Ma come si raggiunge, poi, il server all'interno della rete domestica o dell'ufficio? Basta inserire l'apposita informazione nel pannello di configurazione del router stesso.

Ci sono tanti servizi DDNS gratis o a pagamento (dyndns.it, duckdns.org, ovh.com...). Personalmente propendo per un servizio a pagamento, perché i costi sono irrisori e perché salvo eccezioni vale sempre il principio secondo cui "se è gratis il prodotto sei tu". Quando sottoscrivi il servizio, ottieni:

* nome utente;
* password;
* sottodominio personale (per esempio, se il sito del  servizio è ilmioddns.com puoi scegliere il sottodominio di terzo livello xyz, se nessuno lo ha già preso. Il tuo indirizzo completo sarà allora xyz.ilmioddns.com).

Una volta ottenute le credenziali DDNS apri il browser, digita l'IP del router e accedi al pannello di amministrazione. Cerca la sezione *WAN Services* / *Port mapping* e vai alla sottosezione *Ipv4 Port forwarding table*. Lì devi aggiungere due regole per la porta delle connessioni cifrate 443, cliccando ogni volta il pulsante *Aggiungi* / *Add new* (il nome qui sotto è di fantasia,  l'IP dell'esempio andrà sostituito col tuo):<br />
`nome: ilmioraspberry - Protocollo: TCP - Porta: http (443) - IP 192.168.1.007`<br />
`nome: ilmioraspberry - Protocollo: UDP - Porta: http (443) - IP 192.168.1.007`<br />

Poi vai nella sezione *DNS & DynDNS* e, qualunque sia il tuo router, effettua le operazioni seguenti (interfaccia e denominazioni possono variare ma il "succo" è quello):

* clicca il pulsante "Attiva";
* Seleziona nell'elenco dei servizi preinstallati il nome del tuo (ad esempio ilmioddns.com);
* clicca il pulsante "https on";
* riempi il campo "Domain" (ad esempio con xyz.ilmioddns.com);
* inserisci la username del servizio sottoscritto;
* inserisci la password.

Ecco fatto. Ora prendi il cellulare, scollegalo dal wifi di casa, apri il browser e digita xyz.ilmioddns.com: l'indirizzo inserito punterà al tuo router, e quest'ultimo al Raspberry. In breve, si aprirà la pagina del tuo server Nextcloud.

**6. installare un certificato SSL per Nextcloud**

Ora accedi al tuo Nextcloud anche da fuori, ma c'è un problema: se leggi la barra degli indirizzi, prima del tuo URL c'è "http", non "https". In altre parole, la connessione non è sicura e quando effettui il login mandi la tua password in chiaro. Per ovviare a questa vulnerabilità devi installare un certificato SSL. Come? Ci sono tre modi:

1. crei il tuo certificato autofirmato, con `openssl`;
2. installi un certificato gratis, per esempio da [Let's encrypt](https://letsencrypt.org/);
3. compri un certificato e lo installi.

Se hai sottoscritto un servizio DDNS a pagamento, è probabile che la stessa azienda venda anche certificati SSL. Se poi è un'azienda grossa, come dyndns ad esempio, è probabile che il suo dominio sia già nell'elenco dei domini preconfigurati nel router (v. poco sopra, quando si parlava della sezione *DNS & DynDNS*). In breve, visto che ci sono sin troppe variabili in gioco, meglio optare per servizi in qualche già riconosciuti dall'insieme dei dispositivi. Ecco perché ora ci soffermeremo solo sull'opzione 3: compri un certificato e lo installi.

Una volta acquistato il certificato, devi ricevere tre documenti: uno che finisce con .pem, uno con .crt e uno con .key (questo è il più prezioso, la chiave privata). Per trasferirli sul Raspberry puoi usare scp, come spiegato in un nostro [precedente articolo](/scaricare-un-file-remoto-con-scp-da-terminale). In concreto, se ad esempio l'utente Mario ha un computer nel quale si trovano i certificati SSL appena acquistati, e nel quale è aperto un terminale collegato al Raspberry, dovrà digitare il comando seguente:

`sudo scp mario@192.168.1.92:/home/mario/Documenti/xyz.ilmioddns.com.key  /etc/ssl/private`
 
Spiegazione:

* `scp` è il comando ssh che permette di trasferire il file dal computer di Mario al Raspberry;
* `mario@192.168.1.92` è il nome utente + l'indirizzo IP del computer di Mario, da cui va prelevato il file;
* `:/home/mario/Documenti/xyz.ilmioddns.com.key` è il percorso assoluto nel computer di Mario, indica dove si trova il file;
* `xyz.ilmioddns.com.key` è il nome del file
* `/etc/ssl/private` è la cartella del Raspberry in cui va messo il file prelevato. Questo è l'unica parte del comando che non devi variare, tutto il resto (nome utente, IP, posizione e nome del file) va modificato in base alla tua situazione specifica.

Dopo aver copiato sul Raspberry la chiave privata devi importare anche gli altri due file con i comandi seguenti (la cartella di destinazione non è più *private* ma *certs*):
```
sudo scp mario@192.168.1.92:/home/mario/Documenti/xyz.ilmioddns.com.pem  /etc/ssl/certs
sudo scp mario@192.168.1.92:/home/mario/Documenti/xyz.ilmioddns.com.crt  /etc/ssl/certs
```
Fatto questo, devi creare nel server web Apache un file corrispondente all'indirizzo "esterno" di Nextcloud, che nel nostro esempio è xyz.ilmioddns.com...
```
sudo nano /etc/apache2/sites-available/xyz.ilmioddns.com
```
... e copia-incollare il testo seguente (ricordati di mettere a riga 4 il tuo vero indirizzo):
```
<VirtualHost *:443>
     ServerAdmin admin@example.com
     DocumentRoot /var/www/html/nextcloud
     ServerName xyz.ilmioddns.com  
     ErrorLog /var/log/apache2/nextcloud-error.log
     CustomLog /var/log/apache2/nextcloud-access.log combined

    <IfModule mod_headers.c>
      Header always set Strict-Transport-Security "max-age=15552000; includeSubDomains"
    </IfModule>

    <Directory /var/www/html/nextcloud>
        Options +FollowSymlinks
        AllowOverride All
        Require all granted
        SetEnv HOME /var/www/html/nextcloud
        SetEnv HTTP_HOME /var/www/html/nextcloud
        <IfModule mod_dav.c>
          Dav off
        </IfModule>
    </Directory>
</VirtualHost>
```
Poi salva il file in modo che venga creato. Dopodiché devi 

* Attivare la direttiva ServerName di Apache, onde evitare il messaggio di errore *Could not reliably determine the server's fully qualified domain name*. A tal fine:
  - [ ] `sudo nano /etc/apache2/apache2.conf `per aprire il file di configurazione generale di Apache;
  - [ ] alla fine del file aggiungi `ServerName xyz.ilmioddns.com.key` e poi salva.
* Attivare il nuovo dominio in Apache: `sudo a2ensite` poi `sudo systemctl reload apache2`;
* Segnalare il nuovo dominio a Nextcloud, aprendo con `sudo nano` il file */var/www/html/nextcloud/config/config.php* e modificando come segue la voce *trusted domains* (ovviamente dovrai sostituire con i tuoi dati l'IP e l'URL indicati in questo esempio):
```
  'trusted_domains' => 
  array (
    0 => '192.168.1.007',
    1 => 'xyz.ilmioddns.com',
    2 => 'https;//xyz.ilmioddns.com',
  ),
```
Per concludere il tutto devi validare i certificati appena importati sul Raspberry. Per questo puoi usare il programma Certbot:

* `sudo apt install python3-certbot-apache -y`per installare il programma;
* `sudo certbot --apache -d xyz.ilmioddns.com` per validare il tutto.

Ecco fatto. A questo punto, se tutto è andato a buon fine, ti basta aprire il browser e digitare xyz.ilmioddns.com nella barra degli indirizzi: apparirà la pagina blu di Nextcloud, e accanto all'URL il navigatore ti mostrerà l'icona del lucchetto. Ora puoi collegarti dall'esterno in modo sicuro.

**7. ospitare i dati su un hard disk esterno collegato a Raspberry**

Ora hai la  tua installazione Nextcloud completa, sicura e funzionante. Ma è tutta sulla scheda SSD, che al massimo può avere qualche decina di Giga. Che fare se hai bisogno di più spazio per i tuoi file? Puoi collegare al Raspberry un hard disk esterno, magari cifrato, e trasferivi tutti i file e le cartelle che normalmente si trovano nella cartella utente del server Nextcloud, ossia in /var/www/html/nextcloud/data. Ora vediamo come fare.

Bisogna innanzitutto preparare l'hard disk. Per sapere "come si chiama" collegalo a Raspberry e nel terminale aperto sul computerino digita `lsblk`: vedrai il Raspberry e l'HD esterno. Supponiamo che quest'ultimo appaia come /dev/sda. 

Ora devi creare la partizione /dev/sda1 e cifrarla: 

* per il partizionamento digita `sudo fdisk /dev/sda` poi premi il tasto "g" (=*GPT partition table*), quindi "n" (=*new partition*) seguito da "p" (=*primary*), ed infine INVIO in risposta alle due domande successive sui settori di inizio e fine. Conclusa l'operazione digita "w" (=*write*) per scrivere la partizione sul disco e chiudere il programma.
* per la cifratura installa Cryptsetup (`sudo apt install cryptsetup`) e poi digita `sudo cryptsetup --verbose --verify-passphrase luksFormat /dev/sda1`. Ti verrà chiesto conferma: scrivi YES tutto in maiuscole. E dovrai inserire una passphrase (per sapere come crearne una leggi [questo articolo](/crea-la-tua-passphrase-con-il-metodo-surrealista): mi raccomando annotala da qualche parte!).

Ora però sorge un problema: come faccio a digitare la passpphrase dell'hard disk che mi viene chiesta all'avvio, se non posso collegarmi al Raspberry  prima che sia completamente avviato? La passphrase deve trovarla lui da solo in un apposito *keyfile*. Ecco dunque la sequenza completa presa da [qui](https://www.howtoforge.com/automatically-unlock-luks-encrypted-drives-with-a-keyfile) e verificata di persona:

* `sudo dd if=/dev/urandom of=/root/keyfile bs=1024 count=4` per creare il file nella cartella root del Raspberry;
* `sudo chmod 0400 /root/keyfile` perché il file sia leggibile solo dall'amministratore;
* `sudo cryptsetup luksAddKey /dev/sda1 /root/keyfile` per aggiungere il file a LUKS, il sistema di gestione delle partizioni cifrate;
* `lsblk -dno UUID /dev/sda1` per conoscere l'UUID di /dev/sda1. L'UUID è il "codice fiscale" del vostro hard disk esterno, una stringa alfanumerica come questa: 69867f29-a99e-1dr2-8te6-j33afb582829;
* `sudo nano /etc/crypttab` per aprire l'elenco delle partizioni cifrate avviabili al boot. In questo file devi aggiungere la riga `sda1_crypt      UUID="69867f29-a99e-1dr2-8te6-j33afb582829"  /root/keyfile  luks` (sostituisci l'UUID dell'esempio col tuo, cercandolo come spiegato sopra);
* `sudo nano /etc/fstab` per aprire l'elenco della partizioni che devono essere avviate al boot. In questo file devi aggiungere la riga `/dev/mapper/sda1_crypt  /nextclouddata     ext4    defaults        0       2`. Nextclouddata che dovrà sostituire la cartella di default per i dati degli utenti, ossia /var/www/html/nextcloud/data;
* `sudo mkdir /nextclouddata` per creare la cartella dati, poi `sudo chown -R www-data:www-data /nextclouddata` per attrbuirle il giusto proprietario.

Bene, è giunta l'ora di trasferire il contenuto di /var/www/html/nextcloud/data:

* `sudo cryptsetup luksOpen /dev/sda1 sda1_crypt` per sbloccare l'hard disk esterno. Ti verrà chiesto la passphrase che hai sceglto quando l'hai cifrato;
* `sudo mount /dev/mapper/sda1_crypt /nextclouddata` per montare l'hard disk;
* `sudo cp /var/www/html/nextcloud/data/* /nexclouddata` per copiare file e cartelle. 
* verifica (sudo ls -al /nextclouddata) che siano stati copiati anche i file nascosti *.htaccess* e *.ocdata*, se no copiali  (`sudo cp /var/www/html/nextcloud/data/.htaccess /nexclouddata` e `sudo cp /var/www/html/nextcloud/data/.ocdata /nexclouddata`);
* `sudo chown -R www-data:www-data /nextclouddata` per attribuire il proprietario corretto a tutti i file della cartella;
* `sudo cp /var/www/html/nextcloud/config/config.php /var/www/html/nextcloud/config/config.php-BAK` per creare una copia di backup del file di configurazione di Nextcloud;
* `sudo nano /var/www/html/nextcloud/config/config.php` per indicare nel file configurazione dove si trovano le cartelle utente. A tal fine dovrai sostituire la riga in cui è scritto *'datadirectory' => '/var/www/html/data/',* con la seguente: `'datadirectory' => '/nextclouddata',` e  salvare il tutto.

Ora abbiamo finito. Riavvia il Raspberry: se tutto va bene /nextclouddata sarà montato/sbloccato automaticamente e verrà usato da Nextcloud. Digita eventualmente `sudo cat /etc/mtab`: se trovi la riga */dev/mapper/sda1_crypt /nextclouddata ...* vuol dire che l'hard disk esterno è correttamente montato.

Non ti rimane, a questo punto, che da configurare il client sui vari pc che vuoi sincronizzare col server Nextcloud su Raspberry. Ma questo sono sicuro che saprai farlo da solo. 

