class diagMode {
  
  int activePumpNr;
  JSONObject pumpMap;
  String[] zutatenListe;
  
  diagMode() {
    activePumpNr = 0;
    pumpMap = loadJSONObject("pumpMap.json");
    zutatenListe = (String[]) pumpMap.keys().toArray(new String[pumpMap.size()]);
    println(zutatenListe[0]);
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
      fill(17,181,255);
      if (i == activePumpNr) fill(17,70,70);
      strokeWeight(3);
      stroke(255,255,255);
      rect(x, 60, 75,50,5);
      fill(0);
      if (i == activePumpNr) fill(255);
      textSize(30);
      text(9-i,x+37,90);
      x+=95;
      if (i==4) x+=20;
    }
 
    for (int i=1; i<zutatenListe.length; i++) {
      x = pumpMap.getInt(zutatenListe[i]);
      textSize(11);
      if (x<5) text(zutatenListe[i],(8-x)*95+77,105);
      else text(zutatenListe[i],(8-x)*95+55,105);
    }
    textSize(30);
    strokeWeight(3);
    stroke(255,255,255);
    fill(17,181,255);
    rect(20, 400,200,50,5);
    fill(0);
    text("Zurück",120,435);

    fill(17,181,255);
    rect(580, 400,200,50,5);
    fill(0);
    text("Reboot",680,435);
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