
//r16 rAA....r17 rBB

crea_codi:
	lsl r16
	lsl r16
	lsl r16
	or r16,r17

troba_codi:
	ldi r26,lo8(taulac1) //apuntador X de la primera llista
	ldi r27,hi8(taulac1)
	ldi r28,lo8(taulac2) //apuntador Y de la segona llista
	ldi r29,hi8(taulac2)
	ldi r30,lo8(taulac2_fin)
bucle:	ld r17,X
	ld r18,Y
	cp r16,r18 //si coincidex...hem localitzat la xifra
	breq xifra
	ld r17,X+
	ld r18,Y+
	cp r28,r30
	breq res
	brne bucle
xifra: mov r16,r17 //carreguem a r16 el valor de r17 (apuntat per X)
	call tx
	reti
res:	call tx
	reti
