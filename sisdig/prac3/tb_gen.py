import sys
l=sys.argv
a=l[1]
z=a.split(".")
o=str(z[0])+"_tb"
f=open(str(a))
r=open(str(o)+".vhd","w")
s=f.read()
senseespai=s.split(" ")
q=[]
llistaf=[]
for c in senseespai:
    if c!="":
        c=c.strip()
        llistaf+=c.split("\n")
        
unida=" ".join(llistaf)
iks=unida.split(" ")
for c in iks:
    if c!="":
        q+=c.split("\t")
ui=";"
for c in q:
   
    if ui in c:
        r.write(str(c))
        r.write("\n")
    elif c.upper()=="ENTITY":
        r.write("entity "+str(o)+" is"+"\n")
        break
    else:
        r.write(str(c)+" ")

r.write("end"+" "+str(o)+";"+"\n")
comp="my_"+str(z[0])


dh=[]
enable=False
for c in q:
    if c.upper()=="PORT(":
        enable=True
    elif c.upper()=="END":
        enable=False
    elif enable==True:
        dh+=[c]

print dh

arch=raw_input("Tria el nom de la vostra arquitectura: ")   
r.write("architecture "+str(arch)+" of "+str(o)+" is"+"\n"+"component"+" "+str(comp)+"\n")
oiu=0
coma=","
for c in dh:
    if coma in c:
        oiu=0
        break
else:
    oiu=1

r.write("port( ")
for c in range(len(dh)):
    r.write(str(dh[c])+" ")
r.write("\nend component;\n")
r.write("for dut: "+str(comp)+" use entity work."+str(z[0])+";"+"\n")

print "---------------------------------------------------"
print q
print "--------------------------------------------------"

    
count=0
for c in dh:
    if c==":":
        count+=1
jk=[]
dh=":".join(dh)
dh=dh.split(":")
for c in dh:
    if c!="" and c.upper()!="IN" and c.upper()!="OUT":
        jk+=[c]

print jk
upara=""
for ult in jk[-1]:
    if ult!=")":
        upara+=ult

if oiu==1:
    for c in range(count):
        if c!=count-1:
            r.write("signal "+str(jk[c*2])+":"+str(jk[(c*2)+1])+"\n")
        else:
            r.write("signal "+str(jk[c*2])+":"+str(upara)+"\n")
else:
    port=q.index("port(")
    dospunts=q.index(":")
    kop=q[port+1:dospunts]
    kap=q[dospunts+2]
    kup1=q[dospunts+3:]
    dospunts2=kup1.index(":")
    print "------------------------"
    print kap
    kup=kup1[:dospunts2]
    kup=",".join(kup)
    kup=kup.split(",")
    kup2=kup1[dospunts2+2:]
    ltpm2=[]
    std=""
    print "@@@@@@@@@@@@@@@@@@@@@@@@@@"
    print kup2
    print "@@@@@@@@@@@@@@@@@@@@@@@@@@2"
    for c in kup2[0]:
        if c!=")":
            std+=c
            
    for c in kup:
        if c!="":
            ltpm2+=[c]
    print ltpm2
    kop=",".join(kop)
    kop=kop.split(",")
    print kop
    ltpm=[]
    for c in kop:
        if c!="":
            ltpm+=[c]    
    
    for c in range(len(ltpm)):
        r.write("signal "+str(ltpm[c])+":"+str(kap)+"\n")
    for c in range(len(ltpm2)):
        r.write("signal "+str(ltpm2[c])+":"+str(std)+"\n")

   
r.write("\nbegin"+"\n"+"dut: "+"my_"+str(z[0])+" port map("+"\n")
if oiu==1:
    for c in range(count):
        if c!=count-1:
            r.write(str(jk[c*2])+"=>"+str(jk[c*2])+","+"\n")
        else:
            r.write(str(jk[c*2])+"=>"+str(jk[c*2])+");"+"\n")
else:
    for c in range(len(ltpm)):
        r.write(str(ltpm[c])+"=>"+str(ltpm[c])+",\n")
    for c in range(len(ltpm2)):
        if c!=count-1:
            r.write(str(ltpm2[c])+"=>"+str(ltpm2[c])+",\n")
        else:
            r.write(str(ltpm2[c])+"=>"+str(ltpm2[c])+");\n")


w=raw_input("Conte clock la simulacio? S/N: ")
if w.upper()=="S":
    nom=raw_input("Posa el nom del teu clock: ")
    freq=input("Posa el periode del clock en ns: ")
    repe=input("Posa el numero de cicles: ")
    r.write(nom+"_proces:process"+"\nbegin\n"+nom+"<='0';\nwait for "+str(freq/2.)+" ns"+";"+"\n"+"for i in 1 to "+str(repe*2)+" loop:"+"\n"+str(nom)+"<=not "+str(nom)+";\n"+"wait for "+str(freq/2.)+" ns"+";"+"\nend loop;\nwait;\nend process "+str(nom)+"_process;\nend behaviour;")

else:
    r.write("end behaviour;")

r.close()
