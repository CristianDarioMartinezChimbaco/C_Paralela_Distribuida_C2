       IDENTIFICATION DIVISION.
       PROGRAM-ID. DATA-INDEX.
       AUTHOR. CRISTIAN MCH.
      ****************************************************************** 
      *    ENVIRONMENT DIVISION.
      ******************************************************************  
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT OUTPUT-DATA-IND-01 ASSIGN TO DATA-FILE-01
               FILE STATUS IS WS-STATUS-01.
           SELECT OUTPUT-DATA-IND-02 ASSIGN TO DATA-FILE-02
               FILE STATUS IS WS-STATUS-02.
           SELECT MESSAGE-PROGRAM ASSIGN TO MESAGGE
               FILE STATUS IS WS-STATUS-MSG.        
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
       01 WS-STATUS-01     PIC XX.
       01 WS-STATUS-02     PIC XX.
       01 WS-STATUS-MSG    PIC XX.
       01 NUM-RAND-DEC     PIC 9(01)V9(10).
       01 MULTIPLICATOR    PIC 999V99.
       01 NUM-RAND         PIC 99V99.        
       01 WS-OUT-DATA-REC.
           02 FILLER       PIC X(12) VALUE "TEMPERATURE ".
           02 TEMPERATURE  PIC 99V99 VALUE ZEROS.
           02 FILLER       PIC X(10) VALUE " HUMIDITY ".
           02 HUMIDITY     PIC 99V99 VALUE ZEROS.
           02 FILLER       PIC X(05) VALUE " CO2 ".
           02 CO2          PIC 9(03) VALUE ZEROS.
           02 FILLER       PIC X(07) VALUE " INDEX ".
           02 INDEX-NUM    PIC 99V99 VALUE ZEROS.
           02 FILLER       PIC X(01) VALUE ' '.
       01 WS-MESSAGE-REC   PIC X(01).       
      ****************************************************************** 
      *    PROCEDURE DIVISION.
      ******************************************************************
       PROCEDURE DIVISION.
       DISPLAY "WELCOME TO DATA-INDEX PROGRAM".
       PERFORM P006-INITIALIZE-MESSAGE.
       PERFORM 5000 TIMES
           DISPLAY "P003-OPEN-DATA-FILE-01"
           PERFORM P003-OPEN-DATA-FILE-01
           DISPLAY "P004-CONFIRM-CREATED-DATA"
           PERFORM P004-CONFIRM-CREATED-DATA  
           DISPLAY "P005-CONFIRM-CONTINUE"  
           PERFORM P005-CONFIRM-CONTINUE
           DISPLAY "P003-OPEN-DATA-FILE-02"
           PERFORM P003-OPEN-DATA-FILE-02
           DISPLAY "P004-CONFIRM-CREATED-DATA"
           PERFORM P004-CONFIRM-CREATED-DATA
           DISPLAY "P005-CONFIRM-CONTINUE"
           PERFORM P005-CONFIRM-CONTINUE  
       END-PERFORM.    
       STOP RUN.   
      ****************************************************************** 
      *    P001-GENERATE-RAMDOM
      ******************************************************************         
       P001-GENERATE-RAMDOM.
       COMPUTE NUM-RAND-DEC = FUNCTION RANDOM
       MULTIPLY NUM-RAND-DEC BY MULTIPLICATOR GIVING NUM-RAND
       .
      ****************************************************************** 
      *    P002-CREATE-DATA
      ******************************************************************
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
      ******************************************************************
      *    P003-OPEN-DATA-FILE-01
      ******************************************************************    
       P003-OPEN-DATA-FILE-01.
       PERFORM UNTIL WS-STATUS-01 = "00" 
           OPEN OUTPUT OUTPUT-DATA-IND-01
       END-PERFORM    
       IF WS-STATUS-01 = "00"    
           PERFORM 100 TIMES 
               PERFORM P002-CREATE-DATA
               MOVE WS-OUT-DATA-REC TO FD-OUT-DATA-REC-01
               WRITE FD-OUT-DATA-REC-01  
           END-PERFORM   
           CLOSE OUTPUT-DATA-IND-01       
       END-IF     
      *INITIALIZE WS-STATUS-01   
       .
      ******************************************************************
      *    P003-OPEN-DATA-FILE-02
      ******************************************************************
       P003-OPEN-DATA-FILE-02.
       PERFORM UNTIL WS-STATUS-02 = "00" 
           OPEN OUTPUT OUTPUT-DATA-IND-02
       END-PERFORM
       IF WS-STATUS-02 = "00"
           PERFORM 100 TIMES 
               PERFORM P002-CREATE-DATA
               MOVE WS-OUT-DATA-REC TO FD-OUT-DATA-REC-02
               WRITE FD-OUT-DATA-REC-02  
           END-PERFORM    
           CLOSE OUTPUT-DATA-IND-02       
       END-IF      
      *INITIALIZE WS-STATUS-02  
       .
      ******************************************************************
      *    P004-CONFIRM-CREATED-DATA
      ******************************************************************
       P004-CONFIRM-CREATED-DATA.
       PERFORM UNTIL WS-STATUS-MSG = "00"  
           OPEN OUTPUT MESSAGE-PROGRAM 
       END-PERFORM  
       IF WS-STATUS-MSG = "00"  
           MOVE 'Y' TO WS-MESSAGE-REC  
           WRITE FD-MESSAGE-REC FROM WS-MESSAGE-REC     
           CLOSE MESSAGE-PROGRAM                   
       END-IF       
      *INITIALIZE WS-STATUS-MSG  
       .
      ******************************************************************
      *    P005-CONFIRM-CONTINUE
      ******************************************************************       
       P005-CONFIRM-CONTINUE.
      *PERFORM UNTIL WS-STATUS-MSG = "00" AND WS-MESSAGE-REC = 'N' 
       MOVE ' ' TO WS-MESSAGE-REC
       PERFORM UNTIL WS-MESSAGE-REC = 'N'                
           OPEN INPUT MESSAGE-PROGRAM            
           IF WS-STATUS-MSG = "00" 
               READ MESSAGE-PROGRAM INTO WS-MESSAGE-REC WITH LOCK
               CLOSE MESSAGE-PROGRAM                    
           END-IF
           CALL "sleep" USING 1   
       END-PERFORM     
      *INITIALIZE WS-STATUS-MSG  
       .
      ******************************************************************
      *    P006-INITIALIZE-MESSAGE
      ******************************************************************  
       P006-INITIALIZE-MESSAGE.  
       PERFORM UNTIL WS-STATUS-MSG = "00"     
           OPEN OUTPUT MESSAGE-PROGRAM 
       END-PERFORM
       IF WS-STATUS-MSG = "00" 
           MOVE 'N' TO WS-MESSAGE-REC       
           WRITE FD-MESSAGE-REC FROM WS-MESSAGE-REC                   
           CLOSE MESSAGE-PROGRAM                        
       END-IF 
       .  

       