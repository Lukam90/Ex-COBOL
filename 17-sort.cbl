       IDENTIFICATION DIVISION.
       PROGRAM-ID. 17-sort.
       AUTHOR. Lucien HAMM.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT WorkFile ASSIGN TO "work.tmp".

           SELECT OrgFile ASSIGN TO "students.dat"
           ORGANIZATION IS LINE SEQUENTIAL.

           SELECT SortedFile ASSIGN TO "sorted.dat"
           ORGANIZATION IS LINE SEQUENTIAL.
       
       data division.
       FILE SECTION. 
       FD OrgFile.

       01 StudentsData.
           02 IDNum PIC 9.
           02 StudentName PIC X(10).
       
       SD WorkFile.

       01 StudentsData.
           02 IDNum PIC 9.
           02 StudentName PIC X(10).

       FD SortedFile.

       01 SortedData.
           02 SIDNum PIC 9.
           02 SStudentName PIC X(10).

       WORKING-STORAGE SECTION.
       
       PROCEDURE DIVISION.
           SORT WorkFile ON ASCENDING KEY SIDNum 
           USING OrgFile 
           GIVING SortedFile.

           STOP RUN.
