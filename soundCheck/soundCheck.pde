import processing.sound.*;

TriOsc Osc;
Env env;

float attackTime = 0.001;
float sustainTime = 0.04;
float sustainLevel = 0.8;
float releaseTime = 0.5;

void setup() {
  size(640, 360);
  background(255);
  
  // Create triangle wave
  Osc = new TriOsc(this);

  // Create the envelope 
  env  = new Env(this); 
 
  playFanfare();
}      

void draw() {
}

void playNote(String n, float fraction) {
  float f=50;
  int d;
 
  
  sustainTime=0.4/fraction;
  println (releaseTime);
  
  
  switch (n) {
    case "g": f=195.998; break;
    case "a": f=220.000; break;
    case "h": f=246.942; break;
    case "c1": f=261.626; break;
    case "d1": f=293.665; break;
    case "e1": f=329.628; break;
    case "f1": f=349.228; break;
    case "g1": f=391.995; break;
    case "a1": f=440; break;
    case "h1": f=493.883; break;
    case "c2": f=523.251; break;
    case "d2": f=587.330; break;
    case "e2": f=659.255; break;
  }
  Osc.freq(f);
  Osc.play();
  env.play(Osc, attackTime, sustainTime, sustainLevel, releaseTime);
  d = int((attackTime + sustainTime + releaseTime) * 1000); 
  delay(d);
}

void playFanfare() {
  playNote("c1",4);
  playNote("d1",4);
  playNote("e1",4);
  playNote("f1",4);
  playNote("g1",1);
  playNote("g1",1);
  playNote("a1",4);
  playNote("a1",4);
  playNote("a1",4);
  playNote("a1",4);
  playNote("g1",1);
  playNote("a1",4);
  playNote("a1",4);
  playNote("a1",4);
  playNote("g1",1);
  
}
