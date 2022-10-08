       IDENTIFICATION DIVISION.
       PROGRAM-ID. 8-loops.
       AUTHOR. Lucien HAMM.

       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.

       data division.
       file section.
       WORKING-STORAGE SECTION.
       01 Ind pic 9 VALUE 0.

       PROCEDURE DIVISION.
           PERFORM ForLoop.

       OutputData.
           DISPLAY Ind.

           ADD 1 TO Ind.

       ForLoop.
           PERFORM OutputData VARYING Ind FROM 1 BY 1 UNTIL Ind = 5.

           STOP RUN.