---
Title: Installa Windows su Hard Disk esterno grazie a Mac
Published: 2024-05-11 11:06:08
Author: yellowadmin
Layout: blog
Tag: windows, macos, terminale
---
Se hai un Mac puoi installare Windows 10 o 11 su un HD o SDD esterno seguendo passo passo queste istruzioni. Una volta conclusa l'installazione potrai scegliere all'avvio del tuo Mac se usare il sistema operativo di Cupertino o quello di Redmond. Personalmente non raccomando nessuno dei due SO (e infatti uso un iMac con OpenBSD), ma per lavoro o per mille altri motivi uno può averne comunque bisogno...<br />
Importante: devi avere una chiavetta USB da almeno 8 Giga e un HD esterno da almeno 100 Giga.
[--more--]<br />

**Predisponi tutto dal tuo Mac**

1. Scarica il file ISO di [Windows 10](https://www.microsoft.com/it-it/software-download/windows10ISO) o [Windows 11](https://www.microsoft.com/software-download/windows11) dal sito Microsoft.

2. Collega la chiavetta USB al Mac e avvia l'*Assistente Boot Camp* (se non lo trovi clicca il *Launchpad* - l'icona con il missile in basso a sinistra - nella barra della applicazioni > *Altro* > *Assistente Boot Camp*).

3. A questo punto la maggior parte dei tutorial online dice di cliccare *Azione* > *Scarica software di supporto per Windows* e scegliere la chiavetta USB come destinazione ma quando ho provato a fare così alla fine della fiera mancava sempre qualche file. <br /><br />
Se vuoi essere invece sicuro che la chiavetta abbia tutto il necessario per installare Windows sull'HD, devi "ingannare" Boot Camp e fingere di voler installare il sistema operativo sulla chiavetta stessa. Per questo: <br />
a) nella finestra "Introduzione" di Boot Camp *clic Continua* <br />
b) nella finestra  "Seleziona attività" *lascia le tre spunte* + *clic Continua* <br />
c) nella finestra "Crea un'unità USB..."  *seleziona il file ISO di Windows scaricato in precedenza* + *seleziona la chiavetta USB* + *clic Continua* <br />
d) quando appare la finestra "Crea una partizione per Windows"  chiudila. Poi apri *Finder*, il file manager di MacOS, e controlla se nella chiavetta USB ci sono tutti i file e le cartelle necessari, che sono questi:

* autorun.inf
* AutoUnattend.xml
* boot/
* BootCamp/
* bootmgr
* bootmgr.efi
* efi/
* setup.exe
* sources/
* support/
* $WinPEDriver$/



**Avvia il Mac dalla chiavetta USB**

Nota: la maggior parte delle istruzioni è tratta da un [ottimo articolo su medium.com](https://medium.com/macoclock/how-to-install-windows-10-on-an-external-drive-on-a-mac-f02b1beda8c8)

4. Spegni il computer e poi riavvialo tenendo premuto il tasto ALT fino a quando appare una schermata in cui vedrai due icone: una per l'Hard Disk di MacOS e una per la chiavetta USB, intitolata EFI BOOT. Se vedi solo MacOS, stacca e ricollega la chiavetta, che a questo punto dovrebbe apparire. Seleziona quindi l'icona EFI, cioè la chiavetta USB.

5. Dopo un po' apparirà il simbolo di Windows, poi la scritta *Avvio del programma di installazione* e infine la finestra *Installazione di Windows*: non toccarla e premi invece i tasti *SHIFT*+*F10* (o *SHIFT*+*Fn*+*F10* se hai un portatile). Apparirà un terminale.

6. Nel terminale digita `DISKPART`, poi `LIST DISK` e individua il numero dell'HD o SDD esterno su cui vuoi installare Windows. Il comando elenca infatti, nella sequenza *0*, *1*, *2*, ecc la sequenza del dischi disponibili. Riconoscerai il tuo in base alla dimensione. Ad esempio, se vedi che *0* corrisponde a un disco di 500 Giga, *1* a un disco di 8 Giga, *2* a un disco da 1.000 Giga e sai che il tuo HD esterno è di un Terabyte mentre l'Hard Disk del tuo Mac è di 500 Giga, il numero del disco che ti interessa è 2.

7. Digita `SELECT DISK 2` per iniziare a predisporre il tuo HD/SDD esterno e poi`CLEAN` per ripulirlo.

8. Digita `CREATE PARTITION PRIMARY SIZE=900000` per creare la partizione destinata ad accogliere Windows. Il numero deve corrispondere allo spazio che vuoi allocare a Windows, e che dev'essere uguale o inferiore alla capienza dell'HD/SDD esterno. Tieni conto che 100000 (centomila) bytes equivalgono a un Giga, quindi se hai un HD/SDD da 250 Giga devi scrivere, alla fine del comando `SIZE=250000`... o meno.

9. Digita `ASSIGN LETTER W` e poi `FORMAT QUICK FS=NTFS` per formattare il tuo HD esterno.

10.Digita `LIST VOLUME` e individua nell'elenco che apparirà il numero della partizione di UEFI: è la partizine di avvio del tuo HD/SDD esterno ed è facile da riconoscere, perché è l'unica contraddistinta da *Hidden* o  *Nascosto* nell'ultima colonna (*Info*). Nel mio caso - e nel comando qui sotto -  il numero di *Volume* della partizione è 4.

11. Digita `SELECT VOLUME 4` per selezionare la partizione UEFI del tuo HD/SDD esterno. Al posto del n° 4 inserisci il numero che ha trovato digitando LIST VOLUME, come spiegato appena sopra.

12. Digita `ASSIGN LETTER=Z` per assegnare la Z (cioè rendere riconoscibile in base a questa lettera) la partizione UEFI.

13. Digita di nuovo LIST VOLUME` e verifica che la partizione UEFI abbia la lettera Z, il tuo HD esterno la lettera W. Poi controlla quale lettera è attribuita alla pennetta USB: probabilmente sarà la C o la D: annotala.

14. Digita `EXIT` per uscire dal programma DISKPART avviato sopra al punto 6.

**Installa il sistema operativo**

Ora viene la parte - solo in apparenza - difficile. In realtà devi solo copiare i comandi qui sotto, e andrà liscia come l'olio.

15. Sempre dalla terminale della chiavetta USB nel quale hai effettuato le ultime operazioni (v. sopra dal punto 6 al 13) digita:
``` 
dism /Get-WimInfo /WimFile:D:\Sources\install.wim
```
per ottenere l'elenco dei sistemi operativi (=versioni di Windows) installabili. Metti al posto della lettera "D" nella formula appena enunciata, la lettera che hai individuato sopra al punto 13, usata dal tuo sistema per indicare la pennetta USB. 

16. Ora è venuto il momento di installare Windows. Il comando è:
``` 
dism /Apply-Image /ImageFile:D:\Sources\install.wim /index:5 /ApplyDir:W:\
```
In questa stringa tieni conto che dopo `ImageFile:` devi mettere la lettera giusta, che si riferisce alla tua chiavetta USB (v. sopra al punto 13). Dopo `Index:` devi mettere il numero corrispondente alla versione di Windows che ti interessa, preso dall'elenco ottenuto prima (v. sopra al punto 15). Mentre la stringa `ApplyDir:W`significa che il Windows va installato sul tuo HD esterno, contrassegnato dalla lettera W (v. sopra punto 9).

17. Finita l'installazione verifica che sia tutto ok. Digita `DIR W:` per vedere quali cartelle sono state installate nel tuo HD esterno. Se vedi  queste cartelle dovrebbe essere tutto a posto:

* Perflogs/
* Program Files (x86)/
* Program Files/
* Users/
* Windows/

18. Ora rimane solo da rendere avviabile il tuo HD esterno. Il comando è:
``` 
bcdboot W:\Windows /l it-it /s Z: /f UEFI
```
19. Ecco fatto. Ora chiudi il terminale e la finestra dell'installatore. Il sistema si riavvierà. Durante il riavvio stacca la chiavetta USB (ma tieni collegato il tuo HD esterno) e tieni premuto ALT fino a quando apparità la schermata con le due icone di macOS e EFI BOOT. Clicca quest'ultima e si avvierà il programma di configurazione finale di WIndows. Segui le istruzioni ed è fatta. Ad ogni avvio dovrai premere ALT e poi selezionare EFI BOOT se vuoi accedere a Windows.
