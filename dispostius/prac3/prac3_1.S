.set DDRB,0x04
.set PORTB,0x05
.set PIND,0x09
.set DDRD,0x0A
.set PORTD,0x0B

.global main

waitabit:
	ldi r18,10
wait2:	ldi r17,250
wait1:	subi r17,0x01
	brne wait1
	subi r18,0x01
	brne wait2
	ret

main:	ldi r16,0xFF
	out DDRB,r16
	ldi r17,0x00
	out DDRD,r17
	out PORTD,r16

	
loop:	ldi r16,0x00
	out PORTB,r16
	rcall waitabit
	ldi r16,0xFF
	out PORTB,r16
	rcall waitabit
	rjmp loop







