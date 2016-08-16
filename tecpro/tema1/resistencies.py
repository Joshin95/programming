class codif(object):
    def __init__(self,s1,s2,m1):
        self.s1=s1
        self.s2=s2
        self.m1=m1
    def value(self):
        x=int(str(self.s1)+str(self.s2))
        r=x*(10**(int(self.m1)))
        return r
    def colors(self):
        l=[]
        l=["negre","marro","vermell","taronja","groc","verd","blau","lila","gris","blanc","or","plata"]
        return l[int(self.s1)],l[int(self.s2)],l[int(self.m1)]

#r=codif(1,2,5)
#print r.colors()
