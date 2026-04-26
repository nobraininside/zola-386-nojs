---
Title: Come disabilitare l'accesso a file e cartelle del tuo sito web
Published: 2022-08-24 13:46:35
Author: Writer
Layout: blog
Tag: web
---
Se hai uno spazio server collegato a un nome di dominio non gestito da un CMS e vuoi evitare il *directory listing*, ossia che gli estranei vi possano leggere i tuoi file e  cartelle, basta un semplice accorgimento:

 1. In caso di server Linux, cerca nella cartella <i>public_html</i> il file *.htaccess* e **aggiungi** alla riga 1, prima di qualunque altro testo: 
`Options -Indexes` 

 2. In caso di server Windows, cerca nella cartella <i>public_html</i> il file *web.config* e **rimuovi** la riga seguente: 
`<directoryBrowse>`


(Credit: https://www.casbay.com)
