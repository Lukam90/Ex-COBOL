       IDENTIFICATION DIVISION.
       PROGRAM-ID. 15-tables.
       AUTHOR. Lucien HAMM.
       
       data division.
       
       WORKING-STORAGE SECTION.
       01 STable.
           02 Friends PIC X(15) OCCURS 4 TIMES.

       01 CustomersTable.
           02 CustomerName OCCURS 5 TIMES.
              03 FName PIC X(15).
              03 LName PIC X(15).

       01 OrderTable.
           02 Product OCCURS 2 TIMES INDEXED BY I.
              03 ProdName PIC X(10).
              03 ProdSize OCCURS 3 TIMES INDEXED BY J.
                 04 SizeType PIC A.

       PROCEDURE DIVISION.
           PERFORM SimpleTable.
           PERFORM MultiTable.
           PERFORM IndexedTable.

       SimpleTable.
           MOVE 'Dave' TO Friends(1).
           MOVE 'Mike' TO Friends(2).
           MOVE 'Bob' TO Friends(3).

           DISPLAY "Friends(1) = " Friends(1).

           DISPLAY "STable = " STable.

       MultiTable.
           MOVE 'Kevin' TO FName(1).
           MOVE 'Smith' TO LName(1).
           MOVE 'Sally' TO FName(2).
           MOVE 'Davy' TO LName(2).

           DISPLAY "CustomerName(1) = " CustomerName(1).

           DISPLAY "CustomersTable = " CustomersTable.

       IndexedTable.
           SET I J TO 1.

           MOVE "Blue Shirt" TO Product(I).
           MOVE "S" TO ProdSize(I,J).

           SET J UP BY 1.

           MOVE "M" TO ProdSize(I,J).

           SET J DOWN BY 1.

           MOVE "Blue ShirtSMLRed Shirt SML" TO OrderTable.

           PERFORM GetProduct VARYING I FROM 1 BY 1 UNTIL I > 2.
           PERFORM LookUp.

       GetProduct.
           DISPLAY Product(I).

           PERFORM GetSizes VARYING J FROM 1 BY 1 UNTIL J > 3.

       GetSizes.
           DISPLAY ProdSize(I, J).

       LookUp.
           SET I TO 1.

           SEARCH Product
              AT END DISPLAY "Product Not Found"

              WHEN ProdName(I) = "Red Shirt"
              DISPLAY "Red Shirt Found"
           END-SEARCH.

           STOP RUN.
