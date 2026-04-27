       IDENTIFICATION DIVISION.
       PROGRAM-ID. INDEX.
       AUTHOR. CRISTIAN MCH.
      ****************************************************************** 
      *    ENVIRONMENT DIVISION
      ******************************************************************  
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT OUTPUT-DATA-TOTAL ASSIGN TO DATA-TOTAL
               FILE STATUS IS WS-STATUS-DTL.
           SELECT INPUT-DATA-IND-01 ASSIGN TO DATA-FILE-01
               FILE STATUS IS WS-STATUS-01.
           SELECT INPUT-DATA-IND-02 ASSIGN TO DATA-FILE-02
               FILE STATUS IS WS-STATUS-02.
           SELECT MESSAGE-PROGRAM ASSIGN TO MESAGGE
               FILE STATUS IS WS-STATUS-MSG.        
      ****************************************************************** 
      *    DATA DIVISION
      ******************************************************************  
       DATA DIVISION.
       FILE SECTION.
       FD OUTPUT-DATA-TOTAL
           RECORDING MODE IS F
           RECORD CONTAINS 50 CHARACTERS
           DATA RECORD IS FD-OUT-TOTAL-REC.
       01 FD-OUT-TOTAL-REC     PIC X(50). 
       FD INPUT-DATA-IND-01
           RECORDING MODE IS F
           RECORD CONTAINS 50 CHARACTERS
           DATA RECORD IS FD-OUT-DATA-REC-01. 
       01 FD-OUT-DATA-REC-01   PIC X(50).            
       FD INPUT-DATA-IND-02
           RECORDING MODE IS F
           RECORD CONTAINS 50 CHARACTERS
           DATA RECORD IS FD-OUT-DATA-REC-02.
       01 FD-OUT-DATA-REC-02   PIC X(50).
       FD MESSAGE-PROGRAM
           RECORDING MODE IS F
           RECORD CONTAINS 1 CHARACTERS
           DATA RECORD IS FD-MESSAGE-REC.
       01 FD-MESSAGE-REC       PIC X(01).
      ****************************************************************** 
      *    WORKING-STORAGE SECTION
      ******************************************************************   
       WORKING-STORAGE SECTION.
       01 WS-STATUS-DTL        PIC XX.   
       01 WS-STATUS-01         PIC XX.
       01 WS-STATUS-02         PIC XX.
       01 WS-STATUS-MSG        PIC XX.
       01 EOF                  PIC X(01) VALUE 'F'.   
       01 WS-IN-OUT-DATA-REC.
           02 FILLER           PIC X(12) VALUE 'TEMPERATURE '.
           02 TEMPERATURE      PIC 99V99 VALUE ZEROS.
           02 FILLER           PIC X(10) VALUE ' HUMIDITY '.
           02 HUMIDITY         PIC 99V99 VALUE ZEROS.
           02 FILLER           PIC X(05) VALUE ' CO2 '.
           02 CO2              PIC 9(03) VALUE ZEROS.
           02 FILLER           PIC X(07) VALUE ' INDEX '.
           02 INDEX-NUM        PIC 99V99 VALUE ZEROS.
           02 FILLER           PIC X(01) VALUE ' '.
       01 WS-MESSAGE-REC       PIC X(01).       
      ****************************************************************** 
      *    PROCEDURE DIVISION.
      ******************************************************************
       PROCEDURE DIVISION.
       DISPLAY "WELCOME TO INDEX PROGRAM".
       OPEN OUTPUT OUTPUT-DATA-TOTAL
           PERFORM 5000 TIMES
               DISPLAY 'STARTED P003-CONFIRM-CONTINUE'     
               PERFORM P003-CONFIRM-CONTINUE   
               DISPLAY 'STARTED P004-CONFIRM-MESSAGE-RECEIVED'        
               PERFORM P004-CONFIRM-MESSAGE-RECEIVED
               DISPLAY 'STARTED P001-READ-FILE-DATA-01'   
               PERFORM P001-READ-FILE-DATA-01  
               DISPLAY 'STARTED P003-CONFIRM-CONTINUE'   
               PERFORM P003-CONFIRM-CONTINUE  
               DISPLAY 'STARTED P004-CONFIRM-MESSAGE-RECEIVED'   
               PERFORM P004-CONFIRM-MESSAGE-RECEIVED
               DISPLAY 'STARTED P001-READ-FILE-DATA-02'   
               PERFORM P001-READ-FILE-DATA-02           
           END-PERFORM
       CLOSE OUTPUT-DATA-TOTAL.    
       STOP RUN.   
       P001-READ-FILE-DATA-01.
       OPEN INPUT INPUT-DATA-IND-01
           PERFORM UNTIL EOF = 'T'
               READ INPUT-DATA-IND-01 INTO WS-IN-OUT-DATA-REC
                   AT END
                       MOVE 'T' TO EOF
                   NOT AT END
                       PERFORM P002-CALCULATE-INDEX
                       WRITE FD-OUT-TOTAL-REC FROM WS-IN-OUT-DATA-REC
               END-READ                        
           END-PERFORM     
           INITIALIZE EOF                     
       CLOSE INPUT-DATA-IND-01
       .
       P001-READ-FILE-DATA-02.
       OPEN INPUT INPUT-DATA-IND-02
           PERFORM UNTIL EOF = 'T'
               READ INPUT-DATA-IND-02 INTO WS-IN-OUT-DATA-REC
                   AT END
                       MOVE 'T' TO EOF
                   NOT AT END
                       PERFORM P002-CALCULATE-INDEX
                       WRITE FD-OUT-TOTAL-REC FROM WS-IN-OUT-DATA-REC
               END-READ   
           END-PERFORM     
           INITIALIZE EOF                     
       CLOSE INPUT-DATA-IND-02
       .
       P002-CALCULATE-INDEX.
       COMPUTE INDEX-NUM = (TEMPERATURE * 0.4)
                  + (HUMIDITY * 0.3)
                  + (CO2 * 0.3)
       END-COMPUTE
       .  
       P003-CONFIRM-CONTINUE.
       PERFORM UNTIL WS-MESSAGE-REC = 'Y'
           OPEN INPUT MESSAGE-PROGRAM
               READ MESSAGE-PROGRAM INTO WS-MESSAGE-REC
           CLOSE MESSAGE-PROGRAM
       END-PERFORM  
       .
       P004-CONFIRM-MESSAGE-RECEIVED.
       MOVE 'N' TO WS-MESSAGE-REC 
       OPEN OUTPUT MESSAGE-PROGRAM       
           WRITE FD-MESSAGE-REC FROM WS-MESSAGE-REC
       CLOSE MESSAGE-PROGRAM
       . 
