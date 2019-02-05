//==============================================================
//  Library to simulate the remote control of RGB LED strips etc
//
//  CC3.0 by-sa-nc   2019    surasto.de
//==============================================================

#include "Arduino.h"

#ifndef RGBremote_h
#define RGBremote_h 

#define BLUE       0x6D
#define RED        0x2D
#define GREEN      0xA5
#define YELLOW     0x30
#define PINK       0x70
#define TURQUOISE  0x90
#define ORANGE     0x11
#define WHITE      0xE0
#define ON         0xC3
#define OFF        0x4B

#define TEMPLATE 0b00000000111101110000000000001111

class RGBremote
{
  public:
    RGBremote(int pinNumber);
    void sendCode(uint8_t code);
  private:
    int SENDPIN;
    void send32Binary(uint32_t value);
    void sendPreamble();
    void sendBit(uint32_t bitValue); 
};

#endif
