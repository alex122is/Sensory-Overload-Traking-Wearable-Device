/*
Poocessing code, Utilizes controlP5 library to add GUI elements and visual effects the app

*/

import controlP5.*;
int uX,uY;
ControlP5 Cp5;
String url1, url2;
import processing.serial.*;
Serial mySerial;
String myString = null;
int nl =10;   // ASCII COde for carage retunr in serial
float myVal;  // float for storing converted ascii serail data
String tempPatient,soundPatient, lightPatient;

void setup(){
  String  myPort = Serial.list() [0];
  mySerial = new Serial(this, myPort, 9600);
  size(600,900);
  uX = width /18;
  uY = height/32;
  background(color(150,150,150));
  Cp5 = new ControlP5(this);  // different objects
  
  Cp5.getTab("default")
    .setWidth(9*uX)
    .setHeight(2*uX)
    .activateEvent(true)
    .setLabel("Info")
    .setId(1) //<>//
    .getCaptionLabel()
    .setFont(createFont("",30));
    
    Cp5.addTab("Tab2")
    .setWidth(9*uX)
    .setHeight(2*uY)
    .activateEvent(true)
    .setLabel("User")
    .setId(2)
    .getCaptionLabel()
    .setFont(createFont("",30));
    
    Cp5.addButton("Button1")
    .setPosition(5*uX,5*uY)
    .setSize(6*uX,4*uY)
    .getCaptionLabel()
    .align(CENTER,CENTER)
    .setFont(createFont("",30))
    .toUpperCase(false)
    .setText("Patient")
    .setColor(color(255,0,0));
                        
    Cp5.addTextlabel("Etiqueta").setText("Temp")
                                .setPosition(2*uX, 9*uY)
                                .setFont(createFont("Georgia",35))
                                .setColorValue(color(0,128,128));
    Cp5.addTextlabel("Etiqueta2").setText("Sound")
                                .setPosition(2*uX, 13*uY)
                                .setFont(createFont("Georgia",35))
                                .setColorValue(color(0,128,128));
     Cp5.addTextlabel("Etiqueta3").setText("Light")
                                .setPosition(2*uX, 17*uY)
                                .setFont(createFont("Georgia",35))
                                .setColorValue(color(0,128,128));
   Cp5.addTextfield("Cel").setText("1")
                                .setPosition(10*uX, 9*uY)
                                .setFont(createFont("Georgia",35))
                                .setColorValue(color(0,128,128)).setSize(120, 40).setAutoClear(false);
    Cp5.addTextfield("dB").setText("2")
                                .setPosition(10*uX, 13*uY)
                                .setFont(createFont("Georgia",35))
                                .setColorValue(color(0,128,128)).setSize(120, 40).setAutoClear(false);
     Cp5.addTextfield("t3").setText("3")
                                .setPosition(10*uX, 17*uY)
                                .setFont(createFont("Georgia",35))
                                .setColorValue(color(0,128,128)).setSize(120, 40).setAutoClear(false);
    Cp5.addTextfield("Warnings").setText("Normal")
                                .setPosition(4*uX, 27*uY)
                                .setFont(createFont("Georgia",35))
                                .setColorValue(color(0,128,128)).setSize(300, 40).setAutoClear(false);
   Cp5.addTextlabel("T").setText("T")
                                .setPosition(3*uX, 20*uY)
                                .setFont(createFont("Georgia",35))
                                .setColorValue(color(0,128,128));
    Cp5.addTextlabel("S").setText("S")
                                .setPosition(8*uX, 20*uY)
                                .setFont(createFont("Georgia",35))
                                .setColorValue(color(0,128,128));
     Cp5.addTextlabel("L").setText("L")
                                .setPosition(13*uX, 20*uY)
                                .setFont(createFont("Georgia",35))
                                .setColorValue(color(0,128,128));
                                
    Cp5.addKnob("knob1")
     .setPosition(250, 100)
     .setSize(50,50)
     .setPosition(3*uX, 23*uY)
     //.setColorValue(color(0,128,128));
          .setColorValue(color(255, 128, 0, 128));
     Cp5.addKnob("knob2")
     .setPosition(250, 100)
     .setSize(50,50)
     .setPosition(8*uX, 23*uY)
     //.setColorValue(color(0,128,128));
          .setColorValue(color(255, 128, 0, 128));
      Cp5.addKnob("knob3")
     .setPosition(250, 100)
     .setSize(50,50)
     .setPosition(13*uX, 23*uY)
     //.setColorValue(color(0,128,128));
          .setColorValue(color(255, 128, 0, 128));

     
    
   // Cp5.getController("Slider").moveTo("Tab2");
    Cp5.getController("Etiqueta").moveTo("Tab2");
    Cp5.getController("Etiqueta2").moveTo("Tab2");
    Cp5.getController("Etiqueta3").moveTo("Tab2");
    Cp5.getController("Cel").moveTo("Tab2");
    Cp5.getController("dB").moveTo("Tab2");
    Cp5.getController("t3").moveTo("Tab2");
    Cp5.getController("Warnings").moveTo("Tab2");
     Cp5.getController("T").moveTo("Tab2");
    Cp5.getController("S").moveTo("Tab2");
    Cp5.getController("L").moveTo("Tab2");
    Cp5.getController("knob1").moveTo("Tab2");
    Cp5.getController("knob2").moveTo("Tab2");
    Cp5.getController("knob3").moveTo("Tab2");


    
    Cp5.addTextfield("Name").setPosition(5*uX,10*uY).setSize(200, 40).setAutoClear(false);
  Cp5.addTextfield("Age").setPosition(5*uX,12*uY).setSize(200, 40).setAutoClear(false);
  Cp5.addTextfield("LightSen").setPosition(5*uX,15*uY).setSize(200, 40).setAutoClear(false);
  Cp5.addTextfield("TempSen").setPosition(5*uX,17*uY).setSize(200, 40).setAutoClear(false);
    Cp5.addTextfield("SoundSen").setPosition(5*uX,19*uY).setSize(200, 40).setAutoClear(false);
  Cp5.addBang("Submit").setPosition(5*uX,21*uY).setSize(80, 40);   

}

void draw(){
   while(mySerial.available()>0){
    myString = mySerial.readStringUntil(nl);//Strip data of serial port
    //delay(200);
   // print("printing to console", myString);
    if(myString == null){
      ;
    }
    else if(myString.charAt(0) == 'T'){   // 68is normal...
       tempPatient = Cp5.get(Textfield.class,"TempSen").getText();
       int finalTemp = int(tempPatient);
       Cp5.get(Textfield.class,"Cel").clear();
       myString = myString.replace("T","");
       int tempInt = int(myString);
       //print("printing user temp");
       //print(tempInt);
       if(tempInt >=finalTemp-6 && tempInt <finalTemp+6){
         Cp5.get(Textfield.class,"Cel").setColorBackground(0xff00ff00);        //Green
         Cp5.get(Textfield.class, "Warnings").setText("Normal");        //Yellow
       }
       else if((tempInt>=finalTemp-10 && tempInt<finalTemp-6) ||( tempInt >finalTemp+6 && tempInt<finalTemp+10)){
         Cp5.get(Textfield.class,"Cel").setColorBackground(0xffffff00);         //Yellow
       }
       else if(tempInt < finalTemp-12 || tempInt >finalTemp+12){
         Cp5.get(Textfield.class,"Cel").setColorBackground(0xFFFF0000);        //red
          Cp5.get(Textfield.class, "Warnings").setText("Its too hot move out!!");        //Yellow
         // delay(500);
       }
       Cp5.get(Textfield.class,"Cel").setText(myString);
       float xrots = float(trim(myString));
       Cp5.get(Knob.class,"knob1").setValue(xrots);
    }
    
    
    else if(myString.charAt(0) == 'S'){ //over 35 loud over 15 medium less than 12 we good
       soundPatient = Cp5.get(Textfield.class,"SoundSen").getText();
       int finalSound = int(soundPatient);
       Cp5.get(Textfield.class,"dB").clear();
       myString = myString.replace("S","");

       if(myString.charAt(0) == '0'){
         myString = myString.substring(1);
       }
       float  sounsInt = float(myString);
 
       if(sounsInt <= finalSound +4){
         Cp5.get(Textfield.class,"dB").setColorBackground(0xff00ff00);        //Green
         Cp5.get(Textfield.class, "Warnings").setText("Normal");        //Yellow

       }
       
       else if(sounsInt > finalSound +4 && sounsInt<finalSound +10){
         Cp5.get(Textfield.class,"dB").setColorBackground(0xffffff00);        
       }
       
       
       else if(sounsInt > finalSound +11){
         Cp5.get(Textfield.class,"dB").setColorBackground(0xFFFF0000);        //red
                  Cp5.get(Textfield.class, "Warnings").setText("To much Sound move!!");        
         //delay(500);

       }
       
       Cp5.get(Textfield.class,"dB").setText(myString);
       float xrots = float(trim(myString));
       Cp5.get(Knob.class,"knob2").setValue(xrots);
    }
   else if(myString.charAt(0) == 'L'){ // we reversed darkers higher values.. over a thousand is dark as shit,  250 is medium //  less than 150 fully lit
       lightPatient = Cp5.get(Textfield.class,"LightSen").getText();
       int finalLight = int(lightPatient);
       Cp5.get(Textfield.class,"t3").clear();
       myString = myString.replace("L","");
       
       float  lightInt = float(myString);
       float intfinallight= float(finalLight);
       float testLight = lightInt - intfinallight;
          println(lightInt);
          println(intfinallight -10);


       if(lightInt >= intfinallight){
         Cp5.get(Textfield.class,"t3").setColorBackground(0xff00ff00);        //Green
         Cp5.get(Textfield.class, "Warnings").setText("Normal");        

       }
       
       else if(lightInt < intfinallight-10.0 && lightInt > intfinallight-25.0){
         Cp5.get(Textfield.class,"t3").setColorBackground(0xffffff00);        //Yellow

       }
       
       
       else if(lightInt < intfinallight-25.0){
         Cp5.get(Textfield.class,"t3").setColorBackground(0xFFFF0000);        //red
         Cp5.get(Textfield.class, "Warnings").setText("TOO much light move out");        //Yellow
        // delay(500);
       }
       
       
       
       Cp5.get(Textfield.class,"t3").setText(myString);
       float xrots = float(trim(myString));
       Cp5.get(Knob.class,"knob3").setValue(xrots);
      }
    }
        //delay(200);

}
void Submit() {
  print("the following text was submitted :");
  url1 = Cp5.get(Textfield.class,"Name").getText();
  url2 = Cp5.get(Textfield.class,"Age").getText();
  print(" name = " + url1);
  print(" Age = " + url2);
  println();
  Cp5.addTextlabel("newName").setText("Patient " +url1)
                                .setPosition(6*uX, 3*uY)
                                .setFont(createFont("Georgia",35))
                                .setColorValue(color(0,128,128));
      Cp5.getController("newName").moveTo("Tab2");
      Cp5.addTextlabel("newAge").setText("Age " +url2)
                                .setPosition(7*uX, 5*uY)
                                .setFont(createFont("Georgia",35))
                                .setColorValue(color(0,128,128));
      Cp5.getController("newAge").moveTo("Tab2");

}
void controlEvent(ControlEvent Evento){
  if(Evento.isTab())
  {
    if(Evento.getTab().getId() == 1)
      background(color(150,150,150));
      
    if(Evento.getTab().getId() == 2)
      background(color(240,240,240));
    }
  }
  
    
