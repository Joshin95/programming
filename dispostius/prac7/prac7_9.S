.set UDR0,0xC6
.set UBRR0H,0xC5
.set UBRR0L,0xC4
.set UCSR0C,0xC2
.set UCSR0B,0xC1
.set UCSR0A,0xC0
.set SREG,0x3F
.global main

estat0:
	call rx
	call tx
	cp r8,r20 //comparem per veure si entra un r(ho repetim a cada estat)
	breq estat0
	cpi r20,0x2B
	breq omp41
	cpi r20,0x2D
	breq omp41
	rcall asc2val
	call tx
	mov r16,r20//bit de major pes del 1 operand
	rjmp estat1
estat1:
	call rx
	call tx
	cp r8,r20
	breq estat0
	cpi r20,0x2B
	breq omp31
	cpi r20,0x2D
	breq omp31
	rcall asc2val
	call tx
	mov r17,r20//bit de menor pes del 1 operand
	rjmp estat2
estat2:
	call rx
	call tx
	cp r8,r20
	breq estat0
	cpi r20,0x2B
	breq omp21
	cpi r20,0x2D
	breq omp21
	rcall asc2val
	call tx
	mov r18,r20//bit de major pes del 1 operand
	rjmp estat3
estat3:
	call rx
	call tx
	cp r8,r20
	breq estat0
	cpi r20,0x2B
	breq omp11
	cpi r20,0x2D
	breq omp11
	rcall asc2val
	call tx
	mov r19,r20//bit de menor pes del 1 operand
	rjmp estat4

	
estat4:
	call rx
	cp r8,r20
	breq estat0
	mov r25,r20//la operacio
	call tx
	rjmp estat5

omp41:
	ldi r16,0x00
omp31:	ldi r17,0x00
omp21:	ldi r18,0x00
omp11:	ldi r19,0x00
	mov r25,r20
	rjmp estat5

estat5:
	call rx
	call tx
	cp r8,r20
	breq estat00
	cpi r20,0x3D
	breq omp42
	rcall asc2val
	call tx
	mov r26,r20//bit de major pes del 2 operand
	rjmp estat6

estat6:
	call rx
	call tx
	cp r8,r20
	breq estat00
	cpi r20,0x3D
	breq omp32
	rcall asc2val
	call tx
	mov r27,r20//bit de menor pes del 2 operand
	rjmp estat7

estat7:
	call rx
	call tx
	cp r8,r20
	breq estat00
	cpi r20,0x3D
	breq omp22
	rcall asc2val
	call tx
	mov r28,r20//bit de major pes del 2 operand
	rjmp estat8
estat8:
	call rx
	call tx
	cp r8,r20
	breq estat00
	cpi r20,0x3D
	breq omp12
	rcall asc2val
	call tx
	mov r29,r20//bit de menor pes del 2 operand
	rjmp estat9


estat9:
	call rx
	call tx
	cp r8,r20
	breq estat00
fin:	cpi r20,0x3D
	breq igual
	brne estat00

estat00://llansadera, el branch es limitat en posicions de memoria de programa (fa la resta, maxim -64 i +63). Fem una llansadera
	rjmp estat0

omp42:
	ldi r26,0x00
omp32:	ldi r27,0x00
omp22:	ldi r28,0x00
omp12:	ldi r29,0x00
	rjmp fin

//reordenem els valors dels registres cap als registres de desti final
orden0:
	swap r16
	add r16,r17
	mov r1,r16
	ret
orden1:
	swap r18
	add r18,r19
	mov r0,r18
	ret
orden2:
	swap r26
	add r26,r27
	mov r3,r26
	ret
orden3:
	swap r28
	add r28,r29
	mov r2,r28
	ret
	
igual:
	rcall orden0
	rcall orden1
	rcall orden2
	rcall orden3
	cpi r25,0x2B
	breq suma1
	brne resta11
		
suma1:
	rcall suma
	ret
suma: 	
	/*mov r20,r0
	call tx
	mov r20,r1
	call tx
	mov r20,r2
	call tx
	mov r20,r3
	call tx*/
	add r0,r2
	adc r1,r3
	rcall signed
	rcall carry	
	mov r20,r1
	rcall val2asc
	mov r20,r0
	rcall val2asc
	rjmp estat0 
resta11:
	rcall resta2
	ret
resta2:
	sub r0,r2
	sbc r1,r3
	rcall signed
	rcall carry
	mov r20,r1
	rcall val2asc
	mov r20,r0
	rcall val2asc
	rjmp estat0

	
carry:
	brcs carryon
	brcc carryoff
carryon:
	ldi r20,0x31
	call tx
	ret
carryoff:
	ldi r20,0x30
	call tx
	ret

	
signed:
	brlt signedon
	brge signedoff
signedon:
	ldi r20,0x31
	call tx
	ret
signedoff:
	ldi r20,0x30
	call tx
	ret
	
	
asc2val:
	cpi r20,0x3A
	brmi es_num
	cpi r20,0x47
	brmi lletra
	rjmp res
es_num:
	cpi r20,0x30
	brmi res
	rjmp numero

//detectem els simbols	
lletra:
	sub r20,r4
	ret
numero:
	sub r20,r5
	ret
res:
	ldi r20,255
	ret

	
valor:

	cpi r20,0x0A
	brmi bin_num
	cpi r20,0x10
	brmi bin_lletra
	
bin_num:
	add r20,r5
	call tx
	ret
bin_lletra:
	add r20,r4
	call tx
	ret

val2asc:
	mov r30,r20
	and r20,r6
	swap r20
	rcall valor
	and r30,r7
	mov r20,r30
	rcall valor
	ret

rx:
	lds r24,UCSR0A
	sbrs r24,7/* el 7 indica que el dispositiu esta preparat per rebre dades */
	rjmp rx
	lds r20,UDR0 /* el lloc d'on agafes les dades */
	ret

tx:
	lds r23,UCSR0A
	sbrs r23,5/* el 5 indica que el dispositiu esta preparat per enviar dades */
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


	ldi r22,0x30//carregem el numero que resta 30 al valor en ASCII per detectar el numero
	ldi r21,0x37//carreguem el numero que suma 0x41-A al valor en binari per fer una lletra en ASCII
	ldi r30,0b11110000//mascara
	ldi r31,0b00001111//mascara
	ldi r16,0x72//r minuscula

	mov r4,r21
	mov r5,r22
	mov r6,r30
	mov r7,r31
	mov r8,r16
	
	rcall estat0

loop:
	rjmp loop
	
