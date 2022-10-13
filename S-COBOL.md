# COBOL - Syntaxe

Niveaux :

1) divisions
2) sections
3) paragraphes
4) instructions

Lignes :

- **1 à 6** : numéros de ligne (optionnel)
- **7** : commentaires (*)
- **8 à 72** : Instructions
	- **8 à 11** : marge A pour divisions / sections / paragraphes
	- **12 à 72** : instructions et déclarations
- **73 à 80** : identification du programme (optionnel)

Règles de base : 

- Instruction sur plusieurs lignes (80 caractères max)
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

Formats :

- **9** = chiffre significatif (zéros affichés)
- **Z** = chiffre non significatif (blancs si zéros)
- **S** = signe
- **V** = virgule
- **A** = alphabétique ou espace
- **X** = alphanumérique

Niveaux de variables (2 chiffres) :

- **01-49** : structure de données
- **77** : variables locales
- **66** : redéfinition de structure
- **88** : variables conditionnelles

Identification = obligatoire !

```cbl
identification division.
program-id. Nom-Programme.
```

Environnement local (optionnel)

```cbl
environment division.
```

Fichiers

```cbl
input-output section.
file-control.
	select NomFichier
	assign to Chemin
	organization is [line] { sequential / indexed / relative }
	[access mode is { sequential / random / dynamic }]
	[record key NomVariable]
	[file status is NomVariable]
```

Division des données (obligatoire)

```cbl
data division.
```

Définition des fichiers

```cbl
file section.

FD NomFichier [record varying from 0 to 255].
01 MonEnregistrement pic X(255).
```

Section des variables

```cbl
working-storage section.
```

Ex Date Systeme

```cbl
01 DateSysteme.
	10 Annee Pic 9(4).
	10 Mois Pic 9(2).
	10 Jour Pic 9(2).
```

Ex Table

```cbl
01 CLIENT.
	10 CodeClient PIC X(36).
	10 Intitule sql char (5).
	10 Nom sql CHAR-VARYING (50).
	10 Prenom sql CHAR-VARYING (50).
	10 CodePostal sql CHAR (5).
	10 Ville sql CHAR-VARYING (50).
```

Ex Variables locales

```cbl
77 NomSelectionne pic X(25).
77 NoLigneCompte pic 99.
77 NoLigneEcran pic 99.
```

Déclaration de la connexion SQL

```cbl
77 CNXDB STRING.
	EXEC SQL
		INCLUDE SQLCA
	END-EXEC.

	EXEC SQL
		INCLUDE SQLDA
	END-EXEC.
```

Ecrans de l'application (Visual COBOL)

```cbl
screen section.

01 LeMenu background-color
is CouleurFondEcran
foreground-color is CouleurCaractere.
	10 line 1 col 1 Blank Screen.
	10 line 3 col 32 value " GESTION BANCAIRE ".
	10 line 5 col 2 value " Date systeme :".
	10 line 5 col 18 from Jour of DateSysteme.
	10 line 5 col 20 value "/".
	10 line 5 col 21 from Mois of DateSysteme.
	10 line 5 col 23 value "/".
	10 line 5 col 24 from Annee of DateSysteme.
	10 line 5 col 69 value " Option :".
	10 line 5 col 79 pic 9 from Option.
	10 line 8 col 5 value "- 1 - Importation des comptes ... :".
	10 line 9 col 5 value "- 2 - Liste des banques ... :".
	10 line 10 col 5 value "- 3 - Liste des comptes ... :".
	10 line 11 col 5 value "- 4 - Controle des cles RIB ... :".
	10 line 12 col 5 value "- 5 - Gestion des clients ... :".
	10 line 14 col 5 value "- 0 - Fin de traitement ... :".
```

Division des instructions (obligatoire)

```cbl
procedure division.

MaPartie.
	perform MaPartie-Init.
	perform MaPartie-trt until Eof = 1.
	perform MaPartie-Fin.

MonParagraphe.
	...
```

Déclaration de la connexion à la BDD

```cbl
77 CNXDB STRING.
	EXEC SQL
		INCLUDE SQLCA
	END-EXEC.

	EXEC SQL
		INCLUDE SQLDA
	END-EXEC.
```

Connexion à la BDD

```cbl
exec sql
	connect using :cnxDb
end-exec.

if (sqlcode not equal 0) then
	stop run
end-if.
```

MAJs automatiques de la BDD (/!\ sécurité)

```cbl
exec sql
	SET AUTOCOMMIT ON
end-exec.
```

Ex Sélection d'un client

```cbl
exec sql
	select CodeClient
	into :Client.CodeClient
	from Client
	where Nom = :Client.Nom
end-exec.
```

Ex Création d'un client

```cbl
if (CodeClient of CLIENT = " ") then
	exec sql
		select newid() into :Client.CodeClient
	end-exec

	exec sql
		INSERT INTO Client
			(CodeClient
			,Intitule
			,Nom
			,Prenom
			,CodePostal
			,Ville)
		VALUES
			(:Client.CodeClient
			,:Client.Intitule
			,:Client.Nom
			,:Client.Prenom
			,:Client.CodePostal
			,:Client.Ville)
	end-exec
end-if.
```

Ex Déclaration du curseur des banques (Init)

```cbl
exec sql
	declare C-ListeBanque cursor for
		select CodeBanque, NomBanque
		from Banque
		order by NomBanque
end-exec.

exec sql
	open C-ListeBanque
end-exec.
```

Ex Parcours du curseur des banques (Trt)

```cbl
exec sql
	fetch C-ListeBanque
	into :Banque.CodeBanque, :Banque.NomBanque
end-exec.

if (sqlcode not equal 0 and sqlcode not equal 1) then
	move 1 to Eot
else
	perform AffichageBanque
end-if.
```

Ex Fermeture du curseur des banques (Fin)

```cbl
exec sql
	close C-ListeBanque
end-exec.
```

Ex Affichage & Entrée

```cbl
display "Message".
display "Message" with no advancing.

accept MaVariable.
```

Ex Affections de variables

```cbl
move 123 to SampleData.
move "123" to SampleData.

move zero to SampleData.
move space to SampleData.
move high-value to SampleData.
move low-value to SampleData.
move quote to SampleData.
move all "2" to SampleData.
```

Ex Opérations mathématiques

```cbl
add Num1 to Num2 giving Ans.

subtract Num1 from Num2 giving Ans.

multiply Num1 by Num2 giving Ans.

divide Num1 into Num2 giving Ans.
divide Num1 into Num2 giving Ans remainder Rem.

compute Ans = 3 + 2.
compute Ans rounded = 3.0 + 2.005.
```

Ex conditions (IF)

```cbl
if Age > 18 then
	DISPLAY "You can vote"
else
	DISPLAY "You can't vote"
end-if.

if Age LESS THAN 5 then
	DISPLAY "Stay home."
END-IF. 

if Age GREATER THAN OR EQUAL TO 18 then
	DISPLAY "You're an adult."
END-IF. 

if Score is PassingScore THEN
	DISPLAY "You passed !"
else
	DISPLAY "You failed !"
END-IF.

if Score IS NOT NUMERIC THEN
	DISPLAY "Not a number"
END-IF. 
```

Ex conditions (EVALUATE)

```cbl
EVALUATE TRUE 
	WHEN IsPrime DISPLAY "Prime"
	WHEN IsOdd DISPLAY "Odd"
	WHEN IsEven DISPLAY "Even"
	WHEN LessThan5  DISPLAY "Less than 5"
	WHEN OTHER DISPLAY "Default Action"
END-EVALUATE
```

Ex boucles (PERFORM)

```cbl
PERFORM MonAction N Times.

PERFORM MonAction UNTIL MaCondition.

PERFORM OutputData 
VARYING MonIndex 
FROM Debut BY Pas 
UNTIL MonIndex = Fin.
```

Nombre de caractères

```cbl
INSPECT SampStr TALLYING NumChars FOR CHARACTERS.
```

Nombre d'occurences

```cbl
INSPECT SampStr TALLYING NumEs FOR ALL "e".
```

Changement de casse

```cbl
DISPLAY "Uppercase : " FUNCTION UPPER-CASE(SampStr).
DISPLAY "Lowercase : " FUNCTION LOWER-CASE(SampStr).
```

Construction d'une chaîne

```cbl
string
	Intitule delimited by space
	" " delimited by size
	Prenom delimited by space
	" " delimited by size
	Nom delimited by space
	into NomPrenomComplet
end-string.

STRING FName DELIMITED BY SIZE
SPACE 
LName DELIMITED BY SIZE
INTO FLName.

STRING FLName DELIMITED BY SIZE
SPACE 
MName DELIMITED BY SIZE
SPACE 
LName DELIMITED BY SIZE
INTO FMLName
ON OVERFLOW DISPLAY "Overflowed".
```

Séparation d'une chaîne

```cbl
unstring E-ListeCompteClient delimited by ";" into
	Intitule of CLIENT
	Nom of CLIENT
	Prenom of CLIENT
	CodePostal of CLIENT
	Ville of CLIENT
	CodeBanque of Compte
	CodeGuichet of Compte
	RacineCompte of CompteComplet of Compte
	TypeCompte of CompteComplet of Compte
	CleRIB of Compte
	Debit of Compte
	DerniereZone
end-unstring.
```

Boucle de lecture d'un fichier

Init

```cbl
move 0 to eof.

open input F-ListeCompteClient.
read F-ListeCompteClient.
```

Traitement

```cbl
read F-ListeCompteClient
	at end
		move 1 to Eof
	not at end
		perform ImportLigne
end-read.
```

Fin

```cbl
close F-ListeCompteClient.
```

Lecture d'un fichier

```cbl
open input F-Voitures.

read F-Voitures
	invalid key 
		display "Pas de voiture dans le fichier"
	not invalid key
		display "Modele = " Modele
end-read.

close F-Voitures.
```

Ouverture en extension (ou ajout)

```cbl
open extend F-Voitures.
```

Ecriture dans un fichier

```cbl
open output F-Voitures.

write E-Voiture
	invalid key
		display "Voiture deja enregistree"
	not invalid key
		display "OK"
end-write.

close F-Voitures.
```

Réécriture d'un fichier

```cbl
read F-Voitures
	invalid key
		display "Voiture absente"
	not invalid key
		move "BLEU" to Couleur

		rewrite E-Voiture
			invalid key
				display "Erreur interne (REWRITE)"
			not invalid key
				display "OK"
		end-rewrite
end-read.

close F-Voitures.
```