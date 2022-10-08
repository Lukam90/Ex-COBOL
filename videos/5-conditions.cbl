       IDENTIFICATION DIVISION.
       PROGRAM-ID. 5-conditions.
       AUTHOR. Lucien HAMM.

       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION. 
       SPECIAL-NAMES. 
           class PassingScore IS "A" THRU "C", "D".

       data division.
       file section.
       WORKING-STORAGE SECTION. 
       01 Age pic 99 value 0.
       01 Grade pic 99 value 0.
       01 Score pic X(1) value "B".
       01 CanVoteFlag PIC 9 value 0.
           88 CanVote value 1.
           88 CantVote value 0.
       01 TestNumber pic X.
           88 IsPrime value "1", "3", "5", "7".
           88 IsOdd value "1", "3", "5", "7", "9".
           88 IsEven value "2", "4", "6", "8".
           88 LessThan5 value "1" THRU "4".
           88 ANumber value "0" THRU "9".

       PROCEDURE DIVISION.
           DISPLAY "Enter Age : " WITH NO ADVANCING.

           ACCEPT Age.

           if Age > 18 then
              DISPLAY "You can vote"
           else
              DISPLAY "You can't vote"
           end-if.

           if Age LESS THAN 5 then
              DISPLAY "Stay home."
           END-IF. 

           if Age GREATER THAN OR EQUAL TO 18 then
              DISPLAY "You're an adult."
           END-IF. 

           if Score is PassingScore THEN
              DISPLAY "You passed !"
           else
              DISPLAY "You failed !"
           END-IF.

           if Score IS NOT NUMERIC THEN
              DISPLAY "Not a number"
           END-IF. 

           PERFORM UNTIL NOT ANumber
              evaluate TRUE 
                 WHEN IsPrime DISPLAY "Prime"
                 WHEN IsOdd DISPLAY "Odd"
                 WHEN IsEven DISPLAY "Even"
                 WHEN LessThan5  DISPLAY "Less than 5"
                 WHEN OTHER DISPLAY "Default Action"
              END-EVALUATE
           end-perform.

           STOP RUN.
