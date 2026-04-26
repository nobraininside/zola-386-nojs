---
Title: Upgrade di OpenBSD
Published: 2023-04-15 15:38:19
Author: yellowadmin
Layout: blog
Tag: openbsd
---
Questa è un piccolo promemoria su come aggiornare OpenBSD. I comandi vanno eseguiti come root, o premettendo *doas* (l'equivalente bsd di *sudo*) se si interviene come utente semplice:

1. `uname -r` per verificare la versione attualmente installata;
2. `sysupgrade` per aggiornare;
3. riavviare il sistema;
4. `pkg_add -Uu` per aggiornare tutti i programmi installati;
5. `sysmerge -d` per aggiornare i file di configurazione.

Fine
