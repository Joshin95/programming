def rgb_to_lum(pixel):
    """
    >>> rgb_to_lum((255,255,255))
    255
    >>> rgb_to_lum((255,0,0))
    85
    """
    s=0
    for element in pixel:
        s+=element
    return s/3

def luminance_img(i): 
    """
    >>> luminance_img(('RGB',[[(255,255,255),(255,255,255),(255,255,255)],[(255,255,255),(255,255,255),(255,255,255)],[(255,255,255),(255,255,255),(255,255,255)]]))
    ('L', [[255, 255, 255], [255, 255, 255], [255, 255, 255]])
    """
    img=i[1]
    l=[]
    f=[]
    for element in img:
        l=[]
        for cosa in element:
            t=rgb_to_lum(cosa)
            l+=[t]
        f+=[l]
    return ('L',f)

def histogram(i):
    """
    >>> histogram(('L',[[255, 255, 255],[255, 255, 255]]))
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6]
    """
    d={}
    img=i[1]
    for i in range(256):
        d[i]=0
    for element in img:
        for num in element:
            d[num]+=1
    return d.values()

def otsu(i,h):
     img=i[1]
     total=len(img)*len(img[0])
     sumB=0
     wB=0
     wF=0
     varMax=0.0
     threshold=0
     sum=0.0
     for t in range(256):
         sum+=t*h[t]
     for t in range(256):
         wB+=h[t]
         if wB==0:
             continue
         wF=total-wB
         if wF==0:
             break
         sumB+=t*h[t]
         mB=sumB/wB
         mF=(sum-sumB)/wF
         varBetween=wB*wF*((mB-mF)**2)
         if varBetween>varMax:
             varMax=varBetween
             threshold=t
     return threshold

#h=histogram(("L", [[255, 255, 255, 255],[255, 180, 182, 185],[185, 185, 100, 0], [0, 0, 0, 0],[0, 0, 180, 0], [255, 255, 185, 0],[180, 180, 180, 75],[0, 0, 0, 0],[255, 180, 180, 180]]))
#print h
#t=otsu(("L", [[255, 255, 255, 255],[255, 180, 182, 185],[185, 185, 100, 0], [0, 0, 0, 0],[0, 0, 180, 0], [255, 255, 185, 0],[180, 180, 180, 75],[0, 0, 0, 0],[255, 180, 180, 180]]),h)
#print t

def rgb_to_bn(i):
    w=luminance_img(i)
    h=histogram(w)
    otsuv=otsu(w,h)
    img=w[1]
    l=[]
    f=[]
    for element in img:
        l=[]
        for cosa in element:
            if cosa<=otsuv:
                l+=[0]
            else:
                l+=[255]
        f+=[l]
    return ("1",f)


