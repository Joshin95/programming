#1

def parell(x):
    if x%2==0:
        return True
    else:
        return False

#print parell(1)

#2

def suma(x):
    x=str(x)
    if x=="":
        return 0
    else:
        return int(x[0])+suma(x[1:])

#print suma(371) 

#3

def gira(x):
    s=""
    if x=="":
        return ""
    else:
        return (s+x[-1])+gira(x[:-1])

#print gira("info")

#4

def multiplica(x,y):
    if x==0 or y==0:
        return 0
    else:
        
        return x+multiplica(x,y-1) 

#print multiplica(5,9)

#5

def mostra(n):
    if n==0:
        return 0
    else:
        return str(n)+" "+str(mostra(n-1))+" "

#print mostra(6)

#6

def mostraR(n):
    if n==0:
        return 0
    else:
        return str(mostraR(n-1))+" "+str(n)

#print mostraR(6)

#7 

def primer(n):
    if n<2:
        return False
    else:
        for i in range(2,n):
            if n%i==0:
                return False
            else:
                return True

#print primer(6)
