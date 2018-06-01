
class cocktailTitle {
  
   PImage photo;
   float xsizeBild=200,ysizeBild=200;
   float xbildA,ybildA;
   float xbildN,ybildN;
  
   cocktailTitle(){
  
    background(73,94,105);
    //background(100);
    photo=loadImage("HomeC.jpg");

    xbildA=width-xsizeBild-width/16;
    ybildA=height/2+ysizeBild/2;
    xbildN=width/16;
    ybildN=height/2+ysizeBild/2;
  }


  void display(int xOffset){
  
    textSize(170);
    textAlign(CENTER,CENTER);
    text("C-MIX",width/2+xOffset,height/2);
  
    //Alkohol
    image(photo,xbildA+xOffset,ybildA,xsizeBild,ysizeBild);
    textSize(45);
    //textAlign(CENTER,CENTER);
    text("Alkohol",xbildA+xsizeBild/2+xOffset,ybildA+ysizeBild);
  
    //Alkoholfrei
    image(photo,xbildN+xOffset,ybildN,xsizeBild,ysizeBild);
    textSize(45);
    //textAlign(CENTER,CENTER);
    text("Alkoholfrei",xbildN+xsizeBild/2+xOffset,ybildN+ysizeBild);
  }
}