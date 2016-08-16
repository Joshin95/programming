from interpret import *
import serial

def FA():
  
    ser.write("FA\r\n")
    text=ser.readline()
    if text=="OK\r\n":
        print "Street A to clear"
    else:
        print "Error"
  
def FB():
    
    ser.write("FB\r\n")
    text=ser.readline()
    if text=="OK\r\n":
        print "Street B to clear"
    else:
        print "Error"

def A():
  
    ser.write("?A\r\n")
    text=ser.readline()
    if text=="OFF\r\n":
        print "Semaphore A state OFF"
    elif text=="CLEAR\r\n":
        print "Semaphore A state CLEAR"
    elif text=="APPROACH\r\n":
        print "Semaphore A state APPROACH"
    elif text=="STOP\r\n":
        print "Semaphore A state STOP"
    else:
        print "Error"

def B():
    
    ser.write("?B\r\n")
    text=ser.readline()
    if text=="OFF\r\n":
        print "Semaphore B state OFF"
    elif text=="CLEAR\r\n":
        print "Semaphore B state CLEAR"
    elif text=="APPROACH\r\n":
        print "Semaphore B state APPROACH"
    elif text=="STOP\r\n":
        print "Semaphore B state STOP"
    else:
        print "Error"

def R():

    ser.write("R\r\n")
    text=ser.readline()
    if text=="OK\r\n":
        print "Semaphore initialized"
    else:
        print "Error"

def H():
   
    ser.write("H\r\n")
    text=ser.readline()
    if text=="OK\r\n":
        print "Shut down"
    else:
        print "Error"
  
def ajuda():
    """
    Funcio que printa totes les ordres conegudes per l'interpret
    """
    print "--------------------"
    print "Available functions:"
    print "--------------------"
    print ""
    print "<FA> - Puts the Street A semaphore clear"
    print ""
    print "<FB> - Puts the Street B semaphore clear"
    print ""
    print "<?A> - Prints the state of the street A semaphore"
    print ""
    print "<?B> - Prints the state of the street A semaphore"
    print ""
    print "<R> - Starts the crossing system"
    print ""
    print "<H> - Shuts down the system"
    print ""



if __name__=="__main__":
    
    ser=serial.Serial("/dev/ttyACM0")
    l=Interpret()
    l.set_prompt("&&")
    while(True):
        if ser.readline()=="START\r\n":
            print "Ready to recieve orders!"
            break
    l.afegeix_ordre("FA",FA)
    l.afegeix_ordre("HELP",ajuda)
    l.afegeix_ordre("FB",FB)
    l.afegeix_ordre("?A",A)
    l.afegeix_ordre("?B",B)
    l.afegeix_ordre("R",R)
    l.afegeix_ordre("H",H)
    l.run()		
    ser.close()
    
    
        
