---
Title: Ferma l'avvio di console log in OpenBSD
Published: 2024-05-22 15:24:36
Author: yellowadmin
Layout: blog
Tag: OpenBSD
---
Quando effettui il *login* grafico in OpenBSD si apre sempre una terminale che riporta i log. Se vuoi evitare che appaia questa finestra devi modificare (come utente root) */etc/X11/xenodm/Xsetup_0* anteponendo  `#` alla relativa riga:

```
${exec_prefix}/bin/xconsole -geometry 480x130-0-0 -daemon -notify -verbose -fn fixed -exitOnFail
```

deve diventare

```
# ${exec_prefix}/bin/xconsole -geometry 480x130-0-0 -daemon -notify -verbose -fn fixed -exitOnFail
```


In questo modo al prossimo *login* la console di log non si aprirà.


