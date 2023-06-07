

;Project Assignment
;Team H
;Test Scores (Option B)

.ORIG x3000

; Initialize the Test Score Variables

LDI R0, TestScore1
LDI R1, TestScore2
LDI R2, TestScore3
LDI R3, TestScore4
LDI R4, TestScore5

; Display Test Score

LEA R0, TestScore1
LEA R1, TestScore2
LEA R2, TestScore3
LEA R3, TestScore4
LEA R4, TestScore5

; filling register loop backbone (Needs work):

LD R2, ARRAY        ; R2 = x6000. Working on values in different memory register ranges.
AND R1, R1, 0       ; R1 = 0 (clear before add)
ADD R1, R1, 5       ; R1 = 5 (length of array)
LOOP ADD R1, R1, -1 ; R1 decrecrements. Values in the array will be inputted
BRn DONE            ; if R1 < 0 then halt, else...

; displaying Corresponding Letter Grade from memory value loop backbone:
LDR R0, R2, 0       ; R0 <-- mem[R2 + 0]
ADD R2, R2, 1       ; R2 increments. Values in the array will be read.
BR LOOP             ; loop
DONE HALT           ; halt

; Loop comparator to find maximum: 

LDR R1, ARRAY	
AND R6, R6, #0	; clearing loop counter
ADD R6, R6, #5	; creating loop counter

LOOP
ST R1, CMAX
LDR R2, PMAX
ST R2, FMAX
JSR MAX		; jump to maximum subroutine
LDR R0, CMAX
LD R1, 		; load next test value into R1
LD R2, 		; load next test value into R2
ADD R6, R6, #-1 	; decrement loop counter until zero
BRz LOOP		; loop will continue until it reaches zero


MAX
AND R1, R1, 0	; clear R1
AND R2, R2, 0	; clear R2 
AND R5, R5, 0	; clear R5 to store maximum after each loop
NOT R2, R2
ADD R2, R2, #1	; 2’s complement R2 to add together values and compare
ADD R3, R1, R2	; R3 = R1 + (-R2) to determine if value is pos, neg, or zero (want positive)
BRp R1MAX		; if pos send to branch to write value, if not continue

R2MAX
ADD R5, R5, R2	; put R2 in R5 as current maximum value
STI R5, BIGGEST	; store R5 with overwrite 
RET			; repeat

R1MAX
ADD R5, R5, R1	; put R1 in R5 as current maximum value
STI R5, BIGGEST	; store R5 with overwrite
RET			; repeat

HALT

; Loop comparator to find minimum:

LDR R1, ARRAY
AND R6, R6, #0	; clearing loop counter
ADD R6, R6, #5	; creating loop counter

LOOP
ST R1, CMIN
LDR R2, PMIN
ST R2, FMAX
JSR MIN		; jump to minimum subroutine
LDR R0, CMAX
LD R1, 		; load next test value into R1
LD R2, 		; load next test value into R2
ADD R6, R6, #-1 	; decrement loop counter until zero
BRz LOOP		; loop will continue until it reaches zero


MIN
AND R1, R1, 0	; clear R1
AND R2, R2, 0	; clear R2 
AND R5, R5, 0	; clear R5 to store minimum after each loop
NOT R2, R2
ADD R2, R2, #1	; 2’s complement R2 to add together values and compare
ADD R3, R1, R2	; R3 = R1 + (-R2) to determine if value is pos, neg, or zero (want neg)
BRn R1MIN		; if neg send to branch to write value, if not continue

R2MIN
ADD R5, R5, R2	; put R2 in R5 as current minimum value
STI R5, SMALL	; store R5 with overwrite 
RET			; repeat

R1MIN
ADD R5, R5, R1	; put R1 in R5 as current minimum value
STI R5, SMALL	; store R5 with overwrite
RET			; repeat

HALT 


; Loop Math function to calculate Test score average:

; Loop to calculate the sum
; LOOP
LDR R0, R2, #0       		; Load the number from memory
ADD R3, R3, R0       		; Add the number to the sum
ADD R2, R2, #1       		; Increment the memory address
ADD R4, R4, #1  		; Increment the counter
BRp LOOP            		; Branch to LOOP if positive (not end of array)
	
; Calculate the average
ADD R5, R3, #0
BRz DONE                	; Branch to DONE if the sum is zero
ADD R5, R5, R1         		; Add the number of elements
ADD R5, R5, #-1        		; Subtract 1 to ignore the sentinel value
ADD R5, R5, R4         		; Add the counter (number of elements)
DIV R5, R5, R1           	; Divide the sum by the number of elements


; Print the average
OUT
TRAP x25

; Terminate the program

HALT


Letter grade			.STRINGZ "A"		
				.STRINGZ "B"
				.STRINGZ "C"
				.STRINGZ "D"
				.STRINGZ "F"

Output string			
.STRINGZ "Minimum grade:  "
.STRINGZ "Maximum grade:  "
.STRINGZ "Average grade:  "
.STRINGZ "Letter grade :  "


; Variables Test scores
TestScore1      .FILL x3100
TestScore2      .FILL x3101
TestScore3      .FILL x3102
TestScore4      .FILL x3103
TestScore5      .FILL x3104 
CMAX		.FILL x3105 	; current max number
PMAX		.FILL x3106	; pointer for max
FMAX		.FILL x3107	; fill for max
CMIN		.FILL x3108	; current min number
PMIN		.FILL x3109	; pointer for min
FMIN 		.FILL x3110	; fill for min




.END






