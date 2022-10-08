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