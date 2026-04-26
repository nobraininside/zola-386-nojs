+++
title = "Désactiver le Directory Listing pour sécuriser son serveur"
description = "Tutoriel rapide pour sécuriser vos fichiers en désactivant l'indexation automatique des dossiers sur serveurs Linux et Windows."
date = 2022-08-24
slug = "desactiver-le-directory-listing-pour-securiser-son-serveur"

[extra]
short_title = "Désactiver..."

[taxonomies]
categories = ["Tech-log"]
tags = ["serveur", "securite", "tutoriel", "web"]
+++

Si vous hébergez un site sur un espace serveur sans CMS, vos fichiers et dossiers sont potentiellement accessibles au premier visiteur venu grâce au "Directory Listing". Pour éviter que des inconnus puissent parcourir l'arborescence de votre serveur, quelques lignes de configuration suffisent.<br />


## 1. Sur serveur Linux (Apache)
<br>
Dans votre dossier public_html, localisez le fichier .htaccess. Ajoutez simplement la ligne suivante tout en haut du fichier, avant tout autre texte :

`Options -Indexes`

## 2. Sur serveur Windows (IIS)
<br>
Dans le dossier public_html, cherchez le fichier web.config. Pour désactiver l'affichage des répertoires, assurez-vous de supprimer, commenter ou paramétrer `enabled="false"` la directive suivante :

`<directoryBrowse>`
