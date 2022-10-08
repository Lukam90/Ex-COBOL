       IDENTIFICATION DIVISION.
       PROGRAM-ID. 16-conversion.
       AUTHOR. Lucien HAMM.
       
       data division.
       
       WORKING-STORAGE SECTION.
       01 ChangeMe.
           02 TextNum PIC X(6).
           02 FloatNum REDEFINES TextNum PIC 9(4)V99.

       01 StrNum PIC X(7).

       01 SplitNum.
           02 WNum PIC 9(4) VALUE ZERO.
           02 FNum PIC 99 VALUE ZERO.

       01 FlNum REDEFINES SplitNum PIC 9999V99.
       01 DollarNum PIC $$,$$9.99.

       PROCEDURE DIVISION.
           MOVE "123456" TO TextNum.
           DISPLAY "FloatNum = " FloatNum.

           DISPLAY "Enter a float : " WITH NO ADVANCING.
           ACCEPT StrNum.

           UNSTRING StrNum
           DELIMITED BY "." OR ALL SPACES 
           INTO WNum, FNum.

           MOVE FlNum TO DollarNum.

           DISPLAY "DollarNum = " DollarNum.

           STOP RUN.
