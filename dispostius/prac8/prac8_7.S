.set DDRB_o , 0x4
.equ PORTB_o , 0x5
PORTD_o = 0x0b
DDRD_o = 0x0a

UDR0 = 0xc6
UBRR0H = 0xc5
UBRR0L = 0xc4
UCSR0C = 0xc2
UCSR0B = 0xC1
UCSR0A = 0xC0

DEBUGAR = 0
SALTA = 1


.global main
.global __vector_18

.section .text

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
	lds	r16,UDR0

	cpi	r16,0x5B //si es menor que 5B...
	brmi	majuscula //sera majuscula
	cpi	r16,0x61 //si es menor que 61...
	brmi 	res //saltem
	cpi	r16,0x80 //si es menor que 80
	brmi	es_minuscula
es_minuscula:
	cpi 	r16,0x7B
	brmi 	minuscula
	rjmp 	res
minuscula:
	subi	r16,0x20 //deduim que es minuscula i la transformem a majuscula
majuscula: //fins aqui funciona
	cpi r16,0x41 //si es menor que 41 saltem, si es major...es majuscula
	brmi res
	ldi r26,lo8(taulac1) //apuntador X de la primera llista
	ldi r27,hi8(taulac1)
	ldi r28,lo8(taulac2) //apuntador Y de la segona llista
	ldi r29,hi8(taulac2)
bucle:	ld r17,X
	ld r18,Y
	cp r16,r17 //si coincidex...hem localitzat la lletra
	breq lletra
	ld r17,X+
	ld r18,Y+
	brne bucle
lletra: mov r16,r18 //carreguem a r16 el valor de r18 (apuntat per Y)
	call tx
	reti
res:	call tx
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
	/*arreglem el bit U2X0 forçant el valor de reset
	al reglistre UCSR0A*/
	ldi	r16, 0b00100000
	sts	UCSR0A, r16
	
	/* enable rx, tx, amb interrpció de rx */
	ldi 	r16, 0b10011000
	sts	UCSR0B,r16

	/*habilitem interrupcions */
	sei

	/*el bucle principal no fa res*/
loop:	rjmp	loop
	ret


.section .data

.include "taula8.S"

texto:
	.ascii "Hola que tal"
texto_fin:

.section .bss
vegades:
	.byte 0
bufer:
	.space 32,0	/*repeteix 32 vegades, 1byte, amb valor 0. Mirar directiva .fill .skip també pot servir */

.global __do_copy_data
.global __do_clear_bss

     



