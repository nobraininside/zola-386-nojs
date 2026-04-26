+++
title = "Qubes OS : Sécuriser vos secrets avec pass"
description = "Tutoriel pour configurer pass dans une AppVM isolée sur Qubes OS : le standard GPG pour une souveraineté numérique totale."
template = "page.html"
date = 2025-07-21
slug  = "qubes-os-securiser-vos-secrets-avec-pass"

[extra]
short_title = "Qubes & pass..."

[taxonomies]
categories = ["Tech-log"]
tags = ["tutoriel", "securite", "linux", "qubes", "souverainete"]
+++

La force de Qubes OS réside dans le cloisonnement. Pour éviter de confier vos mots de passe à un logiciel propriétaire, l'utilisation de pass au sein d'une AppVM dédiée est la solution idéale pour garantir une souveraineté numérique totale.

## 1. Installation
<br />
Dans le template utilisé par votre AppVM (par exemple debian-12 ou fedora-40) :

```sudo apt install pass```

## 2. Initialisation
<br />

#### a. Générez votre clé GPG dans l'AppVM où vous centralisez vos mots de passe :

```gpg --full-generate-key```. Sélectionnez (1) RSA et RSA, 4096 bits, expiration 0 (jamais) ; insérez votre nom et une passphrase robuste.


#### b. Initialisez le stockage pass en utilisant l'identité créée (ID ou nom associé à votre clé GPG) :

```pass init <ID_GPG_ou_Nom_indiqué_lors_de_l_initialisation>```


## 3. Utilisation quotidienne
<br />

#### a. Ajouter un mot de passe

```pass insert <nom: par exemple telegram>```

Insérez deux fois votre mot de passe lorsque le système le demande.


#### b. Organiser vos secrets
Pour déplacer un mot de passe dans une catégorie spécifique (dossier):

```pass mv nompassword categorie/nompassword```


#### c. Modifier une entrée

```pass edit nompassword```

Le système vous demandera la passphrase GPG pour accéder au fichier. Après vos modifications, il sera automatiquement rechiffré avant d'être sauvegardé dans votre AppVM.