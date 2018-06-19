//==========================================================
// cocktailTest            CC3.0 BY-SA-NC   surasto.de
//==========================================================
  
JSONObject pumpMap;
cocktailList cocktailsAlc, cocktailsNonAlc;
cocktailTitle title;
int modus; // 0=Auswahlseite Alk/NonAlk  1=Cocktailübersicht    2=Cocktaildetails 
int moveX;//Beweg.ges.
int x,mouseStart,xStart;

void setup() {
    //fullScreen();
    size(800,450);
    stroke(0,0,0);
    modus = 0;
    moveX=0;
    x=0;

    pumpMap = loadJSONObject("pumpMap.json");
    
    cocktailsAlc = new cocktailList("cocktailsAlc.json");
    cocktailsNonAlc = new cocktailList("cocktailsNonAlc.json");
    title=new cocktailTitle();
    
   //cocktailsNonAlc.getNrClicked(-520);
  // cocktailsAlc.getNrClicked(520);

} 

void draw () {  // wird hier nicht gebraucht
    int point; 
    
   // background(73,94,105);
   background(100);
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
   
   /*if(mousePressed==true)
   cocktailsNonAlc.getNrClicked(100);
*/
    cocktailsAlc.mouseClicked(x+width);
    cocktailsNonAlc.mouseClicked(x-width);
 
 
  }

    

void mousePressed(){
  mouseStart=mouseX;
  xStart=x;
}

void mouseDragged(){
 //x=mouseX-mouseStart+xStart;
  if((mouseX-mouseStart)>width/4)  moveX=15;
 
    
 if((mouseStart-mouseX)>width/4) moveX=-15;
 
  
}
