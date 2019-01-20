//===============================================================
// c-mix   CC-BY SA NC c-hack 1/2019
//
// Controlling a RGB LED Strip via simulating the IR-Sender
//
//===============================================================

#define SENDPIN 7

#define BLUE  0b00000000111101110110000011011111
#define RED   0b00000000111101110010000011011111
#define GREEN 0b00000000111101111010000001011111


void setup() {
   pinMode(SENDPIN, OUTPUT);
   digitalWrite(SENDPIN, HIGH);  
}

void loop() {
  send32Binary(BLUE);
  delay(1000);
  send32Binary(RED);
  delay(1000);
  send32Binary(GREEN);
  delay(1000); 
}

void send32Binary(uint32_t value) {
  sendPreambel();
  for (int i=0; i<32; i++) {
    sendBit(value & 0x80000000);
    value = value << 1;
  }
}

void sendPreambel() {
  digitalWrite(SENDPIN,LOW);
  delay(9);
  digitalWrite(SENDPIN,HIGH);
  delayMicroseconds(4000);
  sendBit(0);
}


void sendBit(uint32_t bitValue) {
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
