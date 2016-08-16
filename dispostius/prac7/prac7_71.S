 .set UDR0,0xC6
.set UBRR0H,0xC5
.set UBRR0L,0xC4
.set UCSR0C,0xC2
.set UCSR0B,0xC1
.set UCSR0A,0xC0

.global main

estat0:
	call rx
	call tx
	cp r26,r20 //comparem per veure si entra un r(ho repetim a cada estat)
	breq estat0
	rcall asc2val
	call tx
	mov r16,r20//bit de major pes del 1 operand
	rjmp estat1
estat1:
	call rx
	call tx
	cp r26,r20 //comparem per veure si entra un r(ho repetim a cada estat)
	breq estat0
	rcall asc2val
	call tx
	mov r17,r20//bit de menor pes del 1 operand
	rcall orden0
	mov r7,r16
	rjmp estat2
estat2:
	call rx
	call tx
	cp r26,r20 //comparem per veure si entra un r(ho repetim a cada estat)
	breq estat0
	rcall asc2val
	call tx
	mov r18,r20//bit de major pes del 1 operand
	rjmp estat3

estat3:
	call rx
	call tx
	cp r26,r20 //comparem per veure si entra un r(ho repetim a cada estat)
	breq estat0
	rcall asc2val
	call tx
	mov r19,r20//bit de major pes del 1 operand
	rcall orden1
	mov r6,r18
	rjmp estat4
estat4:
	call rx
	call tx
	cp r26,r20 //comparem per veure si entra un r(ho repetim a cada estat)
	breq estat0
	rcall asc2val
	call tx
	mov r16,r20//bit de major pes del 1 operand
	rjmp estat5

estat00://llansadera, el branch es limitat en posicions de memoria de programa (fa la resta, maxim -64 i +63). Fem una llansadera
	rjmp estat0
	
estat5:
	call rx
	call tx
	cp r26,r20 //comparem per veure si entra un r(ho repetim a cada estat)
	breq estat00
	rcall asc2val
	call tx
	mov r17,r20//bit de menor pes del 1 operand
	rcall orden0
	mov r5,r16
	rjmp estat6
estat6:
	call rx
	call tx
	cp r26,r20 //comparem per veure si entra un r(ho repetim a cada estat)
	breq estat00
	rcall asc2val
	call tx
	mov r18,r20//bit de major pes del 1 operand
	rjmp estat7

estat7:
	call rx
	call tx
	cp r26,r20 //comparem per veure si entra un r(ho repetim a cada estat)
	breq estat00
	rcall asc2val
	call tx
	mov r19,r20//bit de major pes del 1 operand
	rcall orden1
	mov r4,r18
	rjmp estat8
estat8:
	call rx
	call tx
	cp r26,r20 //comparem per veure si entra un r(ho repetim a cada estat)
	breq estat00
	rcall asc2val
	call tx
	mov r16,r20//bit de major pes del 1 operand
	rjmp estat9
estat9:
	call rx
	call tx
	cp r26,r20 //comparem per veure si entra un r(ho repetim a cada estat)
	breq estat00
	rcall asc2val
	call tx
	mov r17,r20//bit de menor pes del 1 operand
	rcall orden0
	mov r3,r16
	rjmp estat10
estat10:
	call rx
	call tx
	cp r26,r20 //comparem per veure si entra un r(ho repetim a cada estat)
	breq estat01
	rcall asc2val
	call tx
	mov r18,r20//bit de major pes del 1 operand
	rjmp estat11

estat11:
	call rx
	call tx
	cp r26,r20 //comparem per veure si entra un r(ho repetim a cada estat)
	breq estat01
	rcall asc2val
	call tx
	mov r19,r20//bit de major pes del 1 operand
	rcall orden1
	mov r2,r18
	rjmp estat12
	
estat01://llansadera, el branch es limitat en posicions de memoria de programa (fa la resta, maxim -64 i +63). Fem una llansadera
	rjmp estat0
	
estat12:
	call rx
	call tx
	cp r26,r20 //comparem per veure si entra un r(ho repetim a cada estat)
	breq estat01
	rcall asc2val
	call tx
	mov r16,r20//bit de major pes del 1 operand
	rjmp estat13
estat13:
	call rx
	call tx
	cp r26,r20 //comparem per veure si entra un r(ho repetim a cada estat)
	breq estat01
	rcall asc2val
	call tx
	mov r17,r20//bit de menor pes del 1 operand
	rcall orden0
	mov r1,r16
	rjmp estat14
estat14:
	call rx
	call tx
	cp r26,r20 //comparem per veure si entra un r(ho repetim a cada estat)
	breq estat01
	rcall asc2val
	call tx
	mov r18,r20//bit de major pes del 1 operand
	rjmp estat15

estat15:
	call rx
	call tx
	cp r26,r20 //comparem per veure si entra un r(ho repetim a cada estat)
	breq estat01
	rcall asc2val
	call tx
	mov r19,r20//bit de major pes del 1 operand
	rcall orden1
	mov r0,r18
	rjmp estat16

estat16: //la operacio
	call rx
	cp r26,r20 //comparem per veure si entra un r(ho repetim a cada estat)
	breq estat01
	mov r25,r20//la operacio
	call tx
	rjmp estat17

estat17:
	call rx
	call tx
	cp r26,r20 //comparem per veure si entra un r(ho repetim a cada estat)
	breq estat01
	rcall asc2val
	call tx
	mov r16,r20//bit de major pes del 1 operand
	rjmp estat18
estat18:
	call rx
	call tx
	cp r26,r20 //comparem per veure si entra un r(ho repetim a cada estat)
	breq estat02
	rcall asc2val
	call tx
	mov r17,r20//bit de menor pes del 1 operand
	rcall orden0
	mov r15,r16
	rjmp estat19
estat19:
	call rx
	call tx
	cp r26,r20 //comparem per veure si entra un r(ho repetim a cada estat)
	breq estat02
	rcall asc2val
	call tx
	mov r18,r20//bit de major pes del 1 operand
	rjmp estat20

estat20:
	call rx
	call tx
	cp r26,r20 //comparem per veure si entra un r(ho repetim a cada estat)
	breq estat02
	rcall asc2val
	call tx
	mov r19,r20//bit de major pes del 1 operand
	rcall orden1
	mov r14,r18
	rjmp estat21
estat21:
	call rx
	call tx
	cp r26,r20 //comparem per veure si entra un r(ho repetim a cada estat)
	breq estat02
	rcall asc2val
	call tx
	mov r16,r20//bit de major pes del 1 operand
	rjmp estat22
estat22:
	call rx
	call tx
	cp r26,r20 //comparem per veure si entra un r(ho repetim a cada estat)
	breq estat02
	rcall asc2val
	call tx
	mov r17,r20//bit de menor pes del 1 operand
	rcall orden0
	mov r13,r16
	rjmp estat23

estat02://llansadera, el branch es limitat en posicions de memoria de programa (fa la resta, maxim -64 i +63). Fem una llansadera
	rjmp estat0
	
estat23:
	call rx
	call tx
	cp r26,r20 //comparem per veure si entra un r(ho repetim a cada estat)
	breq estat02
	rcall asc2val
	call tx
	mov r18,r20//bit de major pes del 1 operand
	rjmp estat24
	
estat24:
	call rx
	call tx
	cp r26,r20 //comparem per veure si entra un r(ho repetim a cada estat)
	breq estat02
	rcall asc2val
	call tx
	mov r19,r20//bit de major pes del 1 operand
	rcall orden1
	mov r12,r18
	rjmp estat25
estat25:
	call rx
	call tx
	cp r26,r20 //comparem per veure si entra un r(ho repetim a cada estat)
	breq estat02
	rcall asc2val
	call tx
	mov r16,r20//bit de major pes del 1 operand
	rjmp estat26
estat26:
	call rx
	call tx
	cp r26,r20 //comparem per veure si entra un r(ho repetim a cada estat)
	breq estat02
	rcall asc2val
	call tx
	mov r17,r20//bit de menor pes del 1 operand
	rcall orden0
	mov r11,r16
	rjmp estat27
estat27:
	call rx
	call tx
	cp r26,r20 //comparem per veure si entra un r(ho repetim a cada estat)
	breq estat02
	rcall asc2val
	call tx
	mov r18,r20//bit de major pes del 1 operand
	rjmp estat28

estat28:
	call rx
	call tx
	cp r26,r20 //comparem per veure si entra un r(ho repetim a cada estat)
	breq estat03
	rcall asc2val
	call tx
	mov r19,r20//bit de major pes del 1 operand
	rcall orden1
	mov r10,r18
	rjmp estat29
estat29:
	call rx
	call tx
	cp r26,r20 //comparem per veure si entra un r(ho repetim a cada estat)
	breq estat03
	rcall asc2val
	call tx
	mov r16,r20//bit de major pes del 1 operand
	rjmp estat30
estat30:
	call rx
	call tx
	cp r26,r20 //comparem per veure si entra un r(ho repetim a cada estat)
	breq estat03
	rcall asc2val
	call tx
	mov r17,r20//bit de menor pes del 1 operand
	rcall orden0
	mov r9,r16
	rjmp estat31
estat31:
	call rx
	call tx
	cp r26,r20 //comparem per veure si entra un r(ho repetim a cada estat)
	breq estat03
	rcall asc2val
	call tx
	mov r18,r20//bit de major pes del 1 operand
	rjmp estat32

estat32:
	call rx
	call tx
	cp r26,r20 //comparem per veure si entra un r(ho repetim a cada estat)
	breq estat03
	rcall asc2val
	call tx
	mov r19,r20//bit de major pes del 1 operand
	rcall orden1
	mov r8,r18
	rjmp estat33

estat03://llansadera, el branch es limitat en posicions de memoria de programa (fa la resta, maxim -64 i +63). Fem una llansadera
	rjmp estat0
	


estat33:	
	call rx
	call tx
fin:	cpi r20,0x3D
	breq igual
	brne estat03


//reordenem els valors dels registres cap als registres de desti final
orden0:
	swap r16
	add r16,r17
	call tx
	ret
orden1:
	swap r18
	add r18,r19
	ret
	
igual:
	cpi r25,0x2B
	breq suma1
	brne resta11
		
suma1:
	rcall suma
suma: 	
	add r0,r8
	adc r1,r9
	adc r2,r10
	adc r3,r11
	adc r4,r12
	adc r5,r13
	adc r6,r14
	adc r7,r15
	mov r20,r7
	rcall val2asc
	mov r20,r6
	rcall val2asc
	mov r20,r5
	rcall val2asc
	mov r20,r4
	rcall val2asc
	mov r20,r3
	rcall val2asc
	mov r20,r2
	rcall val2asc
	mov r20,r1
	rcall val2asc
	mov r20,r0
	rcall val2asc
	
	rjmp estat03 
resta11:
	rcall resta2
	ret
resta2:
	sub r0,r8
	sbc r1,r9
	sbc r2,r10
	sbc r3,r11
	sbc r4,r12
	sbc r5,r13
	sbc r6,r14
	sbc r7,r15
	mov r20,r7
	rcall val2asc
	mov r20,r6
	rcall val2asc
	mov r20,r5
	rcall val2asc
	mov r20,r4
	rcall val2asc
	mov r20,r3
	rcall val2asc
	mov r20,r2
	rcall val2asc
	mov r20,r1
	rcall val2asc
	mov r20,r0
	rcall val2asc

	rjmp estat03

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
	sub r20,r21
	ret
numero:
	sub r20,r22
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
	add r20,r22
	call tx
	ret
bin_lletra:
	add r20,r21
	call tx
	ret

val2asc:
	mov r30,r20
	andi r20,0b11110000
	swap r20
	rcall valor
	andi r30,0b00001111
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
	ldi r26,0x72//r minuscula
	
	rcall estat0

loop:
	rjmp loop
	
