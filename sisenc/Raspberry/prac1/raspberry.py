import serial, math, time


def goertzel(entrada):
    global mostra, mostra_1, mostra_2, coef, N, freq_L, freq_H, val_g_L, val_g_H, estat, llindar, t1, t0
    
    for i in range(8):
        mostra[i]=entrada+((mostra_1[i]*coef[i]))-mostra_2[i]
        #mostra.append(entrada+((mostra_1[i]*coef[i]))-mostra_2[i])
        mostra_2[i] = mostra_1[i]
        mostra_1[i] = mostra[i]

    N=N+1

    if (N==197):
        for i in range(8):
            prod1 = (mostra_1[i] * mostra_1[i]) + (mostra_2[i] * mostra_2[i])
            prod2 = ((mostra_1[i] * coef[i]))*mostra_2[i]
            Goertzel = prod1 - prod2
            N = 0
            mostra_1[i] = 0
            mostra_2[i] = 0
            if (i<4):
	        val_g_L[i] = Goertzel
            else:
	        val_g_H[i-4] = Goertzel

            temp1 = 0
            temp2 = 0
            to1 = 0
            to2 = 0
    
            for i in range(4):
                if(val_g_L[i] > temp1):
	            temp1 = val_g_L[i]
	            to1 = i
                if(val_g_H[i] > temp2):
	            temp2 = val_g_H[i]
	            to2 = i

            if (estat == 0):
                #print temp1
                #print temp2
                if (temp1 > llindar and temp2 > llindar):
                    x=descodifica(freq_L[to1],freq_H[to2])
	            print x,
                    print
	            estat = 1
                else:
	            estat = 0
            elif (estat == 1):
                if (temp1 > llindar and temp2 > llindar):
	            estat = 1
                else:
	            estat = 0


def descodifica(freq1,freq2):
    
    if (freq1==697 and freq2==1209):
        return '1'
    elif(freq1==697 and freq2==1336):
        return '2'
    elif (freq1==697 and freq2==1477):
        return '3'
    elif (freq1==697 and freq2==1633):
        return 'A'
    elif(freq1==770 and freq2==1209):
        return '4'
    elif(freq1==770 and freq2==1336):
        return '5'
    elif (freq1==770 and freq2==1477):
        return '6'
    elif(freq1==770 and freq2==1633):
        return 'B'
    elif(freq1==852 and freq2==1209):
        return '7'
    elif(freq1==852 and freq2==1336):
        return '8'
    elif(freq1==852 and freq2==1477):
        return '9'
    elif(freq1==852 and freq2==1633):
        return 'C'
    elif(freq1==941 and freq2==1209):
        return '*'
    elif(freq1==941 and freq2==1336):
        return '0'
    elif(freq1==941 and freq2==1477):
        return '#'
    elif(freq1==941 and freq2==1633):
        return 'D'
    else:
        return 'N'




if __name__ =="__main__": 
    ser=serial.Serial('/dev/ttyACM0',115200)
    mostra = [0,0,0,0,0,0,0,0]
    mostra_1=[0,0,0,0,0,0,0,0]
    mostra_2=[0,0,0,0,0,0,0,0]
    #coef=[439,421,401,380,295,254,210,149]
    coef = [1.70774, 1.64528, 1.56869, 1.47820, 1.16410, 0.99637, 0.79862, 0.56853]
    N=0
    freq_L=[697,770,852,941]
    freq_H=[1209,1336,1477,1633]

    val_g_L=[0,0,0,0]
    val_g_H=[0,0,0,0]
    estat=0
    llindar=850000
    t1 = time.time()
    while True:
        print t1 - time.time()
        t1 = time.time()
        
        entrada=ser.read(197)
        
#        print entrada
        #t0 = time.time()
        for i in entrada:
            #print ord(i)
            goertzel(ord(i))
    ser.close()
    
