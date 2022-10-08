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
