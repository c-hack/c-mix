//==============================================================
//  Library to simulate the remote control of RGB LED strips etc
//
//  CC3.0 by-sa-nc   2019    surasto.de
//==============================================================

#include "Arduino.h"
#include "RGBremote.h"

RGBremote::RGBremote(int pinNumber) {    // Constructor
  SENDPIN = pinNumber;
  pinMode(SENDPIN,OUTPUT);
  digitalWrite(SENDPIN,HIGH);
}

void RGBremote::sendCode(uint8_t code){
  uint32_t low, high;
  uint32_t command;

  low = code & 0x0F;
  code = code >> 4;
  high = code & 0xF;
    
  command = TEMPLATE + (high << 12) + (low << 4);   
  send32Binary(command);
}


void RGBremote::send32Binary(uint32_t value) {
  sendPreamble();
  for (int i=0; i<32; i++) {
    sendBit(value & 0x80000000);
    value = value << 1;
  }
}

void RGBremote::sendPreamble() {
  digitalWrite(SENDPIN,LOW);
  delay(9);
  digitalWrite(SENDPIN,HIGH);
  delayMicroseconds(4000);
  sendBit(0);
}


void RGBremote::sendBit(uint32_t bitValue) {
  if (bitValue == 0) {
    delayMicroseconds(600);
    digitalWrite(SENDPIN,LOW);
    delayMicroseconds(600);
    digitalWrite(SENDPIN,HIGH);
  } else {
    delayMicroseconds(1600);
    digitalWrite(SENDPIN,LOW);
    delayMicroseconds(600);
    digitalWrite(SENDPIN,HIGH);
  }
}
