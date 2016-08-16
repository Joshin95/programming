.set DDRB,0x04
.equ PORTB,0x05
.global main

so1k:
	ldi r18,10
bucle2:	ldi r19,255
bucle1:	subi r19,0x01
	brne bucle1
	subi r18,0x01
	brne bucle2
	ret

so8m:
	ldi r20,250
bucle3:		
	sbi PORTB,0
	rcall so1k
	cbi PORTB,0
	rcall so1k
	subi r20,0x01
	brne bucle3
	ret
	
main:
	ldi r16,0xFF
	out DDRB,r16
	sbi PORTB,5
	rcall so8m
	cbi PORTB,5
	rcall so8m
	rjmp main




	
