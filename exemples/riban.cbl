       IDENTIFICATION DIVISION.
       program-id. RIBAN.

       data division.
       working-storage section.

       01 RIB.
         10 CodeBanque PIC X(5).
         10 CodeGuichet PIC X(5).
         10 NoCompte PIC X(12).
         10 CleRIB PIC XX.

       01 RIBAffiche.
         10 CodeBanque PIC X(5).
         10 Filler Pic X.
         10 CodeGuichet PIC X(5).
         10 Filler Pic X.
         10 NoCompte PIC X(12).
         10 Filler Pic X.
         10 CleRIB PIC XX.

       procedure division.
           display "Code banque : " with no advancing.
           accept CodeBanque of RIB.

           display "Code guichet : " with no advancing.
           accept CodeGuichet of RIB.

           display "Numéro de compte : " with no advancing.
           accept NoCompte of RIB.

           display "Clé RIB : " with no advancing.
           accept CleRIB of RIB.

           move CodeBanque of RIB to CodeBanque of RIBAffiche.
           move CodeBanque of RIB to CodeBanque of RIBAffiche.
           move CodeBanque of RIB to CodeBanque of RIBAffiche.
           move CodeBanque of RIB to CodeBanque of RIBAffiche.

           display RIBAffiche.

           stop run.
           