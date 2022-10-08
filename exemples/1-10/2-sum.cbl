       identification division.
       program-id. 2-sum.
       author. Lucien HAMM.

       environment division.

       data division.

       working-storage section.
       01 Num1 pic 9 value zeros.
       01 Num2 pic 9 value zeros.
       01 Total pic 99 value 0.

       procedure division.
           display "Enter 2 values to sum".
           
           accept Num1.
           accept Num2.

           compute Total = Num1 + Num2.

           display Num1 " + " Num2 " = " Total.
           
           stop run.