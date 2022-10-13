       program-id. Gestion.

       Environment division.
       Input-Output Section.
       File-Control.
           select F-ListeCompteClient
           assign to "C:\Users\dugs\Documents\ListeCompteClient.csv"
           organization Line Sequential.

           select F-ControleCleRIB
           assign to "C:\Users\dugs\Documents\ListeCleRib.txt"
           organization line sequential
           access sequential.

       data division.
       File section.
       FD F-ListeCompteClient record varying from 0 to 255.
       01 E-ListeCompteClient pic X(255).

       FD F-ControleCleRIB record varying from 0 to 255.
       01 E-ControleCleRIB pic X(255).

       working-storage section.

       01 DateSysteme.
         10 Annee Pic 9(4).
         10 Mois Pic 9(2).
         10 Jour Pic 9(2).

      * --- Tables de la base de donn�es ---

       01 CLIENT.
         10 CodeClient PIC X(36).
         10 Intitule sql char (5).
         10 Nom sql CHAR-VARYING (50).
         10 Prenom sql CHAR-VARYING (50).
         10 CodePostal sql CHAR (5).
         10 Ville sql CHAR-VARYING (50).

       01 COMPTE.
         10 CodeBanque sql CHAR (5).
         10 CodeGuichet sql CHAR (5).
         10 CompteComplet.
           20 RacineCompte sql CHAR (9).
           20 TypeCompte sql CHAR (2).
         10 CleRIB sql CHAR (2).
         10 Debit PIC 9(8)V99.
         10 Credit PIC 9(8)V99.
         10 CodeClient PIC X(36).

       01 Banque.
         10 CodeBanque sql char (5).
         10 NomBanque sql char-varying (255).

      * --- Lignes de l'�tat de contr�le des cl�s RIB ---

       01 LigneEntete1.
         10 Filler pic X(6) value " Serfa".
         10 Filler pic X(35).
         10 Filler pic X(28) value "Liste des cles RIB corrigees".
         10 Filler pic X(26).
         10 Filler pic X(7) value "Date : ".
         10 Jour pic 99.
         10 Filler pic X value "/".
         10 Mois pic 99.
         10 Filler pic X value "/".
         10 Annee pic 99.

       01 LigneEntete2.
         10 Filler pic X(42).
         10 Filler pic X(28) value all "=".

       01 LigneEntete4.
         10 Filler pic X.
         10 Filler pic X(109) value all "-".

       01 LigneEntete6.
         10 Filler pic X(74).
         10 Filler pic X(36)
         value "Code     No de     Ancienne Nouvelle".

       01 LigneEntete7.
         10 Filler pic X(7) value " Client".
         10 Filler pic X(35).
         10 Filler pic X(6) value "Banque".
         10 Filler pic X(25).
         10 Filler pic X(37) value
         "guichet   compte     cle RIB  cle RIB".

       01 LigneBasPage.
         10 Filler pic X(10) value " --- Page ".
         10 NPage pic Z9.
         10 Filler pic X.
         10 Filler pic X(85) value all "-".
         10 Filler pic X(13) value " A suivre ---".

       01 DernierBasPage.
         10 Filler pic X(10) value " --- Page ".
         10 NPage pic Z9.
         10 Filler pic X.
         10 Filler pic X(97) value all "-".

       01 LigneDetail.
         10 Filler pic X.
         10 NomClient pic X(40).
         10 Filler pic X.
         10 NomBanque pic X(30).
         10 Filler pic XX.
         10 CodeGuichet pic X(5).
         10 Filler pic X.
         10 CompteComplet.
           20 RacineCompte pic X(9).
           20 Filler pic X.
           20 TypeCompte pic X(2).
         10 Filler pic X(5).
         10 CleRib pic XX.
         10 Filler pic X(6).
         10 NouvelleCleRib pic XX.

      * Structure de la MAJ d'un client

      * Variables locales

       77 Option Pic 9.
       77 Eof Pic 9.
       77 Eot Pic 9.
       77 DerniereZone pic X(50).
       77 NoLigneBanque pic 99.
       77 Reponse pic X.
       77 PrenomNom sql char-varying (60).

      * D�clarations li�es au contr�le de la cl� RIB

       77 CompteCompletNum Pic 9(11).
       77 CodeBanqueNum Pic 9(5).
       77 CodeGuichetNum Pic 9(5).
       77 CleRibNum Pic 99.
       77 TotalIntermediaire Pic 9(13).
       77 TotalCalcule Pic 9(13).
       77 CleRibTrouve Pic XX.

      * Déclarations des variables pour la gestion des clients
       77 NomSelectionne Pic X(25).
       77 RechercheCompteClientEof Pic 9.
       77 NoLigneCompte Pic 99.
       77 NoLigneCompteAux Pic 99.
       77 MaxCompte Pic 99.
       77 MaxSupprime Pic 99.
       77 NoLigneEcran Pic 99.
       77 MaxLigne Pic 99.
       77 DimTableau pic 99 value 11.
       77 NoLigneTitre Pic 99 value 8.
       77 CEstBon pic 9.
       77 Valeur Pic X(30).
       77 NbLigneTrouve Pic 99. 

      * D�clarations li�es au contr�le de la pagination

       77 NbLigne pic 99.
       77 NoPage pic 99.
       77 MaxLigneEtat pic 99 value 36.

      * D�clarations li�es � SQL

       77 CNXDB STRING.
           EXEC SQL
               INCLUDE SQLCA
           END-EXEC.

           EXEC SQL
               INCLUDE SQLDA
           END-EXEC.

       77 Trusted PIC X(22) value "Trusted_Connection=yes".
       77 Database PIC X(17) value "Database=Papillon".
       77 DBServer PIC X(28) value "server=SRF-DUGS13\SQLEXPRESS".
       77 DBFactory PIC X(29) value "factory=System.Data.SqlClient".

      * --- Param�trage des couleurs de l'ecran ---

       77 CouleurFondEcran pic 99 value 15.
       77 CouleurCaractere pic 99 value 0.
      *77 CouleurFondEcran         pic 99 value 1  .
      *77 CouleurCaractere         pic 99 value 14.

      * --- Ecrans de l'application ---

       Screen section.

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

       01 ListeBanque-E background-color is CouleurFondEcran
       foreground-color is CouleurCaractere.
         10 line 1 col 1 blank screen.
         10 line 3 col 32 value "LISTE DES BANQUES".
         10 line 5 col 1 reverse-video pic X(80) value " Code   Nom".

       01 LigneBanque.
         05 line NoLigneBanque col 2
         from CodeBanque of Banque.
         05 line NoLigneBanque col 8 pic X(72)
         from NomBanque of Banque.

      **********************************************************************
      * Ecrans pour la mise à jour des clients
      **********************************************************************

       01 M-GestionClient background-color is CouleurFondEcran foreground-color 
         10 line 1 col 1 blank screen.
         10 Line 3 Col 31 value "Gestion des clients".
         10 Line 5 Col 1 Value " Nom ........... :".
         10 Line 5 Col 46 Value " Prenom ... :".
         10 Line 6 Col 1 Value " Code postal ... :".
         10 Line 6 Col 46 Value " Ville .... :".
         10 background-color is CouleurCaractere foreground-color is CouleurFond
           20 Line 8 Col 1 pic x(80).
           20 Line 8 Col 1 value "No".
           20 Line 8 Col 4 value "Banque".
           20 Line 8 Col 30 value "Guichet".
           20 Line 8 Col 38 value "Compte".
           20 Line 8 Col 51 value "Cle".
           20 Line 8 Col 56 value "Debit".
           20 Line 8 Col 68 value "Credit".

       01 M-GestionClient-E background-color is CouleurFondEcran foreground-colo
         10 Line 5 Col 20 using Nom of Client pic X(20).
         10 Line 5 Col 60 using Prenom of Client pic X(20).
         10 Line 6 Col 20 using CodePostal of Client.
         10 Line 6 Col 60 using Ville of Client pic X(20).

       01 M-GestionClient-L background-color is CouleurFondEcran foreground-colo
         20 Line NoLigneEcran Col 1 from NoLigneCompte.
         20 Line NoLigneEcran Col 4 using CodeBanque of ValeurLigne of LigneComp
         20 Line NoLigneEcran Col 10 pic x(19) from NomBanque of ValeurLigne of 
         20 Line NoLigneEcran Col 30 using CodeGuichet of ValeurLigne of LigneCo
         20 Line NoLigneEcran Col 38 using RacineCompte of ValeurLigne of LigneC
         20 Line NoLigneEcran Col 48 using TypeCompte of ValeurLigne of LigneCom
         20 Line NoLigneEcran Col 51 from CleRib of LigneCompte(NoLigneCompte).
           20 Line NoLigneEcran Col 54 pic Z(8)9V,99 using Debit of LigneCompte(
           20 Line NoLigneEcran Col 67 pic Z(8)9V,99 using Credit of LigneCompte

       01 M-GestionClient-QC background-color is CouleurFondEcran foreground-col
         10 line 1 col 1 erase EOL.
         10 line 1 col 1 value " Voulez-vous le creer (o/N) :" background-color 

       01 M-GestionClient-QM background-color is CouleurFondEcran foreground-col
         10 line 1 col 1 erase EOL.
         10 line 1 col 1 value " Voulez-vous terminer, le modifier ou le supprim

       01 M-EffaceQuestion Background-Color is CouleurFondEcran.
         10 line 1 col 1 pic x(80).

       01 M-EffaceMessage Background-Color is CouleurFondEcran.
         10 line 25 col 1 pic x(80).

       01 M-EffaceLigne Background-Color is CouleurFondEcran.
         10 line NoLigneEcran col 1 pic x(80).

       01 M-GestionClient-Menu background-color is CouleurFondEcran foreground-c
         10 line 20 col 1 erase EOS.
         10 line 20 col 1 pic x(80) value all "_".
         10 line 21 col 1 value "-1-Ajout d'un compte ...............:" foregrou
         10 line 22 col 1 value "-2-Modification compte, ligne No    :" foregrou
         10 line 23 col 1 value "-3-Suppression compte, ligne No    .:" foregrou
         10 line 21 col 39 value "-4-Modification de l'entete :".
         10 line 22 col 39 value "-A-Annulation ............. :".
         10 line 23 col 39 value "-V-Validation ............. :" foreground-colo
         10 line 23 col 69 value "Option :".

       procedure division.
      ************************************************************
      ************************************************************
      *    Gestion du menu
      ************************************************************
      ************************************************************
       Menu.
           perform Menu-Init.
           perform Menu-trt until Option = 0.
           perform Menu-Fin.
       Menu-Init.
           Move 1 to Option.

      ********* Connexion � la base de donn�es

           string
             Trusted delimited by size
             ";" delimited by size
             Database delimited by size
             ";" delimited by size
             DBServer delimited by size
             ";" delimited by size
             DBFactory delimited by size
             ";" delimited by size
             into cnxdb.

           exec sql
               connect using :cnxDb
           end-exec.

      * Absence d'erreur de connexion (0)

           if (sqlcode not equal 0) then
               stop run
           end-if.

      * MAJs automatiques de la BDD

           exec sql
               SET AUTOCOMMIT ON
           end-exec.

       Menu-Trt.
           Accept DateSysteme From date yyyymmdd.

           Move 0 to Option.

           Display LeMenu.

           accept Option Line 5 Col 79.

           evaluate Option
               when 1
                   perform Importation
               when 2
                   perform ListeBanque
               when 3
                   perform ListeCompte
               when 4
                   perform ControleCleRIB
               when 5
                   perform MajClient
           end-evaluate.
       Menu-Fin.
           stop run.

      **************************************************************************
      * Importation du fichier
      **************************************************************************
       Importation.
           perform lectureFichier-Init.

      * On lit les lignes tant qu'on n'est pas � la fin du fichier
           perform lectureFichier-Trt until eof = 1.

      * On fait les traitements de fin de l'importation
           perform lectureFichier-Fin.

      * ------------------------------------------------------------------------
      * Initialisations de l'importation
      * ------------------------------------------------------------------------
       lectureFichier-Init.
      * Par d�faut, on n'est pas � la fin du fichier
           move 0 to eof.

      * on ouvre le fichier en lecture (input)
           open input F-ListeCompteClient.
           read F-ListeCompteClient.

      * ------------------------------------------------------------------------
      * Lecture d'une ligne du fichier
      * ------------------------------------------------------------------------
       lectureFichier-Trt.
      * lire l'enregistrement
           read F-ListeCompteClient
               at end
                   move 1 to Eof
               not at end
                   perform ImportLigne
           end-read.

       lectureFichier-Fin.
      * fermer le fichier
           close F-ListeCompteClient.

      * ----------------------------------
      * Importation d'une ligne de compte
      * ----------------------------------
       ImportLigne.

      * On  �clate la ligne du CSV grace au signe ";"
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

           unstring DerniereZone delimited by " " into
             Credit of Compte
           end-unstring.

           divide 100 into Debit of COMPTE.
           divide Credit of COMPTE by 100 giving Credit of COMPTE.

      * --------------------------------------------------------------------
      * Alimentation de la base SQL Server
      * --------------------------------------------------------------------

      * On regarde si le client existe

           move space to CodeClient of CLIENT.

           exec sql
               select CodeClient
               into :Client.CodeClient
               from Client
               where Nom = :Client.Nom
           end-exec.

      * Si je n'ai pas trouv� le client, je le cr�e

           if (CodeClient of CLIENT = " ") then
               exec sql
                   select newid() into :Client.CodeClient
               end-exec

      * Alimentation de la table client

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

      * Alimentation du compte

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

      * --- Liste des banques ---

       ListeBanque.
           perform ListeBanque-Init.
           perform ListeBanque-Trt until Eot = 1.
           perform ListeBanque-Fin.

       ListeBanque-Init.
           move 0 to Eot.

      * D�claration du curseur

           exec sql
               declare C-ListeBanque cursor for
                   select CodeBanque, NomBanque
                   from Banque
                   order by NomBanque
           end-exec.

      * Ouverture du curseur

           exec sql
             open C-ListeBanque
           end-exec.

      * Initialisation de la pagination

           display ListeBanque-E.

           move 5 to NoLigneBanque.

       ListeBanque-Trt.
           exec sql
             fetch C-ListeBanque
             into :Banque.CodeBanque, :Banque.NomBanque
           end-exec.

           if (sqlcode not equal 0 and sqlcode not equal 1) then
               move 1 to Eot

      *        display "Fin de la liste. Tapez ENTREE " line 1 col 1
      *        accept Option
           else
               perform AffichageBanque
           end-if.

       ListeBanque-Fin.
           exec sql
             close C-ListeBanque
           end-exec.

       AffichageBanque.
           add 1 to NoLigneBanque.

           display LigneBanque.

           if NoLigneBanque equal 23
               display " Page [S]uivante - [M]enu : S"
               line 1 col 1
               with no advancing

               move "S" to Reponse

               accept Reponse line 1 col 29

               if Reponse = "M"
                   move 1 to Eot
               else
                   move 5 to NoLigneBanque
               end-if
           end-if.

      * --- Liste des comptes ---

       ListeCompte.
           perform ListeCompte-Init.
           perform ListeCompte-Trt until Eot = 1.
           perform ListeCompte-Fin.

       ListeCompte-Init.
           move 0 to Eot.

      * D�claration du curseur

           exec sql
               declare C-ListeCompte cursor for
                   select CodeBanque, CodeGuichet, NoCompte, TypeCompte,
                   CleRib, Debit, Credit, CodeClient
                   from Compte
                   order by CodeBanque
           end-exec.

      * Ouverture du curseur

           exec sql
             open C-ListeCompte
           end-exec.

       ListeCompte-Trt.
           exec sql
             fetch C-ListeCompte
             into :Compte.CodeBanque, :Compte.CodeGuichet
           end-exec.

           if (sqlcode not equal 0 and sqlcode not equal 1) then
               move 1 to Eot
           else
               perform AffichageCompte
           end-if.

       ListeCompte-Fin.
           exec sql
             close C-ListeCompte
           end-exec.

       AffichageCompte.
           add 1 to NoLigneBanque.

           display LigneBanque.

           if NoLigneBanque equal 23
               display " Page [S]uivante - [M]enu : S"
                 line 1 col 1
                 with no advancing

               move "S" to Reponse

               accept Reponse line 1 col 29

               if Reponse = "M"
                   move 1 to Eot
               else
                   move 5 to NoLigneBanque
               end-if
           end-if.

      * --- Contr�le des cl�s RIB ---

       ControleCleRIB.
           perform ControleCleRIB-Init.
           perform ControleCleRIB-Trt until Eot = 1.
           perform ControleCleRIB-Fin.

      * Initialisations

       ControleCleRIB-Init.
           move 0 to Eot.

      * D�claration du curseur

           exec sql
               declare C-ControleCleRib cursor for
                   select CodeBanque, CodeGuichet, NoCompte,
                   TypeCompte, CleRib, PrenomNom, NomBanque
                   from VueControleRib
           end-exec.

      * Ouverture du curseur

           exec sql
             open C-ControleCleRib
           end-exec.

      * Initialisation de la pagination

           move 0 to NoPage.

           add 1 to MaxLigneEtat giving NbLigne.

           move corresponding DateSysteme to LigneEntete1.

      * Traitement des lignes (RIB)

       ControleCleRIB-Trt.
           exec sql
               fetch C-ControleCleRib
               into :Compte.CodeBanque, :Compte.CodeGuichet,
               :Compte.CompteComplet.RacineCompte,
               :Compte.CompteComplet.TypeCompte,
               :Compte.CleRib, :PrenomNom, :Banque.NomBanque
           end-exec.

           if (sqlcode not equal 0 and sqlcode not equal 1)
               move 1 to Eot
           else
               perform TraitementCleRib
           end-if.

      * Fin du traitement (RIB)

       ControleCleRIB-Fin.

      * On ferme le curseur

           exec sql
             close C-ListeBanque
           end-exec.

      * Impression du dernier pied de page

           if NoPage > 0 then
               move NoPage to NPage of DernierBasPage

               write E-ControleCleRIB from DernierBasPage

               close F-ControleCleRIB
           end-if.
             
      * --- Calcul de la cl� RIB ---

       TraitementCleRib.
           move CompteComplet of Compte to CompteCompletNum.
           move CodeGuichet of COMPTE to CodeGuichetNum.
           move CodeBanque of COMPTE to CodeBanqueNum.

           perform CalculCleRib.

           move CleRibNum to CleRibTrouve.

      * MAJ de la ligne de compte

           if CleRibTrouve <> CleRIB of COMPTE then
               exec sql
                 update Compte set CleRib = :CleRibTrouve
                 where CodeBanque = :Compte.CodeBanque and
                       CodeGuichet = :Compte.CodeGuichet and
                       NoCompte = :Compte.CompteComplet.RacineCompte and
                       TypeCompte = :Compte.CompteComplet.TypeCompte
               end-exec
           end-if.

           perform ImpressionControleCleRib.

      * --- Impression de la liste de contr�le des cl�s RIB ---

       ImpressionControleCleRib.
      * Impression du pied de page sauf la page 0 o� on ouvre le fichier

           if NbLigne > MaxLigneEtat then
               if NoPage = 0 then
                   open output F-ControleCleRIB
               else
                   move NoPage to NPage of LigneBasPage

                   write E-ControleCleRIB from LigneBasPage
               end-if

      * Impression de l'en-t�te de page

               add 1 to NoPage

               write E-ControleCleRIB from LigneEntete1
               write E-ControleCleRIB from LigneEntete2
               write E-ControleCleRIB from " "
               write E-ControleCleRIB from LigneEntete4
               write E-ControleCleRIB from LigneEntete6
               write E-ControleCleRIB from LigneEntete7
               write E-ControleCleRIB from LigneEntete4

               move 7 to NbLigne
           end-if.

      * Impression de la ligne d�tail

           add 1 to NbLigne.

           move corresponding COMPTE to LigneDetail.
           move PrenomNom to NomClient of LigneDetail.
           move NomBanque of Banque to NomBanque of LigneDetail.
           move CleRibTrouve to NouvelleCleRib of LigneDetail.

           write E-ControleCleRIB from LigneDetail.

      * --- Calcul de la cl� RIB ---

       CalculCleRib.
           multiply CompteCompletNum by 3 giving TotalCalcule.
           multiply CodeGuichetNum by 15 giving TotalIntermediaire.

           add TotalIntermediaire to TotalCalcule.

           multiply CodeBanqueNum by 89 giving TotalIntermediaire.

           add TotalIntermediaire to TotalCalcule.

           divide TotalCalcule by 97 giving TotalIntermediaire
           remainder CleRibNum.

           subtract CleRibNum from 97 giving CleRibNum.

      * --- Gestion du client ---

       MajClient.
           perform SaisieNom-Init.
           perform SaisieNom-Trt until NomSelectionne = space.
           perform SaisieNom-Fin.

       SaisieNom-Init.
           move "" to NomSelectionne.
       SaisieNom-Trt.
           move space to NomSelectionne.

           display M-GestionClient.

           accept NomSelectionne line 5 col 20.

           if NomSelectionne <> space
               perform TraitementClient
           end-if.

       SaisieNom-Fin.
           continue.

       TraitementClient.
           perform RechercheCompteClient-Init.
           perform RechercheCompteClient-Trt until Eof = 1.
           perform RechercheCompteClient-Fin.

      * --- Recherche info client + compte ---

       RechercheCompteClient-Init.
           move 0 to Eof.

           exec sql
             declare C-VueCompteClient cursor for
             select CodeClient, Nom, Prenom, CodePostal,
             Ville, CodeBanque, CodeGuichet, NoCompte,
             TypeCompte, CleRib, Debit, Credit
             from VueCompteClient
             where Nom = :NomSelectionne
             order by CodeBanque, CodeGuichet, NoCompte, TypeCompte
           end-exec.

       RechercheCompteClient-Trt.
           exec sql
             fetch C-VueCompteClient into :Client.CodeClient,
              :Client.Nom, :Client.Prenom,
              :Client.CodePostal, :Client.Ville,
              :LigneCourante.CodeBanque, :LigneCourante.NomBanque,
              :LigneCourante.CodeGuichet, :LigneCourante.RacineCompte,
              :LigneCourante.TypeCompte, :LigneCourante.CleRib,
              :LigneCourante.Debit, :LigneCourante.Credit
           end-exec.

           if SQLCODE = 0 or SQLCODE = 1 then
               perform TraitementCompte
           else
               move 1 to Eof
           end-if.

       RechercheCompteClient-Fin.
           exec sql
             close C-VueCompteClient
           end-exec.

      * --- Traitement d'une ligne de compte ---

       TraitementCompte.
      * Alimentation d'un tableau des lignes 
           add 1 to NoLigneCompte.

           move NoLigneCompte to MaxCompte.

           move corresponding LigneCourante 
           to LigneCompte(NoLigneCompte).
           move corresponding LigneCourante to CleBase
           of LigneCompte(NoLigneCompte).
           move corresponding LigneCourante to ValeurLigne 
           of LigneCompte(NoLigneCompte).

      * Sur la premiere ligne on affiche l'entete de l'écran
           if NoLigneCompte = 1 then
               display M-GestionClient-E
           end-if.

      * Affichage de la ligne à l'écran
           add 1 to NoLigneEcran.
           
           move NoLigneEcran to MaxLigne.
           
           display M-GestionClient-L.

      * --- Sélection du traitement ---

      * S'il n'y a pas de compte on propose à l'utilisateur de 
      * renseigner les données du client

           if MaxCompte = 0 then
               display M-GestionClient-QC
               
               move "N" to ChoixGestionClient
               
               accept ChoixGestionClient line 1 col 31
               
               if ChoixGestionClient = "o" then
                   move "O" to ChoixGestionClient
               end-if
           else
               display M-GestionClient-QM
               
               move "T" to ChoixGestionClient
               
               accept ChoixGestionClient line 1 col 62
               
               if ChoixGestionClient = "m" then
                   move "M" to ChoixGestionClient
               end-if

               if ChoixGestionClient = "s" then
                   move "S" to ChoixGestionClient
               end-if
           end-if.

           display M-EffaceQuestion.

           evaluate ChoixGestionClient
               when "O"
                   move NomSelectionne to Nom of CLIENT

                   exec sql
                       select newid() into :Client.CodeClient
                   end-exec
                   
                   perform MajInfoClient

               when "M"
                   perform MajInfoClient
               when "S"
                   perform SuppressionClient
           end-evaluate.

      * --- MAJ des informations du client ---

       MajInfoClient.
           perform MajInfoClient-init.
           perform MajInfoClient-trt 
           until OptionMaj = "V" or OptionMaj = "A".
           perform MajInfoClient-Fin.

       MajInfoClient-Init.
           move " " to OptionMaj.

       MajInfoClient-Trt.
      * Initialisation de l'affichage des options de menu

           if MaxCompte = 0 then
               move CouleurFondEcran to ModificationForeGround
               move CouleurFondEcran to ValidationForeGround
           else
               move CouleurCaractere to ModificationForeGround
               move CouleurCaractere to ValidationForeGround
           end-if.

           if MaxCompte < 2 then
               move CouleurFondEcran to SuppressionForeGround
           else
               move CouleurCaractere to SuppressionForeGround
           end-if.

           if MaxCompte = DimTableau then
               move CouleurFondEcran to CreationForeGround
           else
               move CouleurCaractere to CreationForeGround
           end-if.

      * Affichage du menu

           display M-GestionClient-Menu.
      
      * Saisie de l'option de gestion
      
           move " " to OptionMaj.
      
           accept OptionMaj line 23 col 78.
      
           if OptionMaj = "a"
               move "A" to OptionMaj.

           if OptionMaj = "v"
               move "V" to OptionMaj.

           evaluate OptionMaj
               when "1"
                   perform AjoutLigne

               when "2"
                   perform ModificationLigne

               when "3"
                   move 0 to NoLigneCompte
                   if MaxCompte > 0 then
                       accept NoLigneCompte line 23 col 33

                       if NoLigneCompte > 0 and 
                       NoLigneCompte <= MaxCompte then
                           perform SuppressionLigne
                       end-if
                   end-if

               when "4"
      *            perform MajEnteteClient

               when "V"
                   if MaxCompte > 0 then
                       perform MajClientDatabase

           end-evaluate.

       MajInfoClient-Fin.
           continue.

      * --- Ajout d'un nouveau compte ---

       AjoutLigne.
      * On ne peut faire l'ajout que s'il y a moins de 11 lignes

           if MaxCompte < 11 then

      * Positionnement sur l'écran et il y aura une ligne de plus à l'écran

              add 1 to MaxLigne
   
              move MaxLigne to NoligneEcran

      * Positionnement dans le tableau et initialisation de la ligne
      * Pour mémoire, c'est la ligne saisie

              add 1 to MaxCompte
         
              move MaxCompte to NoLigneCompte
         
              initialize LigneCompte(NoLigneCompte)

      * On va saisir la ligne
               perform MiseAJourLigne
           end-if.

      * --- Choix de l'option de traitement via les questions ---

      * --- Supprimer le client ---

       SupprimerClient.

       SupprimerClient-Init.

       SupprimerClient-Trt.

       SupprimerClient-Fin.

      

      * --- Alimenter la base de donn�es ---

       end program.