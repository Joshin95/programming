.set PRR, 0x64 // posar el PRTIM1 a 0 per activar el timer (bit 3 del PRR)
.set DDRB, 0x4
.set PORTB, 0x5
.set OCR2A, 0xB3
.set TCCR2B, 0xB1
.set TCCR2A, 0xB0
.set PINB, 0x03

.global main
	
main:
	lds r16,PRR
	andi r16,0b10110111 // Posem a 0 el bit 3 i el 6 per engegar els dos timers 0 i 2
	sts PRR,r16

	ldi r16,0b01000010 // toggle oc2a on compare match, CTC mode amb top al OCR2A
	sts TCCR2A,r16

	ldi r16,0b00000100 // preescaler a 64
	sts TCCR2B,r16

	ldi r16,124 // limit del OCR2A
	sts OCR2A,r16

	ldi r16,0b00001000
	out DDRB,r16

loop:	rjmp loop
	
