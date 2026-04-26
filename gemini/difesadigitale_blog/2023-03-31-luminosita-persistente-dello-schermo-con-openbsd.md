---
Title: Luminosità persistente dello schermo con OpenBSD
Published: 2023-03-31 17:42:50
Author: yellowadmin
Layout: blog
Tag: openbsd, hardware
---
Se hai installato OpenBSD sul tuo portatile, è probabile che tu debba regolare la luminosità dello schermo ad ogni riavvio. È facile (basta digitare `xbacklight -inc 20`, ad esempio, per aumentarla del 20%), ma se ti dà fastidio ripetere l'operazione ogni volta, ecco un'ottima soluzione, suggerita da [ericweitzel.me](https://ericweitzel.me/2022/april/persistent-display-brightness-on-openbsd-with-rc-and-wsconsctl/):

[--more--]<br />

1. come root, crea il file /etc/rc.shutdown e copia-incolla questo testo:
```
#! /bin/sh
wsconsctl display.brightness | cut -f2 -d= > /var/brightness
```
2. dopo aver salvato, rendi il file eseguibile digitando `chmod +x /etc/rc.shutdown`
3. poi, sempre come root, crea (se non esiste già) il file /etc/rc.local e inserisci:
```
#! /bin/sh
wsconsctl display.brightness=$(cat /var/brightness)
```
4. anche in qui, salva il file e poi rendilo esiguibile con `chmod +x /etc/rc.shutdown`

Ecco fatto: al prossimo avvio il tuo portatile avrà (sin dalla schermata di login xenodm!) la luminosità che avevi regolato nell'ultima sessione. Se non sei soddisfatto di questa luminosità, una volta loggato potrai sempre aumentarla con `xbacklight -inc <valore_numerico>` o diminuirla con `xbacklight -dec <valore_numerico>`: il nuovo settaggio rimarrà anche al riavvio successivo.
