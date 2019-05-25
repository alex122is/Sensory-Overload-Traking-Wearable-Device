/* 
  This arduino receives a string of data from our transceiver arduino. We parse the string and send it out
to out Processing IDE to be displayed in or app
*/
#include <SPI.h>
#include <nRF24L01.h>
#include <RF24.h>
RF24 radio(7, 8); // CE, CSN
const byte address[6] = "00001";

float temp;  //data to be sent
String Temp ="T";
float light;
String Light = "L";
float sound;
String Sound = "S";
void setup() {
  Serial.begin(9600);
  radio.begin();
  radio.openReadingPipe(0, address);
  radio.setPALevel(RF24_PA_MIN);
  radio.startListening();
}
void loop() {
  radio.startListening();
  if (radio.available()) {
  char text[32] = "";
  String aStringObject;
  delay(25);
  radio.read(&text, sizeof(text));
 int  i =1;
  //aStringObject= text;
  char * pch;
 // Serial.println(text);
  pch = strtok (text," ,-");
      String temp = pch;
      Temp.concat(temp);
      Serial.println(Temp); //now send the dats
      Temp ="T";
  //int i =1;
  while (pch != NULL)
  {

    if( i =1){
      pch = strtok (NULL, ",-");
      String light = pch;
      Light.concat(light);
      Serial.println(Light); //now send the dats
      Light ="L"; 
    }
    if( i =2){
      pch = strtok (NULL, ",-");
      String sound = pch;
      Sound.concat(sound);
      if(!Sound[1] == NULL){
      Serial.println(Sound); //now send the dats
      Sound ="S"; 
      }
    }
     if( i =3){
      pch = strtok (NULL, ",-");
      String End = pch;
      if(End == "999"){
      break;
      }
    }
   i++;
  }
  
  
  
  }
  delay(5);
  radio.stopListening();
}
