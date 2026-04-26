---
Title: Installare sshpass, gnupg e pinentry su macOS, openBSD e linux
Published: 2023-01-17 11:25:58
Author: yellowadmin
Layout: blog
Tag: terminale, openbsd
---
Da terminale ci capita di avviare regolarmente programmi che richiedono una password. Per non digitarla ogni volta - cosa fastidiosa, soprattutto se è complessa - né tantomeno doverla salvare in chiaro, si può creare uno script basato su tre comandi: *sshpass*, *gnupg* e *pinentry*. Vediamo ora come si installano i tre programmi. In un altro articolo spiegherò poi lo script.
[--more--]<br />

**1) macos**

* apri un terminale
* devi innanzitutto installare homebrew. A tal fine digita `xcode-select --install`
* poi scarica il programma con 
```
curl -O https://raw.githubusercontent.com/Homebrew/install/master/install.sh
```
* rendi eseguibile il file scaricato con `chmod +x install.sh` 
* avvia l'installatore di *homebrew* con `./install.sh`
* verifica se vuoi la versione di sshpass resa disponibile da homebrew (xcode-select) digitando  `brew info sshpass`
* installa *sshpass* con `brew install sshpass` (se ottieni un messaggio di errore prova con `brew tap esolitos/ipa` e poi `brew install esolitos/ipa/sshpass`)
* installa *gnupg* con `brew install gnupg`
* installa *pinentry* con `brew install pinentry`

**2) openbsd**

* da terminale, come root, digita `pkg_add password-store pinentry gnupg`

**3) linux** (Debian)

* da terminale, come root (o come utente normale, premettendo *sudo*), digita `apt install password-store pinentry gnupg`

Ecco, ora hai tutto quanto occorre per usare pass. Per capire come configurarlo, leggi [questo articolo](configurare-pass-il-comodissimo-password-manager-da-terminale).

