.set DDRB,0x4
.set PORTB,0x5
.set PORTD,0x0B
.set DDRD,0x0A
.set UDR0,0xC6
.set UBRR0H,0xC5
.set UBRR0L,0xC4
.set UCSR0C,0xC2
.set UCSR0B,0xC1
.set UCSR0A,0xC0

.global main

rx:
	lds r16,UCSR0A
	sbrs r16,7/* el 7 indica que el dispositiu esta preparat per rebre dades */
	rjmp rx
	lds r16,UDR0 /* el lloc d'on agafes les dades */
	ret

tx:
	lds r17,UCSR0A
	sbrs r17,5/* el 5 indica que el dispositiu esta preparat per enviar dades */
	rjmp tx
	sts UDR0,r16 /* el lloc on envies les dades */
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
	ldi r16,0b00000010
	out DDRD,r16

loop:
	call rx
	call tx
	rjmp loop
