.set DDRB,0x04
.set PORTB,0x05
.set PIND,0x09
.set DDRD,0x0A
.set PORTD,0x0B

.global main

waitabit:
	ldi r19,41
wait3:	ldi r18,0xFF
wait2:	ldi r17,0xFF
wait1:	subi r17,0x01
	brne wait1
	subi r18,0x01
	brne wait2
	subi r19,0x01
	brne wait3
	ret

main:	ldi r16,0xFF
	out DDRB,r16
	ldi r17,0x00
	out DDRD,r17
	out PORTD,r16
	
loop:	sbic PIND,7
	rjmp E1
	rjmp E2
E2:	ldi r20,0xFF
	out PORTB,r20
	rcall waitabit
	rcall waitabit
	rcall waitabit
	rcall waitabit
	ldi r20,0x00
	out PORTB,r20
	rjmp loop
E1:	ldi r20,0x00
	out PORTB,r20
	rjmp loop







