.set PRR, 0x64 // posar el PRTIM1 a 0 per activar el timer (bit 3 del PRR)
.set DDRB, 0x4
.set PORTB, 0x5
.set OCR2A, 0xB3
.set TCCR2B, 0xB1
.set TCCR2A, 0xB0
.set PINB, 0x03
.set TCCR1A, 0x80
.set TCCR1B, 0x81
.set TIFR1, 0x16 // I/O
.set OCR1AL, 0x88
.set OCR1AH, 0x89

.global main

u_temps=255
	
carg:
	push r20
	push r21
	push r25
	push r16
	push r17
	ldi r20,u_temps // carguem el valor de u_temps
	ldi r21,0xFA // carguem el valor basic
	ldi r25,0 // carguem el zero per suma el carry
bucle:	cpi r20,0 // comparem per veure si hem de sortr del bucle
	breq surt
	add r16,r21 // sumem FA amb r16
	adc r17,r25 // pasem el carry
	dec r20
	rjmp bucle
surt:	//add r17,0x61
	//adc r16,0xA8
	sts OCR1AH,r17 // carreguem la part alta
	sts OCR1AL,r16 // carreguem la part baixa
	pop r17
	pop r16
	pop r25
	pop r21
	pop r20
	ret
	
espera:
	ldi r16,0b00001011 // preescaler 64 i timer 1 engegat
	sts TCCR1B,r16
comp:	
	sbis TIFR1,1 // mirem el bit OCF1A
	rjmp comp
	ldi r16,0b00001000 // apagem el timer
	sts TCCR1B,r16
	sbi TIFR1,1 // posem el TIFR a 1 per resetejar el contandor
	ret	
led:	
	sbi PORTB,5
	rcall espera
	cbi PORTB,5
	rcall espera
	rcall espera
	rjmp led

	
main:
	lds r16,PRR
	andi r16,0b10110111 // Posem a 0 el bit 3 i el 6 per engegar els dos timers 0 i 2
	sts PRR,r16

	ldi r16,0b01000010
	sts TCCR2A,r16

	ldi r16,0b00000100
	sts TCCR2B,r16

	ldi r16,124
	sts OCR2A,r16

	ldi r16,0b00100000
	out DDRB,r16

	ldi r16,0b00000000
	sts TCCR1A,r16

	ldi r16,0b00001000 //mode CTC (4) i timer apagat
	sts TCCR1B,r16
	rcall carg
	rjmp led
	
