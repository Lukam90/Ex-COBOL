       IDENTIFICATION DIVISION.
       PROGRAM-ID. 14-indexed-file.
       AUTHOR. Lucien HAMM.
       
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION. 
       FILE-CONTROL.
           SELECT CustomerFile ASSIGN TO "Customer.txt"
           ORGANIZATION IS INDEXED
           ACCESS MODE IS RANDOM
           RECORD KEY IS IDNum.
       
       data division.
       file section.

       FD CustomerFile.
       01 CustomerData.
           02 IDNum PIC 99.
           02 FirstName   PIC X(15).
           02 LastName    PIC X(15).
       
       WORKING-STORAGE SECTION.
       01 Choice             PIC 9.
       01 StayOpen           PIC X VALUE 'Y'.
       01 CustomerExists     PIC X.

       PROCEDURE DIVISION.
       StartPara.
           OPEN I-O CustomerFile.

           PERFORM UNTIL StayOpen = 'N'
              DISPLAY " "
              DISPLAY "CUSTOMER RECORDS"
              DISPLAY "1 : Add Customer"
              DISPLAY "2 : Delete Customer"
              DISPLAY "3 : Update Customer"
              DISPLAY "4 : Get Customer"
              DISPLAY "0 : Quit"

              DISPLAY "Your choice : " WITH NO ADVANCING

              ACCEPT Choice

              EVALUATE Choice 
                 WHEN 1 PERFORM AddCustomer
                 WHEN 2 PERFORM DeleteCustomer
                 WHEN 3 PERFORM UpdateCustomer
                 WHEN 4 PERFORM GetCustomer
                 WHEN OTHER MOVE 'N' TO StayOpen
              END-EVALUATE
           END-PERFORM.

           CLOSE CustomerFile.

           STOP RUN.

       AddCustomer.
           DISPLAY " ".

           DISPLAY "Enter ID : " WITH NO ADVANCING.
           ACCEPT IDNum.

           DISPLAY "Enter First Name : " WITH NO ADVANCING.
           ACCEPT FirstName.

           DISPLAY "Enter Last Name : " WITH NO ADVANCING.
           ACCEPT LastName.

           DISPLAY " ".

           WRITE CustomerData 
              INVALID KEY DISPLAY "ID Taken"
           END-WRITE.

       DeleteCustomer.
           DISPLAY " ".

           DISPLAY "Enter Customer ID to Delete : " WITH NO ADVANCING.
           ACCEPT IDNum.

           DELETE CustomerFile
              INVALID KEY DISPLAY "Key doesn't exist"
           END-DELETE.

       UpdateCustomer.
           MOVE 'Y' TO CustomerExists.

           DISPLAY " ".
           DISPLAY "Enter Customer ID to Update : " WITH NO ADVANCING.
           ACCEPT IDNum.

           READ CustomerFile
              INVALID KEY MOVE 'N' TO CustomerExists
           END-READ.

           IF CustomerExists = 'N'
              DISPLAY "Customer doesn't exist."
           ELSE
              DISPLAY "Enter the New First Name : " WITH NO ADVANCING
              ACCEPT FirstName

              DISPLAY "Enter the New Last Name : " WITH NO ADVANCING
              ACCEPT LastName
           END-IF.

           REWRITE CustomerData 
              INVALID KEY DISPLAY "Customer Not Updated"
           END-REWRITE.

       GetCustomer.
           MOVE 'Y' TO CustomerExists.

           DISPLAY " ".
           DISPLAY "Enter Customer ID to Find : " WITH NO ADVANCING.
           ACCEPT IDNum.

           READ CustomerFile 
              INVALID KEY MOVE 'N' TO CustomerExists
           END-READ.

           IF CustomerExists = 'N'
              DISPLAY "Customer doesn't exist"
           ELSE
              DISPLAY "ID : " IDNum 
              DISPLAY "First Name : " FirstName  
              DISPLAY "Last Name : " LastName  
           END-IF.
