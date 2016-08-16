.set DDRB,0x04
.set PORTB,0x05
.set PIND,0x09
.set DDRD,0x0A
.set PORTD,0x0B

.global main
	
punt:
	rcall to1
	rcall sl1
	ret

ralla:
	rcall to1
	rcall to1
	rcall to1
	rcall sl1
	ret


so1k:
	ldi r18,10
bucle2:	ldi r19,255
bucle1:	subi r19,0x01
	brne bucle1
	subi r18,0x01
	brne bucle2
	ret

to1:
	ldi r20,155
bucle3:		
	sbi PORTB,0
	rcall so1k
	cbi PORTB,0
	rcall so1k
	subi r20,0x01
	brne bucle3
	ret

sl1:
	ldi r20,155
bucle6:		
	nop
	rcall so1k
	nop
	rcall so1k
	subi r20,0x01
	brne bucle6
	ret

main:
	ldi r16,0xFF
	out DDRB,r16
	ldi r17,0x00
	out DDRD,r17
	out PORTD,16 /*pull up*/

loop:
	ldi r18,0b10000000 /*pin entrada punt, 7 port D*/
	ldi r19,0b00000001 /*pin entrada ralla, 1 port D*/ /*mejor con SBIC i SBIS*/
	in r20,PIND
	and r18,r20
	breq point
	and r19,r20
	breq slash
	brne loop
point:
	rcall punt
	rjmp loop
slash:
	rcall ralla
	rjmp loop
	
