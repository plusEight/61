;=================================================
; 
; Name: Fan, Chuanping
; Username: cfan002@ucr.edu
;	
; SID: 861105608
; Assignment name: assn 4
; Lab section: 029
; TA: Jose
;
; I hereby certify that I have not received 
; assistance on this assignment, or used code
; from ANY outside source other than the
; instruction team. 
;
;=================================================

.ORIG x3000			; Program begins here
;-------------------------------
;INSERT CODE STARTING FROM HERE 
;--------------------------------
;TO Output Intro Message
VERYBEGIN
LD R1, ZERO ;Initialize final register to 0
LD R2, ZERO ; used as a temp
LD R3, arraybegin ; outer counter
LD R4, ZERO ; inner counter
LD R5, TEN  ; counter for multiplying by 10
LD R6, ZERO ; NEGATIVE FLAG
LD R0, introMessage  ; Output Intro Message
PUTS

BEGIN
	GETC
	OUT

  LD R5, NEGATIVE ; Check if -
		ADD R5, R5, R0
		BRz negINPUT
	LD R5, POSITIVE ;Check if +
		ADD R5, R5, R0
		BRz FIRSTSKIP
	LD R5, ENTER ;check for enter
		ADD R5, R5, R0
		BRz INVALID1
	
	NUMBERSONLY
		LD R5, ENTER ;check for enter
			ADD R5, R5, R0
			BRz	LOADSTASH
		LD R5, negASCII ;check for non-numerical
			ADD R5, R5, R0
			BRn INVALID1
		LD R5, posASCII ;^ (after 57 ascii)
			ADD R5, R5, R0
			BRp INVALID1
	
	ADDDEC ;take number, convert into decimal and store into array
		LD R5, negASCII
		ADD R0, R0, R5 ;convert input from ascii char into dec
		STR R0, R3, #0 ;store digit into array
		ADD R3, R3, #1 ;Increment array
		ADD R4, R4, #1 ;increment number of elements in array (decimal places)
	ENDDEC		
	FIRSTSKIP ;jump here if + or - is detected, otherwise would have been checked twice
	GETC
	OUT
	BR NUMBERSONLY	
	
	LOADSTASH
		LD R3, arraybegin ;set array back to beginning
			OUTERLOOP
				LD R5, ZERO ; reset
				LDR R0, R3, #0 ;put current value of array into R3
				ADD R5, R0, #0 ; Copy it into R5
				ADD R2, R4, #0 ;copy r4 into r2
				ADD R2, R2, #-1 ;subtract 1 from 10^
				BRz ONESDIGIT
			RELOAD ;multiply by another set of 10
			INNERLOOP	;multiply by 10
				ADD R0, R0, R5
				ADD R0, R0, R5
				ADD R0, R0, R5
				ADD R0, R0, R5
				ADD R0, R0, R5
				ADD R0, R0, R5
				ADD R0, R0, R5
				ADD R0, R0, R5
				ADD R0, R0, R5
			LD R5, ZERO
			ADD R5, R0, #0 ;next digit
			ADD R2, R2, #-1
			BRp RELOAD
		ONESDIGIT
		ADD R1, R1, R0
		ADD R3, R3, #1 ;increment array
		
		ADD R4, R4, #-1 ;decrease elements left in array
		BRp OUTERLOOP
	
	ADD R6, R6, #0
	BRp NEGFLAG
		
	BR ENDPROG

	INVALID1
		LEA R0, NEWLINE
		PUTS
		LD R0, errorMessage
		PUTS
		BR VERYBEGIN
	negINPUT ;negative detected, waiting for first number
		ADD R6, R6, #1
		BR FIRSTSKIP 

	NEGFLAG
		NOT R1, R1
		ADD R1, R1, #1
ENDPROG

HALT
;---------------	
;Data
;---------------
arraybegin .FILL x4000
introMessage .FILL x6000
errorMessage .FILL x6100
ZERO .FILL #0
NEGATIVE .FILL #-45
POSITIVE .FILL #-43
NEWLINE .STRINGZ "\n"
CHECKNUM .FILL #9
negASCII .FILL #-48
posASCII .FILL #-58
ENTER .FILL #-10
TEN .FILL #10

;---------------BEGIN SUBROUTINE---------------
.ORIG x3200
ST R0, backupr0
ST R1, backupr1
ST R2, backupr2
ST R3, backupr3
ST R4, backupr4
ST R5, backupr5
ST R6, backupr6
ST R7, backupr7


;reload old registers
LD R0, backupr0
LD R1, backupr1
LD R2, backupr2
LD R3, backupr3
LD R4, backupr4
LD R5, backupr5
LD R6, backupr6
LD R7, backupr7

RET

;Subroutine Data
backupr0 .BLKW #1
backupr1 .BLKW #1
backupr2 .BLKW #1
backupr3 .BLKW #1
backupr4 .BLKW #1
backupr5 .BLKW #1
backupr6 .BLKW #1
backupr7 .BLKW #1
;---------------END SUBROUTINE-----------------
.ORIG x4000
.ORIG x6000
;---------------
;messages
;---------------
intro .STRINGZ	"Input a positive or negative decimal number (max 5 digits), followed by ENTER\n"
;---------------
;error_messages
;---------------
.ORIG x6100	
error_mes .STRINGZ	"ERROR INVALID INPUT\n"
;---------------
;END of PROGRAM
;---------------
.END
