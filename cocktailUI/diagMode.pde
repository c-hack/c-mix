class diagMode {
  
  int activePumpNr;
  
  diagMode() {
    activePumpNr = 0;
  }
  
  void updateDisplay() {
    int x=20;
    background(0);
    textSize(50);
    textAlign(CENTER);
    stroke(255);
    fill(255);
    text("C-Mix Diagnose",400,270);
   
    for (int i=1; i<9; i++) {
      fill(17,176,183);
      if (i == activePumpNr) fill(17,70,70);
      strokeWeight(3);
      stroke(255,255,255);
      rect(x, 60, 75,50,5);
      fill(0);
      if (i == activePumpNr) fill(255);
      textSize(40);
      text(9-i,x+37,100);
      x+=95;
      if (i==4) x+=20;
    }
    
    strokeWeight(3);
    stroke(255,255,255);
    fill(17,176,183);
    rect(20, 400,200,50,5);
    fill(0);
    text("Zurück",120,440);

    fill(17,176,183);
    rect(580, 400,200,50,5);
    fill(0);
    text("Reboot",680,440);
}
 
  int checkKnobPressed(int a, int b) {
    int pressed = 0;
    int x = 20;
    
    for (int i=1; i<9; i++) {
      if ((a < x+75) && (a > x) && (b>60) && (b<60+50)) {
        pressed = 9-i;
        activePumpNr = 9-i;
      }
      x+=95;
    }  
    
    if ((a < 20+200) && (a > 20) && (b>400) && (b<400+50)) pressed =9;
    if ((a < 580+200) && (a > 580) && (b>400) && (b<400+50)) pressed =10;
    
    return(pressed);
  }
  
  void runPump(Serial s, int pumpNr) {
    String command;
    int turns;
    int c;
    
    turns = 5;
    
    command = "" + pumpNr + "," + turns + "\n";
    println(command);
    s.write(command);   // send to ctrone
    
    c=' ';
    while (c != '*') {
      print(".");
      if (s.available() > 0) c=s.read();
      delay(10);
    }
    
    activePumpNr = 0;
  }
  
}
