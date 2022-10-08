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
