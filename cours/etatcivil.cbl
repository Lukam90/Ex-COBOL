       IDENTIFICATION DIVISION.
       PROGRAM-ID. Etat-Civil.
       AUTHOR. Lucien HAMM.
       DATE-WRITTEN. 03/10/2022

       DATA DIVISION.

       WORKING-STORAGE SECTION.
       77 NomPrenomComplet PIC X(50).

       01 EtatCivil.
           02 Intitule PIC X(10).
           02 Prenom PIC X(20).
           02 Nom PIC X(20).

       PROCEDURE DIVISION.
           DISPLAY "Intitule (Mr, Mme, Mlle) : " WITH
           NO ADVANCING.
           ACCEPT Intitule IN EtatCivil.

           DISPLAY "Prenom : " WITH NO ADVANCING.
           ACCEPT Prenom IN EtatCivil.

           DISPLAY "Nom : " WITH NO ADVANCING.
           ACCEPT Nom IN EtatCivil.

           STRING
               Intitule DELIMITED BY SPACE
               " " DELIMITED BY SIZE
               Prenom DELIMITED BY SPACE
               " " DELIMITED BY SIZE
               Nom DELIMITED BY SPACE
               INTO NomPrenomComplet
           END-STRING.

           DISPLAY "Nom Complet : " NomPrenomComplet.
           STOP RUN.
