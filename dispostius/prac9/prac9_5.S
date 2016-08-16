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
.set UDR0,0xC6
.set UBRR0H,0xC5
.set UBRR0L,0xC4
.set UCSR0C,0xC2
.set UCSR0B,0xC1
.set UCSR0A,0xC0

.global main
.section .text

u_temps=50
	
carg:
	push r20
	push r21
	push r25
	push r16
	push r17
	ldi r20,u_temps // carguem el valor de u_temps
	ldi r21,0xFA // carguem el valor basic
	ldi r25,0 // carguem el zero per suma el carry
bucleb:	cpi r20,0 // comparem per veure si hem de sortr del bucle
	breq surt
	add r16,r21 // sumem FA amb r16
	adc r17,r25 // pasem el carry
	dec r20
	rjmp bucleb
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

comptaula:	
	ldi r26,lo8(taulac1) //apuntador X de la primera llista
	ldi r27,hi8(taulac1)
	ldi r28,lo8(taulac2) //apuntador Y de la segona llista
	ldi r29,hi8(taulac2)
	ldi r30,lo8(taulac2_fin)
bucle:	ld r17,X
	ld r18,Y
	cp r16,r17 //si coincidex...hem localitzat la xifra
	breq xifra
	ld r17,X+
	ld r18,Y+
	cp r28,r30
	breq res
	brne bucle
xifra:
	mov r16,r18
	ret
res:	rjmp res
	
espera:
	ldi r16,0b00001011 // reescaler 64 i timer 1 engegat
	sts TCCR1B,r16
comp:
	sbis TIFR1,1 // mirem el bit OCF1A
	rjmp comp
	ldi r16,0b00001000 // apagem el timer
	sts TCCR1B,r16
	sbi TIFR1,1 // posem el TIFR a 1 per resetejar el contandor
	ret
timer2off:
	cbi PORTB,5 //apaguem el led
	ldi r16,0b00000000 // apaguem el timer
	sts TCCR2B,r16
	ret
timer2on:
	sbi PORTB,5 //encenem el led
	ldi r16,0b00000100 // encenem el timer
	sts TCCR2B,r16
	ret
punt: 
	rcall timer2on
	rcall espera
	rcall timer2off
	rcall espera
	ret
ralla:
	rcall timer2on
	rcall espera
	rcall espera
	rcall espera
	rcall timer2off
	rcall espera
	ret

morse:	
	call rx
	cpi r16,0x20
	breq espai
	rcall comptaula
	push r16
	andi r16,0b11111000 // dividim les parts de codificacio i del numero de bits que volem mirar
	mov r17,r16
	pop r16
	andi r16,0b00000111
	mov r18,r16
compllarg:
	cpi r18,0 //comparacio per quan arribem a 0 (tot el codi extret)
	breq zero
	rol r17 //rotem per passar el bit 7 al Carry
	brcs rallago
	brcc puntgo
rallago:
	rcall ralla
	dec r18
	rjmp compllarg
puntgo:
	rcall punt
	dec r18
	rjmp compllarg
zero:
	rcall espera
	rcall espera
	rjmp morse
espai:
	rcall espera
	rcall espera
	rcall espera
	rcall espera
	rjmp morse
	
rx:
	lds r16,UCSR0A
	sbrs r16,7/* el 7 indica que el dispositiu esta preparat per rebre dades */
	rjmp rx
	lds r16,UDR0 /* el lloc d'on agafes les dades */
	ret

tx:
	lds r21,UCSR0A
	sbrs r21,5/* el 5 indica que el dispositiu esta preparat per enviar dades */
	rjmp tx
	sts UDR0,r20 /* el lloc on envies les dades */
	ret
	
main:
	ldi r16,0
	sts UBRR0H,r16
	ldi r16,103 /*Es la velocitat de transimssio,pag 190*/
	sts UBRR0L,16
	ldi r16,0b00100000/* el 1 indica que el registre que rep les dades esta buit*/
	sts UCSR0A,r16
	ldi r16,0b00000110 /*els dos primers bits indiquen si es asincron i els dos uns indiquen lamplada de dades (8bits) pag 194*/
	sts UCSR0C,r16
	ldi r16,0b00011000/*engega el tx i rx al lloc dels uns*/
	sts UCSR0B,r16
	
	lds r16,PRR
	andi r16,0b10110111 // Posem a 0 el bit 3 i el 6 per engegar els dos timers 0 i 2
	sts PRR,r16

	ldi r16,0b01000010
	sts TCCR2A,r16

	ldi r16,0b00000000
	sts TCCR2B,r16

	ldi r16,124
	sts OCR2A,r16

	ldi r16,0b00101000
	out DDRB,r16

	ldi r16,0b00000000
	sts TCCR1A,r16

	ldi r16,0b00001000 //mode CTC (4) i timer apagat
	sts TCCR1B,r16

	rcall carg

	rjmp morse
	
.section .data
.include "taula9.S"
.global __do_copy_data
