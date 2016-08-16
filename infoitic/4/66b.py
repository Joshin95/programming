n=input("posa el numero d'n: ")
m=input("posa el numero d'm: ")

def factorial(k):
    x=1
    i=1
    while i<=k:
        x=i*x
        i+=1
    return x

r=factorial(m)/(factorial(factorial(n)*(m-n))

print r
