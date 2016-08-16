.set DDRB, 0x4
.set PORTB, 0x5
.set PORTD, 0x0b
.set DDRD, 0x0a
.set OCR0A, 0x27
.set TCCR0B, 0x25
.set TCCR0A, 0x24


.global main
	
waitabit:
	ldi r25,41
bucle3:	ldi r18,255
bucle2:	ldi r19,255
bucle1:	subi r19,0x01
	brne bucle1
	subi r18,0x01
	brne bucle2
	subi r25,0x01
	brne bucle3
	ret

main:	ldi r16,0b01000010
	out TCCR0A,r16
	ldi r16,0b00000011
	out TCCR0B,r16
	ldi r16,124
	out OCR0A,r16
	ldi r16,0b01000000
	out DDRD,r16
	
loop:	call waitabit
	ldi r16,0b00000000
	out DDRD,r16
	call waitabit
	ldi r16,0b01000000
	out DDRD,r16
	rjmp loop
