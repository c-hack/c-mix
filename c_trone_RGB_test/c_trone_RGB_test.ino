//===============================================================
// c-mix   CC-BY SA NC c-hack 1/2019
//
// Controlling a RGB LED Strip via simulating the IR-Sender
//
//===============================================================

#define SENDPIN 7

#define BLUE     0b00000000111101110110000011011111
#define RED      0b00000000111101110010000011011111
#define GREEN    0b00000000111101111010000001011111
#define ON       0b00000000111101111100000000111111
#define OFF      0b00000000111101110100000010111111
#define TEMPLATE 0b00000000111101110000000000001111
//                  0x00     0xF7    0x?0     0x?F

#define BLAU   0x6D
#define ROT    0x2D
#define GRUEN  0xA5
#define GELB   0x30
#define LILA   0x70
#define TURKIS 0x90
#define ORANGE 0x11
#define WEISS  0xE0
#define EIN    0xC3
#define AUS    0x4B


//17 Orange
//32 rot
//48 gelb
//80 blau
//96 blau
//112 Lila
//115 Lila
//117 Lila
//128 Lila
//129 Dunkler
//144 Türkis
//160 Grün
//176 Weiß
//208 Lauflicht
//209 Lauflicht schnell
//224 weiß
//240 weif fader


int count;

void setup() {
   Serial.begin(9600);
   pinMode(SENDPIN, OUTPUT);
   digitalWrite(SENDPIN, HIGH);
   count = 0;  
}

void loop() {
  int c;
  sendCode(EIN);
  delay(1000);
  sendCode(WEISS);
/*  if (Serial.available()) {
     c=Serial.read();
     sendCode(count);
     Serial.println(count);
     if (count != 0x4B) sendCode(count);
     count++;
  } 
  send32Binary(BLUE);
  delay(1000);
  send32Binary(RED);
  delay(1000);
  send32Binary(GREEN); */
  delay(1000); 
  sendCode(AUS);
  delay(2000); 
}

void sendCode(byte code) {
  uint32_t low, high;
  uint32_t command;

  low = code & 0x0F;
  code = code >> 4;
  high = code & 0xF;
    
  command = TEMPLATE + (high << 12) + (low << 4);   
  send32Binary(command);
//  Serial.println(command,BIN);

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
