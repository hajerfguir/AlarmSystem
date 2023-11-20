;------------------------------------------------------
; Alarm System Simulation Assembler Program
; File: delay.asm
; Description: The Delay Module
; Author: Gilbert Arbez
; Date: Fall 2010
;------------------------------------------------------

; Some definitions

	SWITCH code_section
;------------------------------------------------------
; Subroutine delayms
; Parameters: num - number of milliseconds, stored in D
; Returns: nothing
; Global Variables: none
; Description: Delay for num milliseconds.
;------------------------------------------------------
delayms:
delaymsloop1:
   jsr delayonems
   dbne D, delaymsloop1 ; Decrementer puis BNE, D
   rts

;------------------------------------------------------
; Subroutine setDelay
; Parameters: cnt - accumulator D
; Returns: nothing
; Global Variables: delayCount
; Description: Intialises the delayCount 
;              variable.
;------------------------------------------------------
setDelay: 

   std delayCount; Complete this subroutine
   rts

;------------------------------------------------------
; Subroutine delayonems
; Parameters: none
; Returns: nothing
; Global Variables:
; Description: Delay for one millisecond.
;------------------------------------------------------
delayonems:
   ldx #3000 ; 3000 cycles
boucle0:
   nop
   nop
   nop
   nop
   dex ; decrementer x
   bne boucle0; boucle si x != 0
   rts

    
;------------------------------------------------------
; Subroutine: polldelay
; Parameters:  none
; Returns: TRUE when delay counter reaches 0 - in accumulator A
; Local Variables
;   retval - acc A cntr - X register
; Global Variables:
;      delayCount
; Description: The subroutine delays for 1 ms, decrements delayCount.
;              If delayCount is zero, return TRUE; FALSE otherwise.
;   Core Clock is set to 24 MHz, so 1 cycle is 41 2/3 ns
;   NOP takes up 1 cycle, thus 41 2/3 ns
;   Need 24 cyles to create 1 microsecond delay
;   8 cycles creates a 333 1/3 nano delay
;	DEX - 1 cycle
;	BNE - 3 cyles - when branch is taken
;	Need 4 NOP
;   Run Loop 3000 times to create a 1 ms delay   
;------------------------------------------------------
; Stack Usage:
	OFFSET 0  ; to setup offset into stack
PDLY_VARSIZE:
PDLY_PR_Y   DS.W 1 ; preservation Y
PDLY_PR_X   DS.W 1 ; preservationX
PDLY_PR_B   DS.B 1 ; preservationB
PDLY_RA     DS.W 1 ; adresse de retour

polldelay: pshb
   pshx
   pshy
   ldy delayCount ; load delayCount
   ldaa #0 ; store 0
   jsr delayonems; call delay1ms subroutine
   dey ; decrementer y
   sty delayCount ; store y dans delayCount
   bne endofcode ; branch a endofcode (registers restore) si != 0
   ldaa #1
	; Complete this routine



   ; restore registers and stack
endofcode:
   puly
   pulx
   pulb
   rts



;------------------------------------------------------
; Global variables
;------------------------------------------------------
   switch globalVar
delayCount ds.w 1   ; 2 byte delay counter
