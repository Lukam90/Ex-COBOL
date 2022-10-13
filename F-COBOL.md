# Fiches COBOL

## Les niveaux d'instruction

1) divisions
2) sections
3) paragraphes
4) instructions élémentaires

## Les niveaux de variables

- Un nombre de 2 chiffres
- **01-49** : structure de données
- **77** : variables locales
- **66** : redéfinition de structure
- **88** : variables conditionnelles

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

## Les formats de variables

- 9 = chiffre significatif (zéros affichés)
- Z = chiffre non significatif (blancs si zéros)
- A = alphabétique ou espace
- X = alphanumérique
- S = signe
- V = virgule

## Les colonnes

- **1 à 6** : numéro de ligne
- **7** : commentaires ou lignes suites
- **8 à 72** : instruction
    - **8 à 11** : marge A pour division, sections, paragraphes
    - **12 à 72** : instructions et déclarations
- **73 à 80** : (identification du programme)

On a 80 colonnes définies.

On a une séparation de programme dès la 77ème colonne.

## L'affichet et les données en entrée

```cbl
display "What is your name ? " with no advancing.
    
accept Username.

display "Hello " Username.

accept DateSysteme from date yyyymmdd.
```

## Les variables et les constantes

```cbl
identification division.
program-id. 3-variables.
author. Lucien HAMM.

environment division.

data division.

working-storage section.
01 SampleData pic X(10) value "Stuff".
01 JustLetters pic AAA value "ABC".
01 JustNums pic 9(4) value 1234.
01 SignedInt pic S9(4) value -1234.
01 PayCheck PIC 9(4)V99 value zero.

01 Customer.
    02 Ident pic 9(3).
    02 CustName pic x(20).
    02 DateOfBirth.
        03 MOB pic 99.
        03 DOB pic 99.
        03 YOB pic 9(4).

01 Num1 pic 9 value 5.
01 Num2 pic 9 value 4.
01 Num3 pic 9 value 3.

01 Ans pic S99V99 value 0.

01 Rem pic 9V99.

procedure division.
    move "More Stuff" to SampleData.
    move "123" to SampleData.
    move 123 to SampleData.

    display SampleData.
    display PayCheck.

    move "123Bob Smith           12211974" to Customer.

    display MOB "/" DOB "/" YOB.

    move zero to SampleData.
    display SampleData.

    move space to SampleData.
    display SampleData.

    move high-value to SampleData.
    display SampleData.

    move low-value to SampleData.
    display SampleData.

    move quote to SampleData.
    display SampleData.

    move all "2" to SampleData.
    display SampleData.
    
    stop run.
```

## Les opérations mathématiques

```cbl
identification division.
program-id. 4-math.
author. Lucien HAMM.

environment division.

data division.

working-storage section.
01 Num1 pic 9 value 5.
01 Num2 pic 9 value 4.
01 Num3 pic 9 value 3.

01 Ans pic S99V99 value 0.

01 Rem pic 9V99.

procedure division.
    add Num1 to Num2 giving Ans.

    display Ans.

    subtract Num1 from Num2 giving Ans.

    display Ans.

    multiply Num1 by Num2 giving Ans.

    display Ans.

    divide Num1 into Num2 giving Ans.

    display Ans.

    divide Num1 into Num2 giving Ans remainder Rem.

    display "Remainder " Rem.

    compute Ans rounded = 3.0 + 2.005.

    display Ans.
    
    stop run.
```

## Les conditions

```cbl
IDENTIFICATION DIVISION.
PROGRAM-ID. 5-conditions.
AUTHOR. Lucien HAMM.

ENVIRONMENT DIVISION.
CONFIGURATION SECTION. 
SPECIAL-NAMES. 
    class PassingScore IS "A" THRU "C", "D".

data division.
file section.
WORKING-STORAGE SECTION. 
01 Age pic 99 value 0.
01 Grade pic 99 value 0.
01 Score pic X(1) value "B".
01 CanVoteFlag PIC 9 value 0.
    88 CanVote value 1.
    88 CantVote value 0.
01 TestNumber pic X.
    88 IsPrime value "1", "3", "5", "7".
    88 IsOdd value "1", "3", "5", "7", "9".
    88 IsEven value "2", "4", "6", "8".
    88 LessThan5 value "1" THRU "4".
    88 ANumber value "0" THRU "9".

PROCEDURE DIVISION.
    DISPLAY "Enter Age : " WITH NO ADVANCING.

    ACCEPT Age.

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

    PERFORM UNTIL NOT ANumber
        EVALUATE TRUE 
            WHEN IsPrime DISPLAY "Prime"
            WHEN IsOdd DISPLAY "Odd"
            WHEN IsEven DISPLAY "Even"
            WHEN LessThan5  DISPLAY "Less than 5"
            WHEN OTHER DISPLAY "Default Action"
        END-EVALUATE
    end-perform.

    STOP RUN.
```

## Les sous-routines

```cbl
IDENTIFICATION DIVISION.
PROGRAM-ID. 7-subroutines.
AUTHOR. Lucien HAMM.
ENVIRONMENT DIVISION.
CONFIGURATION SECTION.

data division.
file section.
WORKING-STORAGE SECTION.
01 Num1 pic 9 VALUE 5.
01 Num2 pic 9 VALUE 4.
01 Sum1 pic 99.

PROCEDURE DIVISION.
    CALL "GetSum" USING Num1, Num2, Sum1.

    DISPLAY Num1 " + " Num2 " = " Sum1.

    STOP RUN.
```

**Ex GetSum**

```cbl
IDENTIFICATION DIVISION.
PROGRAM-ID. GetSum.
AUTHOR. Lucien HAMM.
ENVIRONMENT DIVISION.
CONFIGURATION SECTION.

data division.
linkage section.
01 LNum1 pic 9 VALUE 5.
01 LNum2 pic 9 VALUE 4.
01 LSum pic 99.

PROCEDURE DIVISION USING LNum1, LNum2, LSum.
    COMPUTE LSum = LNum1 + LNum2.

    EXIT PROGRAM.
```

## Les boucles

```cbl
PERFORM OutputData 3 Times.

PERFORM OutputData VARYING Ind FROM 1 BY 1 UNTIL Ind = 5.
```

## Les chaînes de caractères

```cbl
INSPECT SampStr TALLYING NumChars FOR CHARACTERS.

DISPLAY "Number of characters : " NumChars.

INSPECT SampStr TALLYING NumEs FOR ALL "e".

DISPLAY "Number of Es : " NumEs.

DISPLAY "Uppercase : " FUNCTION UPPER-CASE(SampStr).
DISPLAY "Lowercase : " FUNCTION LOWER-CASE(SampStr).

STRING FName DELIMITED BY SIZE
SPACE 
LName DELIMITED BY SIZE
INTO FLName.

DISPLAY "FLName = " FLName.

STRING FLName DELIMITED BY SIZE
SPACE 
MName DELIMITED BY SIZE
SPACE 
LName DELIMITED BY SIZE
INTO FMLName
ON OVERFLOW DISPLAY "Overflowed".

DISPLAY "FMLName = " FMLName.

STRING SStr1 DELIMITED BY SIZE 
SPACE 
SStr2 DELIMITED BY "#"
INTO Dest
WITH POINTER Ptr
ON OVERFLOW DISPLAY "Overflowed".

DISPLAY "Dest = " Dest.

UNSTRING SStr1 DELIMITED BY SPACE 
INTO SStr3, SStr4 
END-UNSTRING.

DISPLAY "SStr4 = " SStr4.

STOP RUN.
```

## Fichier en écriture

```cbl
IDENTIFICATION DIVISION.
PROGRAM-ID. 10-write-file.
AUTHOR. Lucien HAMM.

ENVIRONMENT DIVISION.
INPUT-OUTPUT SECTION. 
FILE-CONTROL. 
    SELECT CustomerFile ASSIGN TO "Customer.dat"
    ORGANIZATION IS LINE SEQUENTIAL
    ACCESS IS SEQUENTIAL.

data division.
file section.
FD CustomerFile.
01 CustomerData.
    02 IDNum PIC 9(8).
    02 CustName.
        03 FirstName   PIC X(15).
        03 LastName    PIC X(15).

WORKING-STORAGE SECTION.
01 WSCustomer.
    02 WSIDNum PIC 9(8).
    02 WSCustName.
        03 WSFirstName   PIC X(15).
        03 WSLastName    PIC X(15).
       
PROCEDURE DIVISION.
    OPEN OUTPUT CustomerFile.

    MOVE 00001 TO IDNum.
    MOVE "Doug" TO FirstName.
    MOVE "Thomas" TO LastName.

    WRITE CustomerData
    END-WRITE.

    CLOSE CustomerFile.

    STOP RUN.
```

## Ajout dans un fichier

```cbl
OPEN EXTEND CustomerFile.

DISPLAY "Customer ID " WITH NO ADVANCING.
ACCEPT IDNum.

DISPLAY "Customer First Name " WITH NO ADVANCING.
ACCEPT FirstName.

DISPLAY "Customer Last Name " WITH NO ADVANCING.
ACCEPT LastName.

WRITE CustomerData
END-WRITE.

CLOSE CustomerFile.
```

## Lecture d'un fichier

```cbl
OPEN INPUT CustomerFile.

PERFORM UNTIL WSEOF = 'Y'
    READ CustomerFile INTO WSCustomer
        AT END MOVE 'Y' TO WSEOF
        NOT AT END DISPLAY WSCustomer 
    END-READ
END-PERFORM.

CLOSE CustomerFile.
```

## Fichier indexé

```cbl
ENVIRONMENT DIVISION.
INPUT-OUTPUT SECTION. 
FILE-CONTROL.
    SELECT CustomerFile ASSIGN TO "Customer.txt"
    ORGANIZATION IS INDEXED
    ACCESS MODE IS RANDOM
    RECORD KEY IS IDNum.
```

## Les tableaux

```cbl
data division.

WORKING-STORAGE SECTION.
01 STable.
    02 Friends PIC X(15) OCCURS 4 TIMES.

01 CustomersTable.
    02 CustomerName OCCURS 5 TIMES.
        03 FName PIC X(15).
        03 LName PIC X(15).

01 OrderTable.
    02 Product OCCURS 2 TIMES INDEXED BY I.
        03 ProdName PIC X(10).
        03 ProdSize OCCURS 3 TIMES INDEXED BY J.
            04 SizeType PIC A.

...

SimpleTable.
    MOVE 'Dave' TO Friends(1).
    MOVE 'Mike' TO Friends(2).
    MOVE 'Bob' TO Friends(3).

    DISPLAY "Friends(1) = " Friends(1).
```

## Les conversions

```cbl
data division.

WORKING-STORAGE SECTION.
01 ChangeMe.
    02 TextNum PIC X(6).
    02 FloatNum REDEFINES TextNum PIC 9(4)V99.

01 StrNum PIC X(7).

01 SplitNum.
    02 WNum PIC 9(4) VALUE ZERO.
    02 FNum PIC 99 VALUE ZERO.

01 FlNum REDEFINES SplitNum PIC 9999V99.
01 DollarNum PIC $$,$$9.99.
```

## L'affichage en colonnes (écran, Visual COBOL)

```cbl
Screen section.

01 LeMenu background-color
is CouleurFondEcran
foreground-color is CouleurCaractere.
    10 line 1 col 1 Blank Screen.
    10 line 3 col 32 value " GESTION BANCAIRE ".
    10 line 5 col 2 value " Date systeme :".
    10 line 5 col 18 from Jour of DateSysteme.

    ...
```

## Déclaration de la connexion SQL

```cbl
77 CNXDB STRING.
    EXEC SQL
        INCLUDE SQLCA
    END-EXEC.

    EXEC SQL
        INCLUDE SQLDA
    END-EXEC.
```

## Connexion à la BDD

```cbl
exec sql
    connect using :cnxDb
end-exec.
```

## Absence d'erreur de connexion SQL

```cbl
if (sqlcode not equal 0) then
    stop run
end-if.
```

## MAJs automatiques de la BDD

```cbl
exec sql
    SET AUTOCOMMIT ON
end-exec.
```

## Existence d'un client

```cbl
exec sql
    select CodeClient
    into :Client.CodeClient
    from Client
    where Nom = :Client.Nom
end-exec.
```

## Ajout d'un client 

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

## Ajout d'un compte

```cbl
exec sql
    INSERT INTO Compte
        (CodeBanque
        ,CodeGuichet
        ,NoCompte
        ,TypeCompte
        ,CleRib
        ,Debit
        ,Credit
        ,CodeClient)
    VALUES
        (:Compte.CodeBanque
        ,:Compte.CodeGuichet
        ,:Compte.CompteComplet.RacineCompte
        ,:Compte.TypeCompte
        ,:Compte.CleRib
        ,:Compte.Debit
        ,:Compte.Credit
        ,:Client.CodeClient)
end-exec.
```

## Déclaration du curseur (Init)

```cbl
exec sql
    declare C-ListeBanque cursor for
        select CodeBanque, NomBanque
        from Banque
        order by NomBanque
end-exec.
```

## Ouverture du curseur (Init)

```cbl
exec sql
    open C-ListeBanque
end-exec.
```

## Parcours de la table (Traitement)

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

## Fermeture du curseur (Fin)

```cbl
exec sql
    close C-ListeBanque
end-exec.
```