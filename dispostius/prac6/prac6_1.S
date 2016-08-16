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

/* rutina de transmissió de byte,
el valor a transmetre està al registre r16 */
tx:
	lds 	r17,UCSR0A 
	sbrs	r17,5
	rjmp	tx
	sts	UDR0,r16
	ret

/* defineixo la rutina d'interrupció
per recepció de byte a la USART */
__vector_18:
	lds r16,UDR0
	out PORTB,r23
	cpse r19,r23
	rjmp es_u
	cpse r16,r20
	rjmp estat0
	ldi r19,0x01
	ldi r16,'2'
	call tx
	rjmp exit
	
es_u:	
	cpse r19,r25 
	rjmp es_dos
	cpse r16,r21
	rjmp es_l
	ldi r19,0x02
	ldi r16,'1'
	call tx
	rjmp exit

es_dos:	cpse r19,r26
	rjmp es_tres
	cpse r16,r22
	rjmp es_l
	rjmp es_tres

es_tres:
	ldi r16,'0'
	call tx
	out PORTB,r24
	ldi r19,0x00
	rjmp exit

es_l:	cpse r16,r20
	rjmp estat0
	ldi r16,'2'
	call tx
	rjmp exit

estat0:	ldi r19,0
	ldi r16,'3'
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
	ldi 	r16, 0b10011000
	sts	UCSR0B,r16
	
	/* configuració dels pins, és possible que no calgui*/
	ldi	r16,0b00000010
	out	DDRD_o,r16


	ldi r23,0x00
	ldi r24,0xFF
	ldi r25,0x01
	ldi r26,0x02
	ldi r27,0x03
	out DDRB,r24
	ldi r19,0x00
	ldi r20,0x6C /*l*/
	ldi r21,0x65 /*e*/	
	ldi r22,0x64 /*d*/

	/*habilitem interrupcions */
	sei

	
	/*el bucle principal no fa res*/
loop:	rjmp	loop
	ret

	
     

