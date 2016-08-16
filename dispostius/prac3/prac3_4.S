.set DDRB,0x04
.set PORTB,0x05
.set PIND,0x09
.set DDRD,0x0A
.set PORTD,0x0B

.global main

so1k:
	ldi r23,10
bucle2:	ldi r24,255
bucle1:	subi r24,0x01
	brne bucle1
	subi r23,0x01
	brne bucle2
	ret
	
main:	ldi r16,0xFF
	out DDRB,r16
	ldi r17,0x00
	out DDRD,r17
	out PORTD,r16
	
loop:	sbic PIND,7
	rjmp E1
	rjmp E2

E2:
	ldi r21,9
bucle5:	ldi r20,0xFF
bucle4:	ldi r19,0xFF
bucle3: subi r19,0x01
	sbi PORTB,0
	rcall so1k
	cbi PORTB,0
	rcall so1k
	brne bucle3
	subi r20,0x01
	brne bucle4
	subi r21,0x01
	brne bucle5
	rjmp loop
E1:
	rjmp loop

