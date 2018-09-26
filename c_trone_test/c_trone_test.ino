////////////////////////////////////////////////////////////
//   This is a smal sketch to try out the motor controller
//   and the counter
////////////////////////////////////////////////////////////


int lastState=LOW;
int count = 0;

void setup() {
  Serial.begin(9600);

  pinMode(2, OUTPUT);    // One Motordriver for Test
  pinMode(A0, INPUT);    // The counter input
  
  digitalWrite(2,LOW); 
    
  Serial.println("==== c-trone ready ======");
}

void loop() {
  char c;
  int relay;
  
  // put your main code here, to run repeatedly:
  if (Serial.available()) {
    c = Serial.read();
    
    if (c == '0') {
      digitalWrite(2,LOW);   // Manual off
      count = 0;
    }
    if (c == '1') digitalWrite(2,HIGH);  // Manual on
  }

  relay = digitalRead(A0);
  if ((relay == HIGH) && (lastState == LOW)) {
    Serial.println(count);
    count++;
    delay(250);
  }
  lastState = relay;
}
