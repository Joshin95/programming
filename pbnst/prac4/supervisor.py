from interpret import *
import serial

def start():
    ser.write("R")
    d=ser.readline()
    print(d)

def help():
    """
    Funcio que printa totes les ordres conegudes per l'interpret
    """
    print "--------------------"
    print "Available functions:"
    print "--------------------"
    print ""
    print "<start> - Start the semaphore ordinary cicle"
    print ""
    print "<stop> - Shutdown the semaphore"
    print ""
    print "<emergency> - Puts the semaphore in green and continues the ordinary cicle"
    print ""
   
    

def stop():
    ser.write("S")
    d=ser.readline()
    print(d)

def emergency():
    ser.write("E")
    d=ser.readline()
    print(d)




if __name__=="__main__":
    
    ser=serial.Serial("/dev/ttyACM0")
    l=Interpret()
    l.set_prompt("&&")
    l.afegeix_ordre("start",start)
    l.afegeix_ordre("help",help)
    l.afegeix_ordre("emergency",emergency)
    l.afegeix_ordre("stop",stop)
    l.run()		
    ser.close()
    
    
        
