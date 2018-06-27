//==========================================================
// cocktailTest            CC3.0 BY-SA-NC   surasto.de
//==========================================================
  
JSONObject pumpMap;
cocktailList cocktailsAlc, cocktailsNonAlc;
cocktailTitle title;
int modus; // 0=Auswahlseite Alk/NonAlk 3=Cocktaildetails 
int moveX,moveY;//Beweg.ges.
int point;   // -1 = Alle Alkoholfreien   0 = Titel    1 = Alkohol
int x,mouseStartX,mouseStartY,xStart,y;

void setup() {
    //fullScreen();
    size(800,450);
    stroke(0,0,0);
    modus = 0;
    moveX=0;
    moveY=0;
    x=0;
    y=0;
    pumpMap = loadJSONObject("pumpMap.json");
  
    println("Alkohol:");
    cocktailsAlc = new cocktailList("cocktailsAlc.json");
    println("Alkoholfrei:");
    cocktailsNonAlc = new cocktailList("cocktailsNonAlc.json");
    title=new cocktailTitle();

} 

void draw () {  // wird hier nicht gebraucht
    
    background(0);
    // background(100);
    if (modus == 0) {   // Display Title
      if(x>width) x=width;
      if(x<-width) x=-width;
      cocktailsNonAlc.displayAll(x-width);
      title.display(x);
      cocktailsAlc.displayAll(x+width);
      x=x+moveX;
      y=y+moveY;
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
    }   
    
    if (modus == 1 && point==-1) {
       cocktailsNonAlc.display(y);
    }   
}


void mouseReleased() {
  int i;
 if((modus==0) && (point!=0 )) {
    i= cocktailsAlc.getNrClicked();
    if((i>-1) && (point==-1)) { 
      cocktailsNonAlc.setFocus(i);
      modus=1;
      
    }
    if((i>-1) && (point==1)){
        cocktailsAlc.setFocus(i);
        modus=1;
    }
   
 }
 
 else if((modus==1) && cocktailsAlc.Bildclicked()) {
      modus=0;
    
    }

}

void mousePressed(){
  mouseStartX=mouseX;
  mouseStartY=mouseY;
  xStart=x;
}

void mouseDragged(){
 //x=mouseX-mouseStart+xStart;
  if((mouseX-mouseStartX)>width/4)  moveX=20;
  if((mouseStartX-mouseX)>width/4) moveX=-20;
 
 
  if((mouseY-mouseStartY)>width/4)  moveY=20;
  if((mouseStartY-mouseY)>width/4) moveY=-20;
  
}