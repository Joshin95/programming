i=4
x=0b101010
print x
v=1

c=1<<i
print c,c
if v==0:
    notc=~(c)
    x=x&notc
else:
    x=x|c
    print x
