       IDENTIFICATION DIVISION.
       PROGRAM-ID. 18-merge.
       AUTHOR. Lucien HAMM.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT WorkFile ASSIGN TO "work.tmp".

           SELECT File1 ASSIGN TO "file1.dat"
           ORGANIZATION IS LINE SEQUENTIAL.

           SELECT File2 ASSIGN TO "file2.dat"
           ORGANIZATION IS LINE SEQUENTIAL.

           SELECT NewFile ASSIGN TO "new.dat"
           ORGANIZATION IS LINE SEQUENTIAL.
       
       data division.
       FILE SECTION. 
       SD WorkFile.
       01 WLine PIC X(20).

       FD File1.
       01 F1Line PIC X(20).
       
       FD File2.
       01 F2Line PIC X(20).

       FD NewFile.
       01 NLine PIC X(20).

       WORKING-STORAGE SECTION.
       
       PROCEDURE DIVISION.
           MERGE WorkFile ON ASCENDING KEY NLine  
           USING File1, File2  
           GIVING NewFile.

           STOP RUN.
