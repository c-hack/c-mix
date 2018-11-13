////////////////////////////////////////////////////////////
//      c-trone       CC-BY SA NC 2018   c-hack.de
//
//  This is the controller software which runs on the
//  Arduino-compatible c-trone board of c-hack.
//
//  TODO: Number of turns to be read from Serial
////////////////////////////////////////////////////////////

int count;           // The actual number of measured turns
int oldRelayState;
int turns = 5;       // The number of turns received from Raspi (default is 5) 
String serialBuffer = "";   // This buffer holds the Serial Commands

void setup() {
  Serial.begin(9600);

  for (int i=2; i<10; i++) {
    pinMode(i, OUTPUT);    // Set all Motordrivers as Output
  }
  allMotorsOff();
  count = 0;
    
  pinMode(A0, INPUT);    // The counter input
  oldRelayState = digitalRead(A0);
     
  Serial.println("==== c-trone ready ======");
}

void loop() {
  char c=' ';
  char m;    // Motor Index
  int motor;  
  String motorTurns;
  
  if (Serial.available()) {
    c = Serial.read();
    serialBuffer += c;
  }

  if (c == '\n') {
    //Serial.println(serialBuffer);
    motorTurns = serialBuffer.substring(2);
    turns = motorTurns.toInt();
    m = serialBuffer.charAt(0);

    motor = m - '0' + 1;   // +1 because the first motor starts with 2
    Serial.print("Motortreiber: ");
    Serial.println(motor);
    Serial.print("Umdrehungen: ");
    Serial.println(turns);

    if ((motor > 1) && (motor < 10)) digitalWrite(motor,HIGH);
    if (motor < 2) allMotorsOff();  

    serialBuffer="";
  }

  if ((oldRelayState == 1) && (digitalRead(A0) == 0)) {
    count++;
    Serial.println(count);
    if (count >= turns) {
       allMotorsOff();
       count = 0;
       Serial.print('*');
    }
    delay(400);
  }
  oldRelayState = digitalRead(A0);
}


void allMotorsOff() {
  for (int i=2; i<10; i++) digitalWrite(i,LOW);
}
