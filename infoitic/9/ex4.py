def linies(w):
    f=open("paraules.txt","w")
    z=w.split()
    for c in z:
        f.write(c)
        f.write("\n")
    f.close()  

x=raw_input("Posa les paraules: ")
linies(x)
