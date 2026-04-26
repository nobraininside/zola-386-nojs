---
Title: Come installare il CMS WordPress-Lite di Bedrock
Published: 2024-05-26 11:00:32
Author: yellowadmin
Layout: blog
Tag: CMS, wordpress
---
In meccanica vige una legge: ciò che non c'è non si rompe. Questo vale per gli aerei, i grattacieli, ma anche in ambito informatico. E invece Wordpress, il CMS più diffuso al mondo, sembra talvolta un parto dell'UCAS (Ufficio Complicazione Affari Semplici): funzioni sempre più complesse si aggiungono per semplificarne la gestione, plugin lo appesantiscono per velocizzarlo, e l'insieme diventa obeso. Di qui l'interesse di "WordPress-Lite", un fork sorprendente di Bedrock che ripensa il CMS alla radice, donando velocità e sicurezza senza chiedere agli utenti di cambiare abitudini. Vediamo dunque come s'installa in un hosting condiviso.
[--more--]<br />

1. Avvia il file manager di cPanel (o equivalente), vai in *public.html* e crea una cartella omonima del tuo sito (ad esempio: ilmiosito.it)

2. Avvia il terminale di cPanel e vai nella cartella appena creata: `cd public_html/ilmiosito.it`

3. Installa composer come spiegato da [https://getcomposer.org/download/](https://getcomposer.org/download/), ossia digitando da terminale:
```
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php -r "if (hash_file('sha384', 'composer-setup.php') === 'dac665fdc30fdd8ec78b38b9800061b4150413ff2e3b6f88543c636f7cd84f6db9189d43a81e5503cda447da73c7e5b6') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
php composer-setup.php
php -r "unlink('composer-setup.php');"
```
4. Installa WordPress Lite come spiegato sulla [pagina di WordPress-Lite](https://github.com/4dboard/WordPress-Lite?tab=readme-ov-file). Per cominciare installa *composer* digitando da terminale, nella cartella ilmiosito.it, `composer create-project roots/bedrock`

5. Col file manager dell'hosting vai in */public_html/ilmiosito.it/bedrock*; sposta tutti i file e cartelle da *bedrock* alla cartella di livello superiore (*ilmiosito.it*)

6. Crea un database con phpMyAdmin o da wizard hosting e annota: nome/utente/pwd del database

7. Col file manager dell'hosting vai in /*public_html/ilmiosito.it/* e crea la copia *.env* di *.env.example*

8. Modifica la prima parte del contenuto di *.env* (da "DB_NAME" a "# WP_DEBUG_LOG") inserendo i dati necessari su database e url del sito. Per esempio (modifica i dati qui sotto prendendo quelli che hai inserito sopra al punto 6):
```
DB_NAME='nome-del_tuo_database'
DB_USER='nome_utente_del_tuo_database'
DB_PASSWORD='password_del_tuo_database'

# Optionally, you can use a data source name (DSN)
# When using a DSN, you can remove the DB_NAME, DB_USER, DB_PASSWORD, and DB_HOST variables
# DATABASE_URL='mysql://database_user:database_password@database_host:database_port/database_name'
# Optional database variables
DB_HOST='localhost'
# per più sicurezza qui sotto scegli un prefisso seguito da undescore, ad esempio fi3_)
DB_PREFIX='wp_'

# qui sotto scegli fra development (per modificare il sito aggiungendo plugin e temi), 
# staging o production (per usare normale del sito: scrivere pagine e post, ecc...).
# Questo valore può esssere modificato secondo necessità.
WP_ENV='staging'
WP_HOME='https://ilmiosito.it'
# WP_SITEURL="${WP_HOME}/wp"
```
9. Cancella il contenuto della seconda parte di *.env* (da "# Generate your keys" alla fine) e poi incolla i codici generati automaticamente su https://roots.io/salts.html alla sezione "env format". Ad esempio:
```
AUTH_KEY='1Svy7wCAJG0LOYmiuh|_K;v)Ef5r_c?EE}LbP:*eehwzWa,^b#osb|0:S=E>;Cfi'
SECURE_AUTH_KEY='Kif+E&]p/ciQ[6[3VUAp6/wZL!f!sLw%+z`Pbo?tegiH^KnvB{JSm}XcBD?,U>18'
LOGGED_IN_KEY='yWw@.J:V050H`#!0f#/poubCKh*RPS7B=FSG+PB!3AMB_nuKfN%{$HrJ.<qa]{no'
NONCE_KEY='oOZ_og4$CpWW[TGH<zhz1L0uisKY<vvO:2$<+ng4q5Cw)GKhoiongkiR2;mv&(C_'
AUTH_SALT='g*OlujnCN*=6O){5gjZ*,%lid#j,$e{>&zTvm}$_,esqUZpBk#t^HvR-w5{R6wp('
SECURE_AUTH_SALT='Y<;2QsgnNOqqykw>7(YtFM>VQ0hPr>ug4v#i>v|?d]s>PI=YPoJNKTS{7e5pTIw]'
LOGGED_IN_SALT='ng^PgqK7N>_2k|@VTo[ZFsS^EUpUuNlhPq9S2L0PX5c(?j5xl0}Zn;?M.g>?#TR['
NONCE_SALT='r9)Z7BhfeU7|>}@bLa29nELb<s$C^n6J@BM-#@9u0ufOGx[nB&04h*c.ID,3)P-j'
```
10. Aggiungi se vuoi un tema in *web/app/themes/* (puoi farlo anche dopo)

11. Crea il file *.htaccess* nella cartella radice (*ilmiosito.it*) e inserisci (come spiegato [qui](https://roots.io/bedrock/docs/server-configuration/#apache-configuration-for-bedrock)):
```
RewriteEngine on

RewriteCond %{REQUEST_URI} !web/
RewriteRule ^(.*)$ /web/$1 [L]
```

12. Accedi all'installatore di WordPress Lite all'URL  https://ilmiosito.it/wp/wp-admin/, inserisci i dati richiesti (ID, PWD e email admin) e clicca invio: il sito ora viene creato e puoi accedere al pannello di amministrazione all'URL: https://ilmiosito.it/wp/wp-admin/

13. Loggati come admin a https://bravoweb.net/wp/wp-login.php e rifinisci il sito a piacimento. Quando avrai finito di configurare il sito, ricorda di modificare *.env* (v. sopra al punto 6) sostituendo *production* a *staging* alla riga WP_ENV. 
