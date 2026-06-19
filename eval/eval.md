# Transformations éditoriales avancées - évaluation

## Objectif

Réaliser une feuille de transformations XSLT XML-TEI vers (X)HTML pour le fichier `IDM0012.tei.xml` contenant la transcription du plumitif des séances de l’Académie royale des sciences de l’année 1777.

Vous pouvez vous aidez des supports de cours.

## Exercice

Prenez un instant pour prendre connaissance du document.

La feuilles de transformation doit prendre en compte les impératifs suivants :

### Paramètres de sortie

Le document produit est au **format XHTML**, **encodé en UTF-8** et **n'est pas indenté**.

### En-tête HTML

Le titre du document HTML est de la forme `"auteur" - "titre du document TEI"`. L'en-tête contient également une balise `<meta charset="utf-8" />`.

### Corps HTML

Le corps du document comprend les parties suivantes :

- un header ;
- le plumitif ;
- un footer.

#### Header

Le header contient le titre principal du document (`h1`) sous la forme `"titre du document TEI" par "auteur"`

Il présente également une navigation sous la forme d'une **table des matières**. Chaque entrée est un lien permettant l'**accès direct** à la séance. Une mention du **nombre de séances** précède cette table des matières.

#### Plumitif

La transcription de l'année est placée dans un élément HTML `main`, son titre est de niveau `h2`.

Chaque séance fait l'objet d'un `article`. Chaque article est composé d'un titre où l’on trouve, **dans cet ordre**, le numéro de la séance puis la date ; et d’une `section` contenant l'ordre du jour.

Les paragraphes disposent d'un attribut `class` si un attribut `rend` est présent en entrée.

Les changements de feuillet sont indiqués entre crochets. Ils prennent la valeur de l’attribut `n`, le signe `_` (*underscore*) est remplacé par une espace. La mention "vierge" est ajoutée à la suite du numéro de feuillet si un attribut `rend="empty"` est présent (p. ex `[26 r vierge]`).

#### Mise en forme du texte

| Entrée TEI                        | Sortie HTML                       |
| :-----                            | :-----                            |
| dates `date` et attribut `when`   | `<time datetime="xxxx-xx-xx"/>`   |
| ajouts `add`                      | `|ajout|`                         |
| suppressions `del`                | `<passage supprimé>`              |
| passages incertains `unclear`     | `[passage incertain ?]`           |
| restitutions `supplied`           | `[restitution]`                   |
| manques `gap`                     | `[…]`                             |
| passages fautifs `sic`            | `passage fautif (`*`sic`*`)`^[Le sic est en italique.]    |
| listes `list`                     | listes HTML                       |
| citations `q`                     | citation HTML                     |


Pour les éléments de mise en évidence (`hi`), un traitement spécifique est adapté aux valeurs de l'attribut `rend` ; un traitement par défaut est disponible.

Dans le texte, les notes sont remplacées par des appels de notes en exposant. Le contenu de chaque note est placé dans un paragraphe à la fin de chaque séance. La numérotation des appels de note est réinitialisée à chaque séance.


#### Footer

Le footer contient les mentions de l’éditeur (`publicationStmt`) et votre nom.
