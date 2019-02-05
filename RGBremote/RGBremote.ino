#include "RGBremote.h"

RGBremote rgb(7);

void setup() {
}

void loop() {
  rgb.sendCode(ON);
  delay(1);
  rgb.sendCode(PINK);
  delay(1000);
  rgb.sendCode(RED);
  delay(1000);
  rgb.sendCode(OFF);
  delay(2000);
}
