---
Title: /usr/local piena in OpenBSD
Published: 2024-02-05 18:15:37
Author: yellowadmin
Layout: blog
Tag: bsd
---
In OpenBSD la partizione /usr/local contiene tutte le applicazioni e librerie installate con `pkg_add`. Se il comando `df` da terminale mostra che la partizione è satura, si può liberare spazio digitando come root `pkg_delete -ac`. Questo comando elimina tutte le dipendenze di programmi precedentemente installati e poi disinstallati dal sistema.
