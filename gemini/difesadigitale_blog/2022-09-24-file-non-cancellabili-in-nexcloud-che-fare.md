---
Title: File non cancellabili in Nexcloud: che fare
Published: 2022-09-24 14:19:33
Author: Writer
Layout: blog
Tag: nextcloud
---
Non riesci a cancellare un file dall'interfaccia web di Nextcloud? Se lo cancelli nella cartella locale del tuo pc, il file riappare alla prima sincronizzazione? Il file bloccato appare nell'interfaccia web anche dopo averlo rimosso sul server remoto via ssh? Questa situazione non accade di frequente, ma non si può neanche dire che sia rara: prima o poi accade a tutti gli utenti Nextcloud, ed è meglio sapere come si risolve.<br />
[--more--]
Innanzitutto precisiamo: le operazioni che indicheremo in questo articolo vanno effettuate lato server, non lato client. In altre parole, quando parleremo di Nextcloud non ci riferiremo al programma che serve a sinconizzare i file del tuo computer col server remoto, ma con il programma che gestisce l'intero *ambaradàn* - stoccaggio, versioni file, ecc.. - dal cloud remoto.
Per poter effettuare quanto richiesto dovrai essere in grado di accedere al server remoto ed eseguire il comando `sudo` (*super user do*) se ha un sistema operativo Linux, o `doas` se invece è basato su OpenBSD.

Una volta collegato, vai alla cartella radice Nextcloud:
```
cd /var/www/nextcloud
```
Poi se il server è Linux  esegui:
```
sudo -u www-data php occ files:scan --unscanned --all
```
Se invece il server è OpenBSD esegui:
```
doas -u www php occ files:scan --unscanned --all
```
Spiegazione: 

* `sudo`/`doas` ti consente di assumere l'identità dell'amministratore di Nextcloud, che non è root ma l'utente www-data o www, secondo il sistema operativo;
* `--unscanned` limita la scannerizzazione ai file che non lo sono stati prima (utile se devi ripetere l'operazione più volte o si vuoi concentrarti solo su nuovi file e cartelle);
* `php occ files:scan` ti permette di ri-indicizzare i file, correggendo l'anomalia del file che risultava non cancellato  né cancellabile;
* `--all` indica che tutti i file e cartelle presenti verranno scannerizzati. 

L'operazione può essere piuttosto lunga, soprattutto se hai tanti giga di cartelle/file. Se sai dov'è il file non cancellabile e vuoi indicizzare solo la cartella in cui si trova, puoi limitare ad essa la scannerizzazione, riducendo di molto i tempi. In questo caso invece di `--all` dovrai mettere `--path="username/files/path_cartella_da_scannerizzare"`. Per cui sotto Linux il comando completo sarà:
```
sudo -u www-data php occ files:scan --unscanned --path="username/files/path_cartella_da_scannerizzare"
```
Mentre per OpenBSD dovrai digitare:
```
doas -u www php occ files:scan --unscanned --path="username/files/path_cartella_da_scannerizzare"
```
Ovviamente, al posto di *username* devi inserire il nome utente del titolare della cartella, e invece di *path_cartella_da_scannerizzare* devi indicare il percorso relativo alla cartella in cui si trova il file problematico. Il percorso in questione inizia da /var/www/nextcloud/data/username/files, quindi, se ad esempio devi scannerizzare la sottocartella *foto_vacanze* della cartella *Documenti* dell'utente Mario in un server Linux il comando sarà:
```
sudo -u www-data php occ files:scan --unscanned --path="Mario/files/Documenti/foto_vacanze"
```
Come avrai notato, il path inizia sempre con lo username del proprietario dei file (in questo caso Mario) e contiene sempre, dopo lo nome, la cartella /files/ seguita dalle cartelle Nextcloud dell'utente indicato.
