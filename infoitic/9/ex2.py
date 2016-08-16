def compta(s):
    k=0
    for c in s:
        if c=="de":
            k+=1
    return k


i=0
f=open("dades.txt")
for linia in f:
    print "En la linia", i
    z=linia.split()
    r=compta(z)
    print r, "paraules trobades"
    i+=1
f.close()


