       identification division.
       program-id. 1-input.
       author. Lucien HAMM.

       environment division.

       data division.

       working-storage section.
       01 Username pic a(20).

       procedure division.
           display "What is your name ? " with no advancing.
           
           accept Username.

           display "Hello " Username.
       
           stop run.