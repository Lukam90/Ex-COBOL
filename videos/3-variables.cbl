       identification division.
       program-id. 3-variables.
       author. Lucien HAMM.

       environment division.

       data division.

       working-storage section.
       01 SampleData pic X(10) value "Stuff".
       01 JustLetters pic AAA value "ABC".
       01 JustNums pic 9(4) value 1234.
       01 SignedInt pic S9(4) value -1234.
       01 PayCheck PIC 9(4)V99 value zero.

       01 Customer.
           02 Ident pic 9(3).
           02 CustName pic x(20).
           02 DateOfBirth.
               03 MOB pic 99.
               03 DOB pic 99.
               03 YOB pic 9(4).

       01 Num1 pic 9 value 5.
       01 Num2 pic 9 value 4.
       01 Num3 pic 9 value 3.

       01 Ans pic S99V99 value 0.

       01 Rem pic 9V99.

       procedure division.
           move "More Stuff" to SampleData.
           move "123" to SampleData.
           move 123 to SampleData.

           display SampleData.
           display PayCheck.

           move "123Bob Smith           12211974" to Customer.

           display MOB "/" DOB "/" YOB.

           move zero to SampleData.
           display SampleData.

           move space to SampleData.
           display SampleData.

           move high-value to SampleData.
           display SampleData.

           move low-value to SampleData.
           display SampleData.

           move quote to SampleData.
           display SampleData.

           move all "2" to SampleData.
           display SampleData.
           
           stop run.