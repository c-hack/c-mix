
class cocktailTitle {
   PImage bildT;
   PImage photo;
   float xsizeBild=100,ysizeBild=100,xsizebildT=500,ysizebildT=250;
   float xbildA,ybildA;
   float xbildN,ybildN;
  
   cocktailTitle(){
  
    background(73,94,105);
    //background(100);
    photo=loadImage("HomeC.jpg");
    bildT=loadImage("Logo.png");
 
    xbildA=width-xsizeBild-width/16;
    ybildA=height/2+ysizeBild/2;
    xbildN=width/16;
    ybildN=height/2+ysizeBild/2;
  }


  void display(int xOffset){
  image(bildT,width/4+xOffset,height/4,xsizebildT,ysizebildT);
    textSize(width/10);
    textAlign(CENTER,CENTER);
    //text("C-MIX",width/2+xOffset,height/2);
  
    /*//Alkohol
    image(photo,xbildA+xOffset,ybildA,xsizeBild,ysizeBild);
    textSize(width/30);
    //textAlign(CENTER,CENTER);
    text("Alkohol",xbildA+xsizeBild/2+xOffset,ybildA+ysizeBild);
  
    //Alkoholfrei
    image(photo,xbildN+xOffset,ybildN,xsizeBild,ysizeBild);
    textSize(width/30);
    //textAlign(CENTER,CENTER);
    text("Alkoholfrei",xbildN+xsizeBild/2+xOffset,ybildN+ysizeBild);*/
  }
}