
k=input("posa el numero: ")

def factorial(k):
    multi=1
    i=1
    while i<=k:
        multi=i*multi
        i+=1
    print  "El factorial es igaul a" ,multi

factorial(k)
