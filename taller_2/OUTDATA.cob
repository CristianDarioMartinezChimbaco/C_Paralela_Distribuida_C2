       IDENTIFICATION DIVISION.
       PROGRAM-ID. hello.
       
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       SELECT OUTPUT-DATA ASSIGN TO datos.
       
       DATA DIVISION.
       FILE SECTION.
        FD   OUTPUT-DATA
            RECORDING MODE IS F
            RECORD CONTAINS 20 CHARACTERS
            DATA RECORD IS FD-OUT-DATA-REC.
        01  FD-OUT-DATA-REC PIC X(50).
       WORKING-STORAGE SECTION.
        01  WS-OUT-DATA-REC.
            02  FILLER      PIC X(12) VALUE 'TEMPERATURA '.
            02  TEMPERATURA PIC 99V99 VALUE ZEROS.     
            02  FILLER      PIC X(09) VALUE ' HUMEDAD '.
            02  HUMEDAD     PIC 99V99 VALUE ZEROS.
            02  FILLER      PIC X(05) VALUE ' CO2 '.
            02  CO2         PIC 9(04) VALUE ZEROS.
            02  FILLER      PIC X(08) VALUE ' INDICE '.
            02  INDICE      PIC 999V9 VALUE ZEROS.
       
       PROCEDURE DIVISION.
       DISPLAY "Hello World".
       STOP RUN.
       
       P001-GENERATE-RAMDOM.
       
       
       P002-WRITE-DATA.
       OPEN
