       IDENTIFICATION DIVISION.
       PROGRAM-ID. 6-paragraphs.
       AUTHOR. Lucien HAMM.

       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.

       data division.
       file section.
       WORKING-STORAGE SECTION. 

       PROCEDURE DIVISION.
       SubOne.
           DISPLAY "In Paragraph 1".

           PERFORM SubTwo.

           DISPLAY "Returned to Paragraph 1".

           PERFORM SubFour 2 TIMES.

       SubThree.
           DISPLAY "In Paragraph 3".    

       SubTwo.
           DISPLAY "In Paragraph 2".

           PERFORM SubThree.

           DISPLAY "Returned to Paragraph 2".

       SubFour.
           DISPLAY "Repeat".

           STOP RUN.
