import processing.serial.*;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.Collections;

import cc.arduino.*;
import org.firmata.*;
import processing.serial.*;

import ddf.minim.*;

Minim minim;
AudioPlayer c;
AudioPlayer d;
AudioPlayer e;
AudioPlayer f;
AudioPlayer g;
AudioPlayer a;
AudioPlayer b;
AudioPlayer C;
Arduino arduino;

int[] drawInputsForPractice(){
  int[] inputs = {1 ,0, 0, 0, 0, 0, 0, 0, 0};
  for (int i = 1; i < 9; i++){
    if (arduino.digitalRead(i+4) == Arduino.HIGH){
      inputs[i] = 1;
    }
    else {
      inputs[i] = 0;
    }
  }
  return inputs;
}

void setup(){
  minim = new Minim(this);
  // load all music files
  c = minim.loadFile("c4.mp3");
  d = minim.loadFile("d4.mp3");
  e = minim.loadFile("e4.mp3");
  f = minim.loadFile("f4.mp3");
  g = minim.loadFile("g4.mp3");
  a = minim.loadFile("a4.mp3");
  b = minim.loadFile("b4.mp3");
  C = minim.loadFile("c5.mp3");
  
  // Firmata stuff
  arduino = new Arduino(this, Arduino.list()[1], 57600);
  
  for (int i = 5; i < 13; i++){
    arduino.pinMode(i, Arduino.OUTPUT);
  }
}

void draw(){
  int[] arduinoInputs = drawInputsForPractice();
  if (arduinoInputs[1] == 1)
    c.play();
  else if (arduinoInputs[1] == 0){
    c.pause();
    c.rewind();
  }
  if (arduinoInputs[2] == 1)
    d.play();
  else if (arduinoInputs[2] == 0){
    d.pause();
    d.rewind();
  }
  if (arduinoInputs[3] == 1)
    e.play();
  else if (arduinoInputs[3] == 0){
    e.pause();
    e.rewind();
  }
  if (arduinoInputs[4] == 1)
    f.play();
  else if (arduinoInputs[4] == 0){
    f.pause();
    f.rewind();
  }
  if (arduinoInputs[5] == 1)
    g.play();
  else if (arduinoInputs[5] == 0){
    g.pause();
    g.rewind();
  }
  if (arduinoInputs[6] == 1)
    a.play();
  else if (arduinoInputs[6] == 0){
    a.pause();
    a.rewind();
  }
  if (arduinoInputs[7] == 1)
    b.play();
  else if (arduinoInputs[7] == 0){
    b.pause();
    b.rewind();
  }
  if (arduinoInputs[8] == 1)
    C.play();
  else if (arduinoInputs[8] == 0){
    C.pause();
    C.rewind();
  }
  
}