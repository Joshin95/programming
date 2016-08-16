EICRA = 0x69
EIMSK = 0x1D
EIFR = 0x1C
SREG = 0x3F
.set UDR0,0xC6
.set UBRR0H,0xC5
.set UBRR0L,0xC4
.set UCSR0C,0xC2
.set UCSR0B,0xC1
.set UCSR0A,0xC0
PORTD = 0x0B
DDRD = 0x0A
PIND = 0x09
	
.global main
.global __vector_1

__vector_1:
	in r18,PIND
	sbrc r18,2
	rjmp Low
	rjmp High
Low:
	ldi r20,'L'
	call tx
	reti
High:
	ldi r20,'H'
	call tx
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
	ldi r16,0b00011000/*engega el tx i rx al lloc dels uns*/
	sts UCSR0B,r16
	
	ldi r16,0b00000001
	sts EICRA,r16
	ldi r16,0b00000001
	out EIMSK,r16
	
	cbi DDRD,2 //com a entrada
	sbi PORTD,2 //pullup
 	
	sei

loop:
	rjmp loop
