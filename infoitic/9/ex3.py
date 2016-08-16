f=open("notes.txt")
a=0
s=0
for c in f:
    z=c.split()
    if int(z[1])>=5:
        a+=1
    else:
        s+=1
f.close("notes.txt")

print "Han aprovat", a, "alumnes i han suspes", s, "alumnes"
        
