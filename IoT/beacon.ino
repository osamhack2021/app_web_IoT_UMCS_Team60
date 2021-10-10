#include <SoftwareSerial.h>  

// RX, TX
SoftwareSerial BTSerial(3, 2); 

void setup() {  
    Serial.begin(9600);   
    BTSerial.begin(9600);  
}  

void loop() {  
    while (BTSerial.available()) {
        byte data = BTSerial.read();  
        Serial.write(data); 
    }  
  
    while (Serial.available()) {
        byte data = Serial.read();  
        BTSerial.write(data); 
    }  
}