# -*- encoding: utf-8 -*-

import img, Image

def read_rgb(nomf):
    """
    Donat un nom de fitxer corresponent a una imatge RGB la llegeix
    i torna la imatge corresponent
    """
    image = Image.open(nomf)
    pix = image.load()  
    X = image.size[0]
    Y = image.size[1]   
    data = [[pix[x,y] for x in range(X)] for y in range(Y)]    
    return img.img(data, "RGB")


def read_bn(nomf):
    """
    Donat un nom d'arxiu corresponent a una imatge en blanc i negre, 
    retorna la matriu d'imatge. Cada pixel serà 0 o 255. 
    """
    image = Image.open(nomf).convert('1')
    pix = image.load()
    X = image.size[0]
    Y = image.size[1]
    data = [[pix[x,y] for x in range(X)] for y in range(Y)]
    return img.img(data, "1")


def show(i):
    """
    Donada una imatge, la mostra en un visualitzador a la terminal. 
    Principalment serveix per a depurar el projecte.
    """
    image = Image.new(img.format(i),(img.get_w(i),img.get_h(i)))
    image.putdata([pixel for F in img.matrix(i) for pixel in F])
    image.show()


def save(i,nomf):
    """
    Donada una imatge i un nom de fitxer, crea el fitxer imatge a
    partir de la matriu.
    """
    image = Image.new(img.format(i),(img.get_w(i),img.get_h(i)))
    image.putdata([pixel for F in img.matrix(i) for pixel in F])
    image.save(nomf)
