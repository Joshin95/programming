def alumne(d):
    t=[]
    nom=raw_input("Escriu el nom del alumne: ")
    cognom=raw_input("Escriu els cognoms del alumne: ")
    t+=[nom+" "+cognom]
    d[(nom,cognom)]=t
    return d
    
def grup(d,e):
    s=[]
    grup=raw_input("Escriu el nom del grup: ")
    q="S"
    while q=="S":
        p=raw_input("nom: ")
        k=raw_input("cognom: ")
        if d.has_key(tuple([p,k])):
            s+=[p+" "+k]
            e[(grup)]=s
        else:
            print "el alumne no existeix"
        q=raw_input("Mes alumnes S/N?: ")
        q=q.upper()
    t=raw_input("Escriu el titol del projecte: ")
    e[grup]+=[t]
    return tuple([d,e])
def llistarGrup(e):
    for c in e.keys():
        print c
def nota(e):
    g=raw_input("Escriu el nom de grup que vols avaluar: ")
    n=raw_input("Posa la nota: ")
    e[g]+=[n]
    return e
def borrarAlumne(d,e):
    t=[]
    n=raw_input("Posa el nom d'alumne que vols donar de baixa: ")
    c=raw_input("Posa el cognom d'alumne que vols donar de baixa: ")
    cn=n+" "+c
    cn1="g s"
    cn2=[n,c]
    q=d.values()
    for c in q:
        if cn2==c:
            q-=cn1
    print q
def guardaralumnes(d):
    fd=raw_input("Escriu el nom de fitxer on vols guardar els alumnes: ")
    fid=open(fd+".txt","w")
    for k,v in d.items():
        fid.write(str(k)+"_")
        for e in v:
            fid.write(str(e)+"_")
        fid.write("\n")
    fid.close()
    print "El fitxer s'ha guardat correctament"
    
def guardargrup(e):
    fe=raw_input("Escriu el nom de fitxer on vols guardar els grups: ")
    fie=open(fe+".txt","w")
    for k,v in e.items():
        fie.write(str(k)+"_")
        for p in v:
            fie.write(str(p)+"_")
        fie.write("\n")
    fie.close()
    print "El fitxer s'ha guardat correctament"

def llegirDiscAlumnes():
    d={}
    f=raw_input("Escriu el nom del fitxer que conte les dades: ")
    w=open(f+".txt","r")
    for c in w:
        m=c.split("_")
        d[m[0]]=[]
        for j in m[1:-1]:
            d[m[0]]+=[j]
    print d
def llegirDiscgrups():
    e={}
    f=raw_input("Escriu el nom del fitxer que conte les dades: ")
    w=open(f+".txt","r")
    for c in w:
        m=c.split("_")
        e[m[0]]=[]
        for j in m[1:-1]:
            e[m[0]]+=[j]
    print e
        
    
    
def menu():
    print "Menu"
    print "1.Afegir alumne"
    print "2.Afegir grup"
    print "3.Llistar tots els grups"
    print "4.Avaluar projectes"
    print "5.Borrar alumne"
    print "6.Guardar dades"
    print "7.Obtenir dades d'un fitxer"
d={}
e={}
menu()
x=input("tria opcio: ")
while x!=0:
    if x==1:
        print alumne(d)
    elif x==2:
        grup(d,e)
    elif x==3:
        llistarGrup(e)
    elif x==4:
        print nota(e)
    elif x==5:
        borrarAlumne(d,e)
    elif x==6:
        guardaralumnes(d)
        guardargrup(e)
    elif x==7:
        llegirDiscAlumnes()
        llegirDiscgrups()
  
       
        
    menu()
    x=input("tria opcio: ")
print "fi programa"

