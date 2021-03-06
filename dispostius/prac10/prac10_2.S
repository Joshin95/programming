EICRA = 0x69
EIMSK = 0x1D
EIFR = 0x1C
.set UDR0,0xC6
.set UBRR0H,0xC5
.set UBRR0L,0xC4
.set UCSR0C,0xC2
.set UCSR0B,0xC1
.set UCSR0A,0xC0
PORTD = 0x0B
DDRD = 0x0A
PIND = 0x09
TCNT1H = 0x85
TCNT1L = 0x84
.set OCR2A, 0xB3
.set TCCR2B, 0xB1
.set TCCR2A, 0xB0
.set TCCR1A, 0x80
.set TCCR1B, 0x81
.set TIFR1, 0x16 // I/O
.set OCR1AL, 0x88
.set OCR1AH, 0x89
.set SREGG, 0x3F // utilitzem el bit 6 que es el flag T
.set PRR, 0x64
	
.global main
.global __vector_1

u_temps = 0b0011000011010100 // 12500, 200 ms (200/0,016)
u_temps_h = 0b00110000 
u_temps_l = 0b11010100

__vector_1:
	brtc Primer
	rjmp Segon
Primer:
	ldi r16,0b00001100 //mode normal 100 al final per tenir preescaler a 256 i iniciar el timer
	sts TCCR1B,r16
	set
	reti
	
Segon:	sbic TIFR1,1
	rjmp over
	ldi r16,0b00001000 //parem timer
	sts TCCR1B,r16
	lds r24,TCNT1L
	lds r25,TCNT1H
	mov r20,r24
	call tx
	mov r20,r25
	call tx
	cpi r25,u_temps_h
	brpl mes_gran
comp_l:
	cpi r24,u_temps_l
	brpl mes_gran
mes_petit:	
	ldi r20,'-'
	call tx
	rjmp surt	
mes_gran:
	ldi r20,'+'
	call tx
	rjmp surt
over:
	ldi r20,'o'
	call tx
	sbi TIFR1,1
	rjmp surt

surt:	ldi r16,0x00
	sts TCNT1H,r16
	sts TCNT1L,r16
	clt
	reti
	
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
	ldi r16,0b00011000/*activa el rx i tx*/
	sts UCSR0B,r16
	
	ldi r16,0b00000001 //habilita canvi en logic change
	sts EICRA,r16
	ldi r16,0b00000001 //habilita INT0
	out EIMSK,r16

	cbi DDRD,2
	sbi PORTD,2

	ldi r16,0b00000000
	sts TCCR1A,r16

	ldi r16,0b00001000 //mode ctc i timer apagat. 
	sts TCCR1B,r16

	ldi r17,0xFF
	sts OCR1AH,r17 // carreguem la part alta
	sts OCR1AL,r17 // carreguem la part baixa

	clt
	sei

loop:
	rjmp loop
