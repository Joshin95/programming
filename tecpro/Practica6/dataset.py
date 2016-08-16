from datetime import time

class DataSet(object):
    def __init__(self,name=""): 
        self._name=name
        self._ds=[]

    def __len__(self):
        return len(self._ds)

    def __str__(self):
        print self._name
        for element in self._ds:
            print (element[0].strftime("%H:%M:%S"),element[1])
        return ""
    def GetName(self):
        return self._name
    def add(self,t,v):
        if len(self._ds)==0:
            self._ds.append((t,v))
        elif self._ds[-1][0]<t:
            self._ds.append((t,v))
        else:
            raise OutOfOrderException()

    def time_vector(self):
        t=[]
        for element in self._ds:
            t+=[element[0].strftime("%H:%M:%S")]
        return t

    def value_vector(self):
        v=[]
        for element in self._ds:
            v+=[element[1]]
        return v

    def decimate(self,k=10):
        new=DataSet("Nou DataSet")
        old=self._ds
        while len(old)!=0:
            print "bucle"
            s=0
            for i in range(k):
                if len(old)==0:
                    break
                else:
                    s+=old[0][1]
                    t=old[0][0]
                    old=old[1:]
                    n=i+1
            suma=s/float(n)
            new.add(t,suma)
        return new

    def moving_average(self,k=50):
        d=DataSet("Nou DataSet")
        b=0
        i=0
        l=[]
        i2=0
        enb=False
        for c in range(k):
            l.append(self._ds[c][1])
            d.add(self._ds[c][0],self._ds[c][1])
            b=b+1
            enb=True
        for c1 in range(len(self._ds)):
            if c1+k<len(self._ds):
                print len(self._ds)
                while (i+(k-(k-1)))<=k and enb==False:
                    l.append(self._ds[i+c1+b-k][1])
                    print "@@@@@@@@@@@@"
                    print l
                    i=i+1
                print l
                print c1
                d.add(self._ds[c1+k][0],float(sum(l))/len(l))
                print d
                i=0
                l=[]
                enb=False
        return d
        
            
    def concat(self,ds2):
        if ds2._ds[0][0]>self._ds[0][0]:
            self._ds=self._ds+ds2._ds
        else:
            raise OutOfOrderException()

    def transform(self,a=1.0,b=0.0):
        dd=DataSet(str(self._name))
        for c in range(len(self._ds)):
            v=self._ds[c][1]
            dd.add(self._ds[c][0],a*v+b)
        return dd

class OutOfOrderException(Exception):
    pass

"""
if __name__=="__main__":
    t=time(23,01,54)
    w=time(22,02,43)
    p=time(23,02,55)
    q=time(23,03,03)
    r=time(23,04,03)
    s=time(23,05,33)
    u=time(23,10,22)
    d=DataSet("DataSet")
    d.add(w,2)
    d.add(t,3)
    d.add(p,2)
    d.add(q,3)
    d.add(r,2)
    d.add(s,3)
    d.add(u,2)
    #print d
    x=d.decimate(3)
    #print x
    d2=DataSet("DataSet2")
    p1=time(23,28,03)
    d2.add(p1,8)
    d.concat(d2)
    #print d.time_vector()
    #print d.value_vector()
    #plt.x=plt.xlabel("t")
    #plt.y=plt.ylabel("v")
    #plt.xticks(range(8),d.time_vector(),rotation=45)   
    #plt.plot([0,1,2,3,4,5,6,7],d.value_vector())
    #plt.plot([1,2,3,4],[4,3,5,6])
    #plt.show()
    new=d.moving_average(4)
    print "@@@@@@@@@@@@@@@@@@@@@@@@@@2"
    tr=d.transform(2,2)
    print d.time_vector()
    print d.value_vector()
"""
