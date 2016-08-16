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
	
u_temps_L = 0b0011000011010100 // 12500, 200 ms (200/0,016)
u_temps_L_h = 0b00110000 
u_temps_L_l = 0b11010100

u_temps_H = 0b0111101000010010 // 31250, 500 ms (500/0,016)
u_temps_H_h = 0b01111010
u_temps_H_l = 0b00010010

__vector_1:
	
estat0:
	ldi r20,'A'
	call tx
	cpi r31,1
	breq estat1
	cpi r31,2
	breq estat2
	ldi r20,'B'
	call tx
	rcall compflanc
	cpi r17,'H' // comparem que ha retornat la funcio compflanc
	mov r20,r17
	call tx
	breq pujada
	brne baixada
pujada: 
	ldi r31,1
	rcall compllindar //timer_on
	reti
baixada:
	ldi r31,0
	reti
estat1:
	cpi r31,2
	breq estat2
	rcall compflanc //retorna el resultat a r17
	rcall compllindar //retorna el resultat a r18
	//mov r20,r18
	//call tx
	cpi r18,'o'
	breq overflow
	cpi r17,'H' // comparem que ha retornat la funcio compflanc
	breq pujada2
	brne baixada2

overflow:
	//rcall timer_off
	ldi r20,'E' // error pk no rebem cap punt ni ralla
	call tx
	ldi r31,0
	reti
pujada2:
	reti
baixada2:
	cpi r18,'.' //if t<llindarL
	breq tmenor
	brne tmajor //else
tmenor:
	inc r23 //incrementem la llargada de la paraula rBB
	lsl r22
	ori r22,0 //guardar P
	//rcall reset_timer
	//read timer
	ldi r31,2
	rcall compllindar
	reti
tmajor:
	inc r23
	lsl r22
	ori r22,1 //guardar R
	//rcall reset_timer
	//read timer
	ldi r31,2
	rcall compllindar
	reti

estat2:
	rcall compllindar //if overflow timer
	mov r20,r18
	call tx
	cpi r18,'o'
	breq overflow2
	cpi r17,'H'
	breq pujada3
	brne baixada3
overflow2:
	//rcall timer_off
	rcall crea_codi //print lletra
	ldi r20,' '
	call tx
	ldi r31,0
	reti
	//if flanc de pujada
pujada3:
	ldi r31,1
	rcall compllindar
	cpi r18,'.' //if t<LlindarL
	breq tornare1
	brne continuar
tornare1:
	ldi r31,1
	reti
continuar:
	cpi r18,'e' //if t>H
	breq lletra
	brne paraula
lletra:
	rcall crea_codi //print lletra
	ldi r20,' '
	call tx
	reti
paraula:
	//if L<t<H
	rcall crea_codi//printa lletra
	reti
baixada3:
	reti

timer_on:	//definir inci timer
timer_off:	//definir final timer
reset_timer:	//definir reset timer
	
//10.1
compflanc:
	in r18,PIND
	sbrc r18,2
	rjmp High
	rjmp Low
Low:
	ldi r17,'L'
	ret
High:
	ldi r17,'H'
	ret
//10.2

compllindar:	
	brtc Primer
	rjmp Segon
Primer:
	ldi r16,0b00001100 //mode normal 100 al final per tenir preescaler a 256 i iniciar el timer
	sts TCCR1B,r16
	set
	ret
	
Segon:	sbic TIFR1,1
	rjmp over
	ldi r16,0b00001000 //parem timer
	sts TCCR1B,r16
	lds r24,TCNT1L
	lds r25,TCNT1H
	//mov r20,r24
	//call tx
	//mov r20,r25
	//call tx
	cpi r25,u_temps_H_h
	brpl mes_gran1
	cpi r25,u_temps_L_h
	brpl mes_gran2
mes_petit:	
	ldi r18,'.'
	rjmp surt	
mes_gran1:
	ldi r18,'e'
	rjmp surt
mes_gran2:
	ldi r18,'-'
	rjmp surt
over:
	ldi r18,'o'
	sbi TIFR1,1
	rjmp surt

surt:	ldi r16,0x00
	sts TCNT1H,r16
	sts TCNT1L,r16
	clt
	ret
	
//r22 rAA....r23 rBB

crea_codi:
	lsl r22
	lsl r22
	lsl r22
	or r22,r23

troba_codi:
	ldi r26,lo8(taulac1) //apuntador X de la primera llista
	ldi r27,hi8(taulac1)
	ldi r28,lo8(taulac2) //apuntador Y de la segona llista
	ldi r29,hi8(taulac2)
	ldi r30,lo8(taulac2_fin)
bucle:	ld r17,X
	ld r18,Y
	cp r22,r18 //si coincidex...hem localitzat la xifra
	breq xifra
	ld r17,X+
	ld r18,Y+
	cp r28,r30
	breq res
	brne bucle
xifra:
	mov r20,r17 //carreguem a r16 el valor de r17 (apuntat per X
	call tx
	ret
res:	call tx
	ret	
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

	ldi r31,0
	ldi r23,0
	ldi r22,0
	clt
	sei

loop:	rjmp loop
	
.section .data
.include "taula9.S"
.global __do_copy_data
