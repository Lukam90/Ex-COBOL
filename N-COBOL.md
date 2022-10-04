# Notes - COBOL

## Historique

- COmmon Business Oriented Language
- Un des premiers langages de haut niveau
- Créé en 1959 par l'organisme américain CODASYL
    - Conférence en Data Systems Language
    - A l'origine des bases de données relationnelles en 1970
- COBOL-60 développé en moins de 6 mois

4 versions ANSI du COBOL :
- 68
- ANSI 74
- ANSI 85
- ANSI 2002

**Années 60 : besoins "simples"**

Entrées > Traîtement > Etat

**Années 70 : besoins + "complexes"**

Entrées + Données stockées > Fusion des données > Conditions > Traitements > Etat + Données stockées

**Années 80 : applications + conviviales**

Entrées > Clavier

## Raisons

- Ses fondements
    - Développé pour être un standard
    - Soutenu par les principaux constructeurs
    - Première version "Standard ANSI" en 1968
    - Un langage simple
        - Pas de pointeur
        - Pas de type utilisateur
        - Très structuré
- Un langage très anglicisé

## Chiffres

- Des chiffres qui parlent :
    - 50 ans comme langage de gestion
    - 95 % des programmes de la banque-assurance
    - 73 % des données du monde des affaires traitées
    - 15 % des nouveaux programmes

- La lutte des successeurs :
    - nombreux
    - oubli des fonctions batch
    - la portabilité

- La robustesse des systèmes :
    - des systèmes éprouvés
    - des informaticiens formés

- Une population de "vieux" informaticiens :
    - la retraite d'ici 2020
    - 4 IUT sur 235
    - 2,3 % d'informaticiens formés

- Le langage des grands systèmes

- Disponible sur les systèmes modernes :
    - Serveurs UNIX et LINUX
    - Micro Focus propose AcuCobol
    - Autres compilateurs COBOL

## Structure

Langage orienté programmation structurée

Approche différente de la POO

## Hiérarchie

4 niveaux :
- divisions
- sections
- paragraphes
- instructions élémentaires

Les 4 divisions ne sont pas toutes obligatoires.

## Divisions

### Identification DIVISION

- Informations d'identification du programme
- Que des paragraphes
- Pas de MAJ automatique
- Seul **PROGRAM-ID** est obligatoire.

- **PROGRAM-ID** = Nom du programme
- **AUTHOR** = Nom de l'auteur
- **DATE-WRITTEN** = Date du programme
- **DATE-COMPILED** = Date de compilation

### Environment DIVISION

Division non standard et dépendante
- de la machine à travers son OS
- du fonctionnement des fichiers

- Uniquement nécessaire pour les fichiers

CONFIGURATION SECTION :
- **SOURCE-COMPUTER** : Compilation
- **OBJECT-COMPUTER** : Exécution
- **SPECIAL-NAMES**

- Dépendant de l'environnement matérial
- Seule division non portable

INPUT-OUTPUT SECTION :
- FILE-CONTROL
- I-O-CONTROL

2 sections :
- CONFIGURATION SECTION
- INPUT-OUTPUT SECTION

#### CONFIGURATION SECTION

**SOURCE-COMPUTER** (nom de la machine de développement)

```cbl
SOURCE-COMPUTER. ALPHA WITH DEBUGGING MODE.
```

**OBJECT-COMPUTER** (object computer entry)

```cbl
OBJECT-COMPUTER. ALPHA PROGRAM COLLATING SEQUENCE IS EB-CONV.
```

**Special-Names** (noms spéciaux système) :
- ALPHABET EB-CONV IS EBCDIC.
- DECIMAL-POINT IS COMMA.
- CURRENCY SIGN IS €.

#### INPUT-OUTPUT SECTION

- Description des fichiers utilisés
- Nécessaire avec des fichiers
- Suit la CONFIGURATION SECTION
- Paragraphe FILE-CONTROL : une instruction SELECT par fichier utilisé
- Paragraphe I-O-CONTROL :
    - Optimisation de l'espace mémoire utilisé
    - Mémoire centrale de taille limitée
    - Mémoire virtuelle existante
    - Préoccupation d'une autre époque
    - Ne plus utiliser

#### SELECT

- Un SELECT par fichier
- Instruction non standard

```cbl
FILE-CONTROL.
    SELECT CompteClient ASSIGN TO "DIA0:[Fichier]CompteClient.dat"
    ORGANIZATION IS SEQUENTIAL.

FILE-CONTROL.
    SELECT CompteClient ASSIGN TO "C:\Fichier\CompteClient.dat"
    ORGANIZATION IS LINE SEQUENTIAL.
```

- Des options communes :
    - ORGANIZATION { SEQUENTIAL / INDEXED / RELATIVE }
    - ACCES MODE IS { SEQUENTIAL / RANDOM / DYNAMIC }
    - RECORD KEY NomVariable
    - FILE STATUS IS NomVariable

### DATA DIVISION

- Déclarations de toutes les variables utilisées
- 3 sections "standard"
    - **FILE SECTION** : description des enregistrements de fichier
    - **WORKING-STORAGE SECTION** : description des variables locales
    - **LINKAGE SECTION** : description des variables d'appel
- Autres sections dépendantes du compilateur
- Toutes les déclarations sur le même modèle
- Une variable = un niveau
- Des formats prédéfinis pour le programme

#### Les niveaux

- Un nombre de 2 chiffres
- **01-49** : structure de données
- **77** : variables locales
- **66** : redéfinition de structure
- **88** : variables conditionnelles

**Ex 1 : Etat-civil**

```cbl
01 EtatCivil.
    10 Intitule
    10 Blanc1
    10 Prenom
    10 Blanc2
    10 Nom
 ```

**Ex 2 : Adresse composée**

```cbl
01 Adresse.
    10 Rue.
        20 Numero
        20 Blanc1
        20 NomRue
    10 CodePostal
    10 Blanc2
    10 Ville
    10 Pays
```

#### La clause PICTURE

- Définit le format de la zone
- Utilisé sur les variables de dernier niveau
- Souvent abrégé en PIC
- Formats disponibles :
    - 9 = chiffre significatif (zéros affichés)
    - Z = chiffre non significatif (blancs si zéros)
    - S = signe
    - V = virgule
    - A = alphabétique ou espace
    - X = alphanumérique

#### La clause VALUE

- Définit la valeur initiale de la variable
- Facultatif
- Pas utile dans la FILE SECTION
- Mot ALL UTILE

```cbl
01 Adresse
    10 Rue.
        20 Numero PIC X(3).
        20 Filler PIC X.
        20 NomRue PIC X(50) VALUE ALL "-".
    10 CodePostal PIC 9(5).
    10 Filler PIC X.
    10 Ville PIC X(50).
    10 Pays PIC X(50).
```

## Eléments

On a 80 colonnes définies.

On a une séparation de programme dès la 77ème colonne.

Colonnes :
- **1 à 6** : numéro de ligne
- **7** : commentaires ou lignes suites
- **8 à 72** : instruction
    - **8 à 11** : marge A pour division, sections, paragraphes
    - **12 à 72** : instructions et déclarations
- **73 à 80** : (identification du programme)

- Instruction sur plusieurs lignes
- Mots et littéraux non sécables
- Chaîne sur plusieurs lignes
- Jeu de caractères :
    - alphabétiques
    - numériques
    - signes
- Règles des noms COBOL :
    - noms des sections, paragraphes et variables
    - 30 caractères max
    - caractères alphanumériques et tirets
    - ne commence pas par un -
    - ne contient pas d'espace
    - n'est pas "case sensitive"

## Eléments manipulés

Les littéraux :
- **Alphanumérique** : suite de caractères entre 2 guillemets (ex : "My first COBOL")
- **Numérique** : suite de chiffres avec éventuellement un point décimal ou un signe (ex : -56.3)
- Notation **mmmEeee** (IBM)
- **Constantes figuratives** : ZERO, SPACE

- Les noms utilisateurs
- Les mots réservés

## Visual Studio

- Nouveau projet
- Rechercher "Cobol"
- Choisir "Console Application (.NET Framework)"

## Manipulation des données

- Transférer d'un emplacement à un autre dans la RAM (mémoire vive)
- L'instruction MOVE

```cbl
MOVE { var1 / litteral } TO var2

MOVE CORRESPONDING { var1 / litteral } TO var2
```

Règles dans les transferts :

- Les conversions de données doivent être possibles
- Si la zone de réception est plus petite, risque de troncature
- Si la zone de réception est plus grande, complément :
    - 0 à gauche pour les zones numériques
    - espace à droite pour les autres zones

## Manipuler les chaînes

3 instructions majeures :

- STRING pour concaténer les chaînes
- UNSTRING pour éclater les chaînes
- INSPECT permet de compter ou remplacer les chaînes dans une autre

- Instructions avec de multiples déclinaisons
- Commenter précisément les actions
- Ecrire une ligne par champ

## Dialoguer avec l'utilisateur

- Des instructions souvent remplacées par des outils externes
- ACCEPT permet de lire des données depuis "Input"

```cbl
ACCEPT variable.
ACCEPT variable FROM { DATE / DAY / DAY-OF-WEEK / TIME }.
```

- DISPLAY permet d'afficher des données dans "Output"

```cbl
DISPLAY { var1 / litteral } [WITH NO ADVANCING]
```

- SCREEN SECTION dans Visual COBOL
    - BLANK SCREEN / BLANK LINE
    - Positionnement des textes et des données avec LINE et COL
    - Ligne avec du texte
    - Ligne avec des données (from, using)

## Calculer

- Les opérations sont écrites en clair
- 2 syntaxes principales :
    - opération var1 séparateur var2
    - opération var1 séparateur var2 giving var3
- 4 opérations : ADD, MULTIPLY, DIVIDE, SUBTRACT (+ COMPUTE)

## Les structures algorithmiques

- Le COBOL est très structuré
- La façon de coder doit aussi être structurée
- La règle essentielle : un point d'entrée, un point de sortie
- Les structures élémentaires :
    - séquentiel
    - condition
    - boucle itérative

## Les instructions de contrôle

1) IF THEN ELSE
2) EVALUATE
3) PERFORM

- Le contrôle du programme est passé au paragraphe spécifié et revient à la fin de l'exécution du paragraphe
- Se rapproche d'un CALL dans d'autres langages
- L'outil idéal pour les itérations
- L'instruction de base de la structure de programme adaptée à la plupart des traitements de gestion

## Les instructions "secondaires"

- CONTINUE :
    - Ne fait rien
    - Evite de laisser un paragraphe vide

- INITIALIZE :
    - Réinitialise toutes les valeurs spécifiées
        - Espaces pour les alphanumériques
        - Zéros pour les variables numériques

## Les instructions à éviter

- GO TO : branchement inconditionnel
- ALTER : modifier la destination du GO TO

## La structure fonctionnelle

- Découper le programme en PPP (plus petite partie)
- Chaque partie est indépendante
    - Toutes les initialisations sont faites dans la partie
    - On ne fait jamais appel à une autre partie existante (mais on peut faire appel à une nouvelle partie)
- Penser et programmer chaque partie sans penser aux autres parties
- Chaque partie est une itération (à trouver) :
    - Dans un menu : le traitement d'une option
    - Dans la lecture d'un fichier : le traitement d'une ligne de fichier
    - Dans l'exécution d'une instruction SQL : le traitement d'une ligne
    - Dans un état : l'impression de la ligne détail
- Programmer en pensant le - possible
- Ne jamais programmer 2 PPP en même temps
- Toujours commencer une PPP de programme en écrivant ces quelques lignes

```cbl
MaPartie.
    PERFORM MaPartie-Init.
    PERFORM MaPartie-Traitement UNTIL FinMaPartie = 1.
    PERFORM MaPartie-Fin.

MaPartie-Init.
    MOVE 0 TO FinMaPartie.
    ...

MaPartie-Traitement.
    ...

MaPartie-Fin.
    CONTINUE (ou STOP RUN)
```

## Base de données (Microsoft SQL Server Management)

Options > Concepteurs > Concepteurs de bases de données > Décocher "Empêcher l'enregistrement..."

**Compte**

- CodeBanque - char(5)
- CodeGuichet - char(5)
- NoCompte - char(9)
- TypeCompte - char(2)
- CleRib - char(2)
- Debit - numeric(10, 2), null
- Credit - numeric(10, 2), null
- CodeClient - uniqueidentifier

**Client**

- CodeClient - uniqueidentifier
- Intitule - varchar(10), null
- Nom - varchar(50), null
- Prenom - varchar(50), null
- CodePostal - char(5), null
- Ville - varchar(50), null

CodeClient > Propriétés > Valeur par défault = newid()
