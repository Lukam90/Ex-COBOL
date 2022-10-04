       IDENTIFICATION DIVISION.
       PROGRAM-ID. '4-Accept'.
       AUTHOR. Lucien HAMM.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 Nom PIC X(12).
           
       PROCEDURE DIVISION.
           DISPLAY "Quel est ton nom ? ".

           ACCEPT Nom.

           DISPLAY "Et bien salut à toi " Nom.

           STOP RUN.
