.set UDR0,0xC6
.set UBRR0H,0xC5
.set UBRR0L,0xC4
.set UCSR0C,0xC2
.set UCSR0B,0xC1
.set UCSR0A,0xC0

.global main

estat0://no retorna amb overflow
	call rx
	mov r20,r16
	call tx
	rcall asc2val
	mov r1,r20//bit de major pes del 1 operand
	rjmp estat1
estat1:
	call rx
	mov r20,r16
	call tx
	rcall asc2val
	mov r0,r16//bit de menor pes del 1 operand
	rjmp estat2
estat2:
	call rx
	mov r27,r16//la operacio
	mov r20,r16
	call tx
	rjmp estat3
estat3:
	call rx
	mov r20,r16
	call tx
	rcall asc2val
	mov r3,r16//bit de major pes del 2 operand
	rjmp estat4
estat4:
	call rx
	mov r20,r16
	call tx
	rcall asc2val
	mov r2,r16//bit de menor pes del 2 operand
	rjmp estat5
estat5:
	call rx
	mov r20,r16
	call tx
	cpi r16,0x3D
	breq igual
	brne estat0
igual:	cpi r27,0x2B
	breq suma1
	brne resta11
		
suma1:
	rcall suma
	ret
suma:
	add r0,r2
	adc r1,r3
	mov r20,r1
	rcall val2asc
	mov r20,r0
	rcall val2asc
	rjmp estat0 
resta11:
	rcall resta2
	ret
resta1:
	com r2
	com r3
	add r2,r4
	adc r3,r5
	rcall suma
	rjmp estat0
resta2:
	sub r0,r2
	sbc r1,r3
	mov r20,r1
	rcall val2asc
	call tx
	mov r20,r0
	rcall val2asc
	call tx
	rjmp estat0

asc2val:
	cpi r20,0x41
	brmi es_num
	cpi r20,0x47
	brmi lletra
	rjmp res

es_num:
	cpi r20,0x30
	brmi res
	cpi r20,0x40
	brmi numero

//detectem els simbols	
lletra:
	sub r20,r27
	ret
numero:
	sub r20,r26
	mov r16,r20
	ret
res:
	ldi r20,255
	mov r16,r20
	ret

	
val2asc:
	cpi r20,0x0A
	brmi bin_num
	cpi r20,0x10
	brmi bin_lletra
	rjmp mesgran
bin_num:
	add r20,r26
	ret
bin_lletra:
	add r20,r27
	ret
mesgran:
	mov r29,r20
	and r20,r30
	rcall val2asc
	call tx
	and r29,r31
	rcall val2asc
	mov r20,r29
	call tx
	rjmp estat0
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

	/*ldi r20,0x03
	ldi r21,0x00
	ldi r22,0x01
	ldi r23,0x00
	ldi r24,0x01//Sempre ha de ser un per fer el complement A2
	ldi r25,0x00//Sempre ha de ser zero per sumar nomes el carry*/
	
	ldi r26,0x30//carregem el numero que resta 30 al valor en ASCII per detectar el numero
	ldi r27,0x37//carreguem el numero que suma 0x41-A al valor en binari per fer una lletra en ASCII
	ldi r20,0x0F

	ldi r30,0b11110000//mascara
	ldi r31,0b00001111//mascara
	
	mov r0,r20
	mov r1,r21
	mov r2,r22
	mov r3,r23
	mov r4,r24
	mov r5,r25
		
	rcall estat0

loop:
	rjmp loop
	
