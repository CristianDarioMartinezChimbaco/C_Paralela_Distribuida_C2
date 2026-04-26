       IDENTIFICATION DIVISION.
       PROGRAM-ID. DATA-INDEX.
       AUTHOR. CRISTIAN MCH.
      ****************************************************************** 
      *    ENVIRONMENT DIVISION.
      ******************************************************************  
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT OUTPUT-DATA-IND-01 ASSIGN TO DATA-FILE-01.
           SELECT OUTPUT-DATA-IND-02 ASSIGN TO DATA-FILE-02.
           SELECT MESSAGE-PROGRAM ASSIGN TO MESAGGE.        
      ****************************************************************** 
      *    DATA DIVISION.
      ******************************************************************  
       DATA DIVISION.
       FILE SECTION.
       FD OUTPUT-DATA-IND-01
           RECORDING MODE IS F
           RECORD CONTAINS 50 CHARACTERS
           DATA RECORD IS FD-OUT-DATA-REC-01.
       01 FD-OUT-DATA-REC-01   PIC X(50).    
       FD OUTPUT-DATA-IND-02
           RECORDING MODE IS F
           RECORD CONTAINS 50 CHARACTERS
           DATA RECORD IS FD-OUT-DATA-REC-02.     
       01 FD-OUT-DATA-REC-02   PIC X(50).
       FD MESSAGE-PROGRAM
           RECORDING MODE IS F
           RECORD CONTAINS 1 CHARACTERS
           DATA RECORD IS FD-MESSAGE-REC.
       01 FD-MESSAGE-REC   PIC X(01).
       WORKING-STORAGE SECTION.
       01 NUM-RAND-DEC     PIC 9(01)V9(10).
       01 MULTIPLICATOR    PIC 999V99.
       01 NUM-RAND         PIC 99V99.        
       01 WS-OUT-DATA-REC.
           02 FILLER       PIC X(12) VALUE 'TEMPERATURE '.
           02 TEMPERATURE  PIC 99V99 VALUE ZEROS.
           02 FILLER       PIC X(10) VALUE ' HUMIDITY '.
           02 HUMIDITY     PIC 99V99 VALUE ZEROS.
           02 FILLER       PIC X(05) VALUE ' CO2 '.
           02 CO2          PIC 9(03) VALUE ZEROS.
           02 FILLER       PIC X(07) VALUE ' INDEX '.
           02 INDEX-NUM    PIC 99V99 VALUE ZEROS.
           02 FILLER       PIC X(01) VALUE ' '.
       01 WS-MESSAGE-REC   PIC X(01).       
      ****************************************************************** 
      *    PROCEDURE DIVISION.
      ******************************************************************
       PROCEDURE DIVISION.
       PERFORM 5000 TIMES
           PERFORM P003-OPEN-DATA-FILE-01
           PERFORM P004-CONFIRM-CREATED-DATA    
           PERFORM P005-CONFIRM-CONTINUE
           PERFORM P003-OPEN-DATA-FILE-02
           PERFORM P004-CONFIRM-CREATED-DATA
           PERFORM P005-CONFIRM-CONTINUE  
       END-PERFORM.    
       STOP RUN.            
       P001-GENERATE-RAMDOM.
       COMPUTE NUM-RAND-DEC = FUNCTION RANDOM
       MULTIPLY NUM-RAND-DEC BY MULTIPLICATOR GIVING NUM-RAND
       .
       P002-CREATE-DATA.
           INITIALIZE WS-OUT-DATA-REC
           MOVE 10.00 TO MULTIPLICATOR
           PERFORM P001-GENERATE-RAMDOM
           MOVE NUM-RAND TO TEMPERATURE
           PERFORM P001-GENERATE-RAMDOM
           MOVE NUM-RAND TO HUMIDITY
           MOVE 100.00 TO MULTIPLICATOR
           PERFORM P001-GENERATE-RAMDOM
           MOVE NUM-RAND TO CO2
           MULTIPLY TEMPERATURE BY 0.4 GIVING TEMPERATURE 
       .       
       P003-OPEN-DATA-FILE-01.
       OPEN OUTPUT OUTPUT-DATA-IND-01
           PERFORM 100 TIMES 
               PERFORM P002-CREATE-DATA
               MOVE WS-OUT-DATA-REC TO FD-OUT-DATA-REC-01
               WRITE FD-OUT-DATA-REC-01  
           END-PERFORM    
       CLOSE OUTPUT-DATA-IND-01
       .
       P003-OPEN-DATA-FILE-02.
       OPEN OUTPUT OUTPUT-DATA-IND-02
           PERFORM 100 TIMES 
               PERFORM P002-CREATE-DATA
               MOVE WS-OUT-DATA-REC TO FD-OUT-DATA-REC-02
               WRITE FD-OUT-DATA-REC-02  
           END-PERFORM    
       CLOSE OUTPUT-DATA-IND-02
       .
       P004-CONFIRM-CREATED-DATA.
       MOVE 'Y' TO WS-MESSAGE-REC 
       OPEN OUTPUT MESSAGE-PROGRAM       
           WRITE FD-MESSAGE-REC FROM WS-MESSAGE-REC
       CLOSE MESSAGE-PROGRAM
       .
       P005-CONFIRM-CONTINUE.
       PERFORM UNTIL WS-MESSAGE-REC = 'N'
           OPEN INPUT MESSAGE-PROGRAM
               READ MESSAGE-PROGRAM INTO WS-MESSAGE-REC
           CLOSE MESSAGE-PROGRAM
       END-PERFORM  
       .
