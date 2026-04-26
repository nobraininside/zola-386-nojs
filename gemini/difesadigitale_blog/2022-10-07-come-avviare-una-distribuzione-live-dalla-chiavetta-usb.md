---
Title: Come avviare una distribuzione live dalla chiavetta usb
Published: 2022-10-07 14:16:23
Author: Writer
Layout: blog
Tag: live
---
Ok, hai una chiavetta con una distribuzione live, *Tails*, *Ubuntu*, qualunque essa sia. Sei davanti a un computer spento, inserisci la *pendrive*, avvii... e non succede nulla: ti appare la solita schermata con la mela o con la bandierina del filantropo.  E adesso che si fa? Ecco qualche suggerimento per avviare da usb un sistema operativo alternativo.<br />
[--more--]<br />
**Se hai un Mac**:

1. premi il pulsante di AVVIO;
2. tieni premuto il pulsante ALT sinistro (detto anche Opzione) fino a quando appare una schermata con delle icone (l'attesa può durare anche 30-60 secondi);
3. clicca l'icona intitolata WINDOWS o EFI BOOT;
4. quando appare la schermata del *bootloader* (probabilmente *Grub*) col nome del tuo sistema operativo live, premi INVIO oppure aspetta e partirà da solo. Se l'operazione non ti porta al login dopo un minuto o due e pare bloccata, spegni e ripeti daccapo, ma alla schermata del bootloader scegli l'opzione *External Hard Disk* e premi INVIO (questa operazione è possibile con *Tails* e alcune altre distribuzioni, e può esser necessaria quando usi una chiavetta troppo grande o un disco rigito SSD);
5. fatto: hai avviato la tua distribuzione live.

**Se hai un pc**:

1. premi il pulsante di AVVIO e aspetta che parta la distribuzione live della chiavetta. Se invece parte Windows, riavvia e segui le istruzioni qui sotto;
2. premi ripetutamente uno di questi pulsanti fino quando appare una schermata con varie  opzioni: F2, F7, F9, F10, F11, F12 oppure ESC;
3. quando la schermata del BIOS (di solito con testo bianco su sfondo blu) muoviti con le frecce fino all'opzione USB o "Removable Device" e seleziona premendo INVIO. Se non appare questa schermata apparirà direttamente la successiva col *bootloader*... o l'icona Windows (in questo caso hai premuto il tasto ESC o  F... sbagliato e devi riprovare fino a quando trovi quello giusto;
4. quando appare la schermata del *bootloader*  (probabilmente *Grub*) col nome del tuo sistema operativo live, premi INVIO oppure aspetta e partirà da solo. Se l'operazione non ti porta al login dopo un minuto o due e pare bloccata, spegni e ripeti daccapo, ma alla schermata del bootloader scegli l'opzione *External Hard Disk* e premi INVIO (questa operazione è possibile con *Tails* e alcune altre distribuzioni, e può esser necessaria quando usi una chiavetta troppo grande o un disco rigito SSD);
5. fatto: hai avviato la tua distribuzione live.

**Come capire qual è il tasto giusto da premere all'avvio**

Questa tabella ti potrà forse aiutare. Se hai un Mac è semplice, è sempre ALT, ma se usi un personal computer con OS Windows ci sono varie possibilità, a seconda del produttore:

* Acer	F12, F9, F2, Esc
* Apple	ALT (Opzione)
* Asus	Esc
* Clevo	F7
* Dell	F12
* Fujitsu	F12, Esc
* HP	F9
* Huawei	F12
* Intel	F10
* Lenovo	F12
* MSI	F11
* Samsung	Esc, F12, F2
* Sony	F11, Esc, F10
* Toshiba	F12
* altro…	F12, Esc

**Troubleshooting**

Se malgrado tutto la tua live su chiavetta non parte, il problema può essere la chiavetta stessa (difettosa), o la clonazione del sistema live (malriuscita: prova a copiare di nuovo ma usando il comando `dd`, come spiegato [qui](/copiare-una-chiavetta-con-dd-da-terminale)) o la configurazione del tuo computer. In questo caso, se hai un Mac:

- [ ] riavvia;
- [ ] quando appare il logo Apple: premi cmd+R: partirà il *macOS Recovery*;
- [ ] vai a *Utilities* e poi a *Startup Recovery Utility*;
- [ ] autenticati come utente con diritti di amministratore;
- [ ] spunta le caselle *No Security* e *Allow booting from external media*
- [ ] riavvia e segui la procedura indicata sopra per avviare la tua chiavetta.

Se invece non riesci ad avviare la chiavetta dal tuo pc Windows:

- [ ] riavvia premendo ripetutamente uno dei tasti (ESC, F2, F7...) illustrati prima;
- [ ] quando appare la schermata del BIOS muoviti con le frecce fino a SETUP e premi invio;
- [ ] seleziona, muovendoti con le frecce, BOOT ORDER e poi seleziona USB o Removable Device: spostalo in cima alla lista delle periferiche da avviare;
- [ ] salva ed esci, usando i tasti suggeriti nel BIOS;
- [ ] riavvia e segui la procedura indicata sopra per avviare la tua chiavetta.

Per approfondire leggi la documentazione [Tails](https://tails.boum.org/doc/first_steps/start/),  da cui sono tratti in parte questi appunti.

