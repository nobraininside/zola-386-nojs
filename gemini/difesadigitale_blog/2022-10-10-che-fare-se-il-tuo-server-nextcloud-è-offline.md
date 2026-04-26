---
Title: Che fare se il tuo server Nextcloud è offline
Published: 2022-10-10 10:26:01
Author: Writer
Layout: blog
Tag: nextcloud,tips
---
Può accadere che per mille motivi il tuo server Nextcloud diventi irraggiungibile: la sincronizzazione del client si interrompe (appare il warning "Non in linea"), l'interfaccia web mostra un bella pagina bianca... A questo punto puoi riavviare fisicamente il server, sempre che sia a portata di mano, oppure collegarti con ssh: l'operazione, in questo caso, è ben più semplice e veloce.<br />
[--more--]

Questo problema, di solito, accade nei server fai-da-te. Se la tua installazione Nextcloud è presso un provider esterno, raggiungibile con nome di dominio, il problema normalmente sarà gestito dai tecnici in loco senza che te ne accorga. Per questo motivo le istruzioni seguenti si focalizzeranno solo sui server di casa/ufficio.

Per collegarti dunque al tuo server Nextcloud come root devi digitare:
```
ssh root@DESTINAZIONE
```
Ad esempio, se il server della tua rete locale è all'indirizzo 192.168.1.33 scrivi e invia:
```
ssh root@192.168.1.33
```
Dopodiché basterà riavviare il server http, redis e php usando, se Nextcloud è in ambiente OpenBSD, i comandi (come root o premettendo `doas`):

* `rcctl restart httpd`;
* `rcctl restart redis`;
* `rcctl restart php80_fpm`.

NOTA: per sapere qual è la versione giusta di php da avviare digita `ls -al /usr/local/bin` e guarda dove punta il link php. Per esempio se leggi `php -> /usr/local/bin/php-8.0` per riavviare php scrivi `rcctl restart php80_fpm` (come vedi, va tolto il punto fra i due numeri della versione, in questo caso fra l'8 e lo 0).

Se invece il tuo Nextcloud è su Linux, digita (come root o premettendo `sudo`):

* `systemctl restart httpd.service`;
* `systemctl restart redis-server.service`;
*  `systemctl restart php-fpm.service`.

Dopodiché tutto tornerà a funzionare come si deve.

POST SCRIPTUM: se dopo il riavvio il tuo server funziona qualche minuto poi "salta" di nuovo, indicizza di nuovo tutti i file e le cartelle della tua installazione Nextcloud col comando OpenBSD `doas -u www php occ files:scan --unscanned --all` o in Linux `sudo -u www-data php occ files:scan --unscanned --all`, come spiegato dettagliatamente [qui](https://difesadigitale.blog/file-non-cancellabili-in-nexcloud-che-fare). 
