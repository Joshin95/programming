.set DDRB, 0x4
.equ PORTB, 0x5
PORTD_o = 0x0b
DDRD_o = 0x0a
UDR0 = 0xc6
UBRR0H = 0xc5
UBRR0L = 0xc4
UCSR0C = 0xc2
UCSR0B = 0xC1
UCSR0A = 0xC0

.global main
.global __vector_18
.global __vector_20
	
/* rutina de transmissió de byte,
el valor a transmetre està al registre r16 */
	
tx:
	cpse	r16,r18
	rjmp    enviament_0
	rjmp 	enviament_N
	
enviament_N:
	sts	UDR0,r16
	ldi 	r16, 0b10011000
	sts	UCSR0B,r16
	rjmp 	exit2

enviament_0:
	ldi 	r16, 0b11011000
	sts	UCSR0B,r16
	ldi	r16,0x30
	sts	UDR0,r16
	rjmp 	exit2
	
exit2:
	ret

__vector_20:	
	add 	r20,r23  /*Suma r21 que te un 1, a r20, que comensa am 0, que es va actualitzant*/
	mov	r16,r20
	sts	UDR0,r16
	cpse 	r20,r22
	reti
	ldi 	r16, 0b10011000
	sts	UCSR0B,r16
	ldi 	r20,0x30
	reti
	
/* defineixo la rutina d'interrupció
per recepció de byte a la USART */
__vector_18:
	ldi 	r16, 0b11011000
	sts	UCSR0B,r16
	lds     r16,UDR0
	cpse r16,r18
	rjmp es_n
	rjmp envia_0

es_n:	cpse r16,r19
	rjmp envia_N
	rjmp envia_0
	
envia_N:
	mov r16,r18
	call tx
	rjmp exit
	
envia_0:
	ldi r16,0x30
	call tx
	rjmp exit
	
exit:	
	reti
	

main:
	/* set baud rate a 9600*/
	ldi	r16, 0
	sts	UBRR0H,r16
	ldi	r16, 103
	sts	UBRR0L,r16

	/* set frame format */
	/* el valor de reset ja és correcte:
	asíncron, sense paritat, 1 stop, 8 dades,
	velocitat normal, cominicació no multiprocessor */
	/*assegurem el que volem encara que en reset ja ho sigui*/
	ldi	r16, 0b00100000
	sts	UCSR0A, r16

	ldi	r16, 0b00000110
	sts	UCSR0C, r16
	
	/* enable rx, tx, amb interrpció de rx */
	ldi 	r16, 0b11011000
	sts	UCSR0B,r16
	
	/* configuració dels pins, és possible que no calgui*/
	ldi	r16,0b00000010
	out	DDRD_o,r16

	/*habilitem interrupcions */
	sei

	ldi r18,0x4E /*Lletra N*/
	ldi r19,0x6E /*Lletra n*/
	ldi r20,0x30 /*Numero 0*/
	ldi r21,0x31 /*Numero 1*/
	ldi r22,0x39 /*Numero 9*/
	ldi r23,0x01
	
	/*el bucle principal no fa res*/
loop:
	rjmp	loop
	

	
     

