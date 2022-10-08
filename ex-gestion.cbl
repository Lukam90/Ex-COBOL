       IDENTIFICATION DIVISION.
       PROGRAM-ID. ex-gestion.
       AUTHOR. Lucien HAMM.

      * Reprise du code en mode "universel" 
      * (ex : indépendant de Visual Studio et MS Server)

       ENVIRONMENT DIVISION. 
       INPUT-OUTPUT SECTION. 
       FILE-CONTROL. 
           select F-Clients ASSIGN TO "data/Clients.csv"
           organization line sequential.

       DATA DIVISION. 
       FILE SECTION. 
       FD F-Clients RECORD VARYING from 0 to 255.
       01 E-Clients pic X(255).

       WORKING-STORAGE SECTION. 

       01 DateSysteme.
           10 Annee pic 9(4).
           10 Mois pic 9(2).
           10 Jour pic 9(2).

      * Tables de la base de données

       01 Client.
           10 CodeClient PIC X(36).
           10 Intitule pic X(5).
           10 Nom pic X(50).
           10 Prenom pic X(50).
           10 CodePostal pic X(5).
           10 Ville pic X(50).

       01 Compte.
           10 CodeBanque pic X(5).
           10 CodeGuichet pic X(5).
           10 CompteComplet.
              20 RacineCompte pic X(9).
              20 TypeCompte pic X(2).
           10 CleRIB pic X(2).
           10 Debit PIC 9(8)V99.
           10 Credit PIC 9(8)V99.
           10 CodeClient PIC X(36).

       01 Banque.
           10 CodeBanque pic X(5).
           10 NomBanque pic X(255).
          
       77 Option Pic 9.
       77 Eof Pic 9.
       77 Eot Pic 9.
       77 DerniereZone pic X(50).

      * Déclarations liées à SQL

       77 CNXDB STRING.
           EXEC SQL
               INCLUDE SQLCA
           END-EXEC.

           EXEC SQL
               INCLUDE SQLDA
           END-EXEC.

      * Couleurs de l'écran

      * 77 CouleurFondEcran pic 99 value 15.
      * 77 CouleurCaractere pic 99 value 0.

      * Ecrans de l'application

      * screen section.

      * 01 LeMenu background-color is CouleurFondEcran foreground-color
      * is Couleur
      *   10 line 1 col 1 Blank Screen.
      *   10 line 3 col 32 value " GESTION BANCAIRE ".
      *   10 line 5 col 2 value " Date systeme :".
      *   10 line 5 col 18 from Jour of DateSysteme.
      *   10 line 5 col 20 value "/".
      *   10 line 5 col 21 from Mois of DateSysteme.
      *   10 line 5 col 23 value "/".
      *   10 line 5 col 24 from Annee of DateSysteme.
      *   10 line 5 col 69 value " Option :".
      *   10 line 5 col 79 pic 9 from Option.
      *   10 line 8 col 5 value "- 1 - Importation des comptes ...".
      *   10 line 9 col 5 value "- 2 - Liste des banques ...".
      *   10 line 10 col 5 value "- 3 - Liste des comptes ...".
      *   10 line 11 col 5 value "- 4 - Controle des cles RIB ...".
      *   10 line 12 col 5 value "- 5 - Gestion des clients ...".
      *   10 line 14 col 5 value "- 0 - Fin de traitement ...".

       PROCEDURE DIVISION.

      * === Gestion du menu ===

       Menu.
           PERFORM Menu-Init.
           PERFORM Menu-Trt UNTIL Option = 0.
           PERFORM Menu-Fin.

       Menu-Init.
           MOVE 1 to Option.

      * Connexion à la base de données

           move "" to CNXDB.

           exec sql
              connect to :CNXDB
           end-exec.

           if (sqlcode not equal 0) then
               stop run
           end-if.

           exec sql
               set autocommit on
           end-exec.

       Menu-Trt.
           ACCEPT DateSysteme from date YYYYMMDD.

           MOVE 0 to Option.

           DISPLAY " ".

           DISPLAY " GESTION BANCAIRE "
           
           DISPLAY "Date systeme : " Jour of DateSysteme "/"
           Mois of DateSysteme "/"
           Annee of DateSysteme.

           DISPLAY "Option : " WITH NO ADVANCING.

           DISPLAY "1 - Importation des comptes..."
           DISPLAY "2 - Liste des banques..."
           DISPLAY "3 - Liste des comptes..."
           DISPLAY "4 - Controle des cles RIB..."
           DISPLAY "5 - Gestion des clients..."
           DISPLAY "0 - Fin de traitement..."

           ACCEPT Option.

           EVALUATE Option 
              WHEN 1 PERFORM Importation
              WHEN 2 PERFORM ListeBanque
           end-evaluate.
       
       Menu-Fin.
           stop run.

      * Importation du fichier

       Importation.
           PERFORM LectureFichier-Init.
           PERFORM LectureFichier-Trt UNTIL Eof = 1.
           PERFORM LectureFichier-Fin.

      * Initialisations de l'importation

       LectureFichier-Init.
           move 0 to Eof.

      * Ouverture du fichier en lecture (input)

           open input F-Clients.
           read F-Clients.    

      * Lecture d'une ligne de fichier

       LectureFichier-Trt.
           READ F-Clients
           at end
              move 1 to Eof
           not at end
              PERFORM ImportLigne
           end-read.   

      * Fermeture du fichier

       LectureFichier-Fin.
           CLOSE F-Clients.    

      * Importation d'une ligne de compte

       ImportLigne.
           CONTINUE.

      * Alimentation de la table des comptes

       exec sql
           insert into Compte (
              CodeBanque, 
              CodeGuichet, 
              NoCompte, 
              TypeCompte, 
              CleRib,
              Debit,
              Credit,
              CodeClient)
           values (
              :Compte.CodeBanque, 
              :Compte.CodeGuichet, 
              :Compte.NoCompte, 
              :Compte.TypeCompte, 
              :Compte.CleRib, 
              :Compte.Debit, 
              :Compte.Credit, 
              :Client.CodeClient 
           )
       end-exec.

      * Liste des banques

       ListeBanque.
           PERFORM ListeBanque-Init.
           PERFORM ListeBanque-Trt UNTIL Eot = 1.
           PERFORM ListeBanque-Fin.

       ListeBanque-Init.
           MOVE 0 to Eot.

      * Déclaration du curseur

       exec sql
           declare C-Banques cursor for
           select CodeBanque, NomBanque from Banque
           order by NomBanque
       end-exec.        

      * Ouverture du curseur

       exec sql
           open C-Banques
       end-exec.

      * Initialisation de la pagination

       display E-Banques

       move 5 to NoLigne.

       ListeBanque-Trt.
           EXEC SQL 
              fetch C-Banques 
              into :Banque.CodeBanque, :Banque.NomBanque
           end-exec.

           if (sqlcode not equal 0 and sqlcode not equal 1)
              move 1 to Eot

      *        DISPLAY "Fin de la liste. Tapez ENTREE."

      *        ACCEPT Reponse.
           else
              PERFORM AffichageBanque
           end-if.

       ListeBanque-Fin.
           EXEC SQL 
              close C-Banques
           end-exec.

       AffichageBanque.
           CONTINUE.
