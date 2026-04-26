---
Title: Magie del terminale: zip
Published: 2022-09-12 14:38:11
Author: Writer
Layout: blog
Tag: terminale,cli,utilità, cifratura
---
Per archiviare, comprimere e cifrare file o cartelle esiste il comando `zip`, che crea un file in formato universalmente riconosciuto da qualsiasi sistema operativo. Alla base zip si limita ad **archiviare**, cioè a creare un file unico partendo da più file. In questo caso il comando sarà :
```
zip archivio.zip file1 file2
```
Se devi archiviare una o più cartelle e/o uno o più file basta aggiungere `-r `(*recursive*):
```
zip -r archivio.zip cartella1 file1 file2
```
[--more--]
Se vuoi anche **comprimere** il tutto, aggiungi `-9` (indica il livello di compressione massima, che si ottiene con uno sforzo maggiore della cpu. Puoi scegliere anche valori inferiori, meno impegnativi per il tuo processore, ma consiglio di stare tra -6 e -9):
```
zip -9 -r archivio.zip cartella1 file1 file2
```
Se infine vuoi anche **cifrare** il tutto, anteponi `-e` e ti sarà chiesta una password (mi raccomando annotala da qualche parte):
```
zip -e -9 -r archivio.zip cartella1 file1 file2
```
E per aprire il file zippato che si fa? Semplice, si usa il comando `unzip`, cui devi aggiungere l'opzione `-P` se il file è cifrato:
```
unzip -P archivio.zip
```
NOTA: per chi volesse approfondire consiglio vivamente [questo articolo su golinuxcloud.com](https://www.golinuxcloud.com/how-to-zip-a-folder-in-linux-with-examples/) (in inglese).
