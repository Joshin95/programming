.set DDRB, 0x4
.set PORTB, 0x5
.set PORTD, 0x0b
.set DDRD, 0x0a
.set OCR0A, 0x27
.set TCCR0B, 0x25
.set TCCR0A, 0x24
.set PINB, 0x03
.set PIND, 0x09

.global main
	
to1:
	ldi r25,12
bucle3:	ldi r18,255
bucle2:	ldi r19,255
bucle1:	subi r19,0x01
	brne bucle1
	subi r18,0x01
	brne bucle2
	subi r25,0x01
	brne bucle3
	ret

punt:
	ldi r20,0b00000011
	out TCCR0B,r20
	rcall to1
	ldi r20,0b00000000
	out TCCR0B,r20
	rcall to1
	ret

ralla:
	ldi r20,0b00000011
	out TCCR0B,r20
	rcall to1
	rcall to1
	rcall to1
	ldi r20,0b00000000
	out TCCR0B,r20
	rcall to1
	ret

main:	ldi r16,0b01000010
	out TCCR0A,r16
	ldi r16,0b00000000
	out TCCR0B,r16
	ldi r16,124
	out OCR0A,r16
	ldi r16,0b01000000
	out DDRD,r16
	ldi r17,0b00100000
	out DDRB,r17
	ldi r18,0b00000011
	out PORTB,r18
	
	
loop:	ldi r20,0b00000011
	in r21,PINB
	and r20,r21
	breq E2
	brne bucle
bucle:	ldi r23,0x0F
	out PORTB,r23
	sbic PINB,0
	rjmp E1 
	rcall punt
E1:	sbic PINB,1
	rjmp loop
	rcall ralla
	rjmp loop
E2:	ldi r22,0xFF
	out PORTB,r22
	rjmp loop
