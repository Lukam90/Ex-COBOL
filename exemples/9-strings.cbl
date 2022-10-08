       IDENTIFICATION DIVISION.
       PROGRAM-ID. 9-strings.
       AUTHOR. Lucien HAMM.

       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.

       data division.
       file section.
       WORKING-STORAGE SECTION.
       01 SampStr   pic X(18) VALUE "eerie beef sneezed".
       01 NumChars  pic 99 VALUE 0.
       01 NumEs     pic 99 VALUE 0.
       01 FName     pic X(6) VALUE "Martin".
       01 MName     pic X(11) VALUE "Luther King".
       01 LName     pic X(4) VALUE "King".
       01 FLName    pic X(11).
       01 FMLName   pic X(18).
       01 SStr1     pic X(7) VALUE "The egg".
       01 SStr2     pic X(9) VALUE "is #1 and".
       01 Dest      pic X(33) VALUE "is the big chicken".
       01 Ptr       pic 9 VALUE 1.
       01 SStr3     pic X(3).
       01 SStr4     pic X(3).

       PROCEDURE DIVISION.
           INSPECT SampStr TALLYING NumChars FOR CHARACTERS.

           DISPLAY "Number of characters : " NumChars.

           INSPECT SampStr TALLYING NumEs FOR ALL "e".

           DISPLAY "Number of Es : " NumEs.

           DISPLAY "Uppercase : " FUNCTION UPPER-CASE(SampStr).
           DISPLAY "Lowercase : " FUNCTION LOWER-CASE(SampStr).

           STRING FName DELIMITED BY SIZE
           SPACE 
           LName DELIMITED BY SIZE
           INTO FLName.

           DISPLAY "FLName = " FLName.

           STRING FLName DELIMITED BY SIZE
           SPACE 
           MName DELIMITED BY SIZE
           SPACE 
           LName DELIMITED BY SIZE
           INTO FMLName
           ON OVERFLOW DISPLAY "Overflowed".

           DISPLAY "FMLName = " FMLName.

           STRING SStr1 DELIMITED BY SIZE 
           SPACE 
           SStr2 DELIMITED BY "#"
           INTO Dest
           WITH POINTER Ptr
           ON OVERFLOW DISPLAY "Overflowed".

           DISPLAY "Dest = " Dest.

           UNSTRING SStr1 DELIMITED BY SPACE 
           INTO SStr3, SStr4 
           END-UNSTRING.

           DISPLAY "SStr4 = " SStr4.

           STOP RUN.
