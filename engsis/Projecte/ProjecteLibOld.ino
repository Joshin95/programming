#include <SPI.h>             //lo dels bytes: ara esta fet amb 16b, sha de fer amb 8b, posar EOF i modificar plot.
#include <SD.h>
#include <ADXL362.h>
#include <PinChangeInt.h>
#include <TimerOne.h>

#define PIN 8

File myFile;
ADXL362 xl;
SPISettings A(128000,MSBFIRST,SPI_MODE1);
int16_t temp;
int8_t XValue, X2Value, YValue, Y2Value, ZValue, Z2Value;


void fileclose() {




                    
  Serial.print("Sacabo\n");
  myFile.close(); 
  Timer1.detachInterrupt();
}



void setup() {

  pinMode(7,OUTPUT);
  pinMode(10,OUTPUT);
  pinMode(4,OUTPUT);
  pinMode(5,OUTPUT); // Veure quan tarda interrupcio
  pinMode(PIN, INPUT); 
  
  digitalWrite(PIN, HIGH);   
  
  Serial.begin(9600);
  xl.begin(10);                   // Setup SPI protocol, issue device soft reset
  xl.beginMeasure();              // Switch ADXL362 to measure mode  
  digitalWrite(5,LOW); 
  digitalWrite(4,LOW);
  digitalWrite(10,HIGH);
  // Open serial communications and wait for port to open:
 
  while (!Serial) {
    ; // wait for serial port to connect. Needed for native USB port only
  }


  Serial.print("Initializing SD card...");

  if (!SD.begin(4)) {
    Serial.println("initialization failed!");
    return;
  }
  Serial.println("initialization done.");

  // open the file. note that only one file can be open at a time,
  // so you have to close this one before opening another.
  myFile = SD.open("test.txt", FILE_WRITE);
  digitalWrite(4,HIGH);

  PCintPort::attachInterrupt(PIN, &fileclose, FALLING);
  Timer1.initialize(20000);
  Timer1.attachInterrupt(process);
}

/*
void prova(){
  digitalWrite(7, HIGH);
  Serial.println("funciona?");
  digitalWrite(7, LOW);
}
*/

void process(){
  digitalWrite(5,HIGH);
  
  digitalWrite(10,LOW);
  recollida(XValue, X2Value, YValue, Y2Value, ZValue, Z2Value);  

  /*Serial.print(XValue + (X2Value << 8));
  Serial.print(";");
  Serial.print(YValue + (Y2Value << 8));
  Serial.print(";");
  Serial.print(ZValue + (Z2Value << 8));
  Serial.print("\n");
  */
  digitalWrite(10,HIGH);
  digitalWrite(4,LOW);
   // if the file opened okay, write to it:
  if (myFile) {
    //noInterrupts();
    myFile.write(XValue);
    myFile.write(X2Value);
    //myFile.print(";");
    myFile.write(YValue);
    myFile.write(Y2Value);
    //myFile.print(";");
    myFile.write(ZValue);
    myFile.write(Z2Value);
    //myFile.print("\n");
    //interrupts();
    Serial.println("done.");
  }
  else {
    // if the file didn't open, print an error:
    Serial.println("error opening test.txt");
  }  
  
  digitalWrite(4,HIGH);
  digitalWrite(5,LOW);
  //delay(5);    

}


void recollida(int8_t &XData,int8_t &X2Data, int8_t &YData, int8_t &Y2Data, int8_t &ZData, int8_t &Z2Data) {
  digitalWrite(10, LOW);
  SPI.transfer(0x0B);  // read instruction
  SPI.transfer(0x0E);  // Start at XData Reg
  XData = SPI.transfer(0x00);
  X2Data = SPI.transfer(0x00);
  YData = SPI.transfer(0x00);
  Y2Data = SPI.transfer(0x00);
  ZData = SPI.transfer(0x00); 
  Z2Data = SPI.transfer(0x00);
  digitalWrite(10, HIGH);
  
}

void loop() {
  // put your main code here, to run repeatedly:

}
