.set DDRB,0x04
.set PORTB,0x05
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
	lds r25,UDR0 /* el lloc d'on agafes les dades */
	ret

tx:
	lds r17,UCSR0A
	sbrs r17,5/* el 5 indica que el dispositiu esta preparat per enviar dades */
	rjmp tx
	sts UDR0,r26 /* el lloc on envies les dades */
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

	ldi r16,0xFF
	out DDRB,r16

comp1:
	ldi r20,0x6E
	ldi r21,0x4E
	cpse r20,r25
	rjmp comp2
	rjmp bucle
comp2:	cpse r21,r25
	rjmp apg
	rjmp bucle
bucle:	ldi r23,0x2F
bucle1:	ldi r24,0x01
	ldi r27,0x39
	add r23,r24
	mov r26,r23
	call tx
	cpse r23,r27
	rjmp bucle1
	rjmp loop
apg: /*aqui ara fariem un bucle 10 vegades per transmetre 0,1,2,3,4,5,6,7,8,9*/
	ldi r26,0x4E
	rjmp loop1
loop:
	call rx
	rjmp comp1
loop1:	call tx
	rjmp loop
