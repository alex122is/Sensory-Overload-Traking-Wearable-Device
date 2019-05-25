/*
This arduino is attached to our sensors and will send it out to other arduino in one string
*/

#include <SPI.h>
#include <nRF24L01.h>
#include <RF24.h>
RF24 radio(7, 8); // CE, CSN
#include <math.h>       //loads the more advanced math functions
//const int pResistor = A1; // Photoresistor at Arduino analog pin A0
//int sensorPin = A2; // select the input pin for the potentiometer
/*  RL=500/lux
 *  V0=5*(RL/(RL+R))
 *  V0=LDR_value*ADC_value
 *  lux=(250/V0)-50*/
float lux=0.00,ADC_value=0.0048828125,photoVal;


const byte address[6] = "00001";
void setup() {
  Serial.begin(9600);
  radio.begin();
  radio.openWritingPipe(address);
  radio.setPALevel(RF24_PA_MIN);
  radio.stopListening();
}

double Thermister(int RawADC) {  //Function to perform the fancy math of the Steinhart-Hart equation
 double Temp;
 Temp = log(((10240000/RawADC) - 10000));
 Temp = 1 / (0.001129148 + (0.000234125 + (0.0000000876741 * Temp * Temp ))* Temp );
 Temp = Temp - 273.15;            // Convert Kelvin to Celsius
 Temp = (Temp * 9.0)/ 5.0 + 32.0; // Celsius to Fahrenheit - comment out this line if you need Celsius
 return Temp;
}

void loop() {
  delay(5);
  radio.stopListening();
  int tempVal=analogRead(A0);
  double temp = Thermister(tempVal);
  String temp2 = String(temp);
  int photoVal = analogRead(A1);
  float lux=(250/(ADC_value*photoVal))-50;
  String lux2 = String(lux);
  int NoiseVal = analogRead(A2);
  int dB = (NoiseVal +83.2073) / 11.003; //Convert ADC value to dB using Regression values
  String db2 = String(dB);
  String tempp = temp2 + "," + lux2 + "," + db2;  
  Serial.println(tempp);   //send it as one big string 
  char text[36];
  for(int i =0; i < 36;i++){
  char ch  = tempp.charAt(i);
  text[i] = ch;
  }
  radio.write(&text, sizeof(text));
  delay(1000);
  radio.startListening();
}
