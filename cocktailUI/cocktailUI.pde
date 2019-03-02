//==========================================================
// cocktailTest            CC3.0 BY-SA-NC   surasto.de
// Finale Wischgesten
//==========================================================
import processing.serial.*;

final int DIAG = -1;   // System is in diagnostic mode

cocktailList cocktailsAlc, cocktailsNonAlc;
cocktailTitle title;
diagMode diag;

int modus; // 0=Auswahlseite Alk/NonAlk 3=Cocktaildetails 
int moveX,moveY;//Beweg.ges.
int point;   // -1 = Alle Alkoholfreien   0 = Titel    1 = Alkohol
int x,mouseStartX,mouseStartY,xStart,y;

int hotspotCount;   // Ausschalthack
long frames=0;      // Zählt die Frames seit dem letzten hotspot touch

Serial cTrone;
String[] serialInterfaces = new String[100]; 


void setup() {
    fullScreen();
    noCursor();
    //size(800,480);
    stroke(0,0,0);
    modus = 0;
    moveX=0;
    moveY=0;
    x=0;
    y=0;
  
    diag = new diagMode(); 
     
    println("Alkohol:");
    cocktailsAlc = new cocktailList("cocktailsAlc.json");
    println("Alkoholfrei:");
    cocktailsNonAlc = new cocktailList("cocktailsNonAlc.json");
    title=new cocktailTitle();
    
    serialInterfaces = Serial.list();         
    println("Meine-Interfaces:");
    printArray(serialInterfaces[serialInterfaces.length-1]);
    cTrone = new Serial(this, serialInterfaces[serialInterfaces.length-1], 9600);
    cTrone.write("c-mix ready\n");
} 

void draw () { 
    
    background(0);
    if (modus == 0) {   // Display Title
      if(x>width) x=width;
      if(x<-width) x=-width;
      cocktailsNonAlc.displayAll(x-width);
      title.display(x);
      cocktailsAlc.displayAll(x+width);
      x=x+moveX;
      
      if((x>width) || (x<-width) || ((x>-10)&&(x<10))) moveX=0;
      
     
      fill(255);stroke(255);
      ellipse(width/2,0.9*height,width*0.01,width*0.01);
      ellipse(width/2+width*0.05,0.9*height,width*0.01,width*0.01);
      ellipse(width/2-width*0.05,0.9*height,width*0.01,width*0.01);
      fill(255,0,0);stroke(255,0,0);
      point = 0;
      if (x>width*0.9) point=-1;
      else if (x<-width*0.9) point = 1;
      ellipse(width/2+width*0.05*point,0.9*height,width*0.01,width*0.01);
    }
    
    if (modus == 1 && point==1) {
       cocktailsAlc.display(y);
       y=y+moveY;
        if(y>height) {
         y=0;
         modus=0;
         moveY=0;
         moveX=0;
       }
    }   
    
    if (modus == 1 && point==-1) {
       cocktailsNonAlc.display(y);
       y=y+moveY;
       if(y>height) {
         y=0;
         modus=0;
         moveY=0;
         moveX=0;
       }
    } 
    
    if (modus == DIAG) {
      diag.updateDisplay();
    }
   
   // cocktailsNonAlc.mix();
   frames++;
}


void mouseReleased() {
  int i;
  int pressed;

  if((modus==0) && (point!=0 )) {
    moveX=0;
    moveY=0;
    i= cocktailsAlc.getNrClicked();
    if((i>-1) && (point==-1)) { 
      cocktailsNonAlc.setFocus(i);
      modus=1;
      
    }
    if((i>-1) && (point==1)){
        cocktailsAlc.setFocus(i);
        modus=1;
    }
   
 } else if((modus==1) && cocktailsAlc.Bildclicked()) {
     modus=0;
     if (point == -1) cocktailsNonAlc.mix(cTrone);
     else cocktailsAlc.mix(cTrone);
 } else if (point == 0) {     // Check if the right sequence is hit and shutdown c-mix
   hotspotCount = checkHotspot(hotspotCount);
   if (hotspotCount > 2) modus = DIAG;;
 }
 
 if (modus == DIAG) {
   pressed = diag.checkKnobPressed(mouseX, mouseY);
   if (pressed == 9) modus = 0;
   if (pressed == 10) exit();
   if ((pressed > 0) && (pressed < 9)) diag.runPump(cTrone,pressed);
 }
}

void mousePressed(){
  println("pressed...");
  mouseStartX=mouseX;
  mouseStartY=mouseY;
  xStart=x;
  moveX=0;
}

void mouseDragged(){
  println("dragged...");
  if((mouseX-mouseStartX)>width/4)  moveX=40;
  if((mouseStartX-mouseX)>width/4) moveX=-40;
  if((mouseY-mouseStartY)>height/4)  moveY=40;

}

//==================================================
// Check for Diagnostic sequence
//   1. Hit the drink in the glass
//   2. hit the bottom stand of teh glass
//   3. Hit the center of the "X" in C-MIX
//==================================================
int checkHotspot(int h) {

  if ((hotspotCount == 0) && mouseAt(440,165)) {
    h=1;
    frames = 0;
  } else 
  if ((hotspotCount == 1) && mouseAt(440,272) && (frames < 1000)) {
    h=2;
    frames = 0;
  } else
  if ((hotspotCount == 2) && mouseAt(476,225) && (frames < 1000)) {
    h=3;
    frames = 0;
  } else h=0;
  return(h);
}

boolean mouseAt(int x, int y) {
  if ((mouseX < x+20) && (mouseX > x-20) && (mouseY < y+20) && (mouseY > y-20)) return(true); else return(false);  
}
