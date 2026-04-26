---
Title: compilare un programma con Void musl
Published: 2024-03-20 10:53:41
Author: yellowadmin
Layout: blog
Tag: Example
---

OPERAZIONI PRELIMINARI

`$ git clone https://github.com/void-linux/void-packages`

`$ cd void-packages`

`$ ./xbps-src binary-bootstrap`
[--more--]<br />

PER OGNI SINGOLO PROGRAMMA

CONFIGURA

`$ ./xbps-src extract <package>`

`$ mkdir srcpkgs/<package>/files`

`$ cp masterdir/builddir/<package>-<version>/config.def.h srcpkgs/<package>/files/config.h`

Edit srcpkgs/<package>/files/config.h

COMPILA E INSTALLA

`$ ./xbps-src pkg <package>`

`# xbps-install -R hostdir/binpkgs <package>`


-  -  -  - -

PATCH
AGGIUNGI PATCH

`srcpkgs/<package>/patches`

REINSTALLA

`# xbps-install -R hostdir/binpkgs -f <package>`

