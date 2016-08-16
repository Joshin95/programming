import matplotlib.pyplot as plt
import matplotlib.patches as mpatches
import struct
import string
import sys
import csv
import numpy
from bitstring import Bits

#import pdb; pdb.set_trace()

nom_f = sys.argv[1]

#data = list(csv.reader(open(nom_f, "rb"), delimiter=';'))
#print data

def c2(v):
    return v-2**16 if v>>15 else v

def e2(v):
    return v-2**8 if v>>7 else v

def arregla(data):
    data = data.replace('\n','')
    data = data.replace(';','')

    return data


f = open(nom_f, "rb")




count = 1
data_x = []
data_y = []
data_z = []

data1 = f.read(1) #llegeix bytes del X, no bits
while data1 !="":
    
    data2 = f.read(1)
    if count == 1:
        
        dataX16 = ord(data1)
        dataX16 = dataX16 + (ord(data2) << 8)
        print c2(dataX16)
        data_x.append(c2(dataX16))
        count = 2

    elif count == 2:
        
        dataY16 = ord(data1)
        dataY16 = dataY16 + (ord(data2) << 8)
        print c2(dataY16)
        data_y.append(c2(dataY16))
        count = 3
        
    elif count == 3:
        dataZ16 = ord(data1)
        dataZ16 = dataZ16 + (ord(data2) << 8)
        print c2(dataZ16)
        data_z.append(c2(dataZ16))
        count = 1

    data1 = f.read(1)
    
print data_x
print data_y
print data_z

data_t = numpy.linspace(0, len(data_x)/50, len(data_x))

y, axarr = plt.subplots(3, sharex=True)
axarr[0].plot(data_t, data_x, linestyle='-')
axarr[0].set_title('X AXIS',)
axarr[1].plot(data_t, data_y, linestyle='-')
axarr[1].set_title('Y AXIS')
axarr[2].plot(data_t, data_z, linestyle='-')
axarr[2].set_title('Z AXIS')

plt.xlabel("time")
plt.show()



"""red_patch = mpatches.Patch(color='red', label='X AXIS')
blue_patch = mpatches.Patch(color='blue', label='Y AXIS')
green_patch = mpatches.Patch(color='green', label='Z AXIS')
plt.legend(handles=[red_patch,blue_patch,green_patch])
"""

#axarr[0].set_ylim([-2000,2000])

#axarr[1].set_ylim([-2000,2000])

#axarr[2].set_ylim([-2000,2000])

#plt.plot(data_t,data_x,'r',data_t,data_y,'b',data_t,data_z,'g')



"""
plt.plot(data_t,data_y)
plt.ylabel("data_y")
plt.xlabel("time")
plt.show()

plt.plot(data_t,data_z)
plt.ylabel("data_z")
plt.xlabel("time")
plt.show()
"""
