---
Title: Buone prassi per usare Tails
Published: 2022-09-15 14:54:18
Author: Writer
Layout: blog
Tag: privacy, censura, sicurezza
---
[Tails](https://tails.boum.org/) è una distribuzione live, cioè avviabile da chiavetta, utilizzata da *whistleblowers* e da giornalisti o attivisti che devono mandare informazioni censurate dai regimi: ovviamente penserete all'Iran, ma con questo termine possiamo riferirci pure all'Italia degli ultimi due anni, in cui si bastonano portuali inginocchiati col rosario. Comunicare in sicurezza, oggi, è un problema che riguarda tutti i cittadini occidentali, motivo per cui tutti noi possiamo considerare uno strumento interessante questo sistema operativo adoperato da Snowden. Tuttavia, usare Tails come una normale distribuzione Linux è come sperare nelle virtù contraccettive di un preservativo bucato: occorrono, per essere protetti, alcune precauzioni. Ecco dunque cinque regole di comportamento per usare in modo efficace la vostra chiavetta.<br />
[--more--]

1) UNA SESSIONE – UN PROGRAMMA<br />
Quando siete connessi a internet usate un solo programma web (navigazione, posta, chat) alla volta. Se volete usarne un altro dovete riavviare il sistema.
Ad esempio, se usate Pidgin per messaggiare e volete consultare la posta con Thunderbird, ecco la sequenza giusta:

* chiudete Pidgin;
* riavviate Tails;
* collegatevi a internet;
* avviate il programma di posta Thunderbird.

La stessa procedura va seguita se dopo aver usato la posta volete navigare sul web usando Tor browser, e in ogni altro caso analogo.

2) UNA SESSIONE – UN ACCESSO<br />
Quando navigate con Tor browser, può accadere che dobbiate collegarvi a un vostro account da qualche parte: ad esempio per comprare qualcosa, o per accedere all’area utenti di un sito. L’importante è che, se dovete effettuare più login su siti web, riavviate ogni volta Tails.

3) SOLO FILE PULITI<br />
I file sono pieni di metadati, cioè dati relativi alla posizione gps, alla data e al programma utilizzati, ecc. Se dovete trasmettere un file da Tails, per posta elettronica con Thunderbird o chattando con Pidgin, dovete prima ripulirlo da tutti i metadati. Per questo c’è un programma apposito: Mat2.

4) SOLO EMAIL CRIPTATE<br />
Le email sono in realtà come le cartoline: chiunque può leggerne il contenuto, nel tragitto dal mittente al destinatario. Il rimedio è solo uno: o rinunciate alle email e usate solo Pidgin, il programma di chat criptate, o cifrate con GPG le email che spedite con Thunderbird.

5) USA IL PROGRAMMA GIUSTO<br />
L’uso improprio di un programma comporta rischi per la sicurezza. Quindi impara a usare il programma corretto per ogni operazione:

* Per chattare usa Pidgin, meglio con protocollo XMPP e server onion;
* Per le email usa Thunderbird, cifrando sempre le tue email con GPG;
* Per ripulire i file da condividere usa Mat2;
* Per condividere file usa OnionShare.
