class cocktailList {
  
  JSONArray rezeptListe;
  JSONArray rezept;
  JSONObject cocktailHeader, cocktailZutat;
  int cocktailInFocus;
  JSONObject pumpMap;
  
  int xpos,ypos;
  PImage[] photo = new PImage[8];
  PImage[] icon = new PImage[8];
  float xph,yph;
  float bildxpos,bildypos,bildsizex,bildsizey;

  cocktailList(String filename) {
     rezeptListe = loadJSONArray(filename);  
     pumpMap = loadJSONObject("pumpMap.json");
     cocktailInFocus = 0;
     xph=height/3.5;   //Bildgröße für Icon
     yph=height/3.5;


     bildsizex=width/2.5;     //Cocktail display
     bildsizey=width/2.5;
     bildxpos=width/2+bildsizex/4;
//     bildypos=height/4.5;
     bildypos = -50;
     
     // Alle Bilder laden
     for (int i=0; (i<rezeptListe.size())&&(i<8); i++) {
       rezept = rezeptListe.getJSONArray(i);
       cocktailHeader = rezept.getJSONObject(0);
       photo[i]=loadImage("pics/"+cocktailHeader.getString("Bild"));
       icon[i]=loadImage("pics/icons/icon."+cocktailHeader.getString("Bild"));
     }
  }

  // Diese Methode stellt alle Cocktails mit jeweils einem kleinen Symbol dar
  void displayAll(int xOffset) {
    float xpos, ypos;
    
    xpos=width/20;
    ypos=height/10;
    for (int i=0; (i<rezeptListe.size())&&(i<8); i++) {
      rezept = rezeptListe.getJSONArray(i);
      cocktailHeader = rezept.getJSONObject(0);
      fill(255);
      textSize(width/42);
      textAlign(CENTER,TOP);
      text(cocktailHeader.getString("DrinkName"), xpos+xph/2+xOffset, ypos+yph); 
      image(icon[i],xpos+xOffset,ypos-height/15);
      xpos=xpos+width/4;
     
      if(i==3){ypos=height/2; xpos=width/20; }
    }
  }
  
  // Legt fest auf welchen Cocktail sich die nächsten Aktionen beziehen
  void setFocus(int index) {
    cocktailInFocus = index;
  }
  
  // Zeigt den Cocktail im Fokus an
  void display(int yOffset) {
    PImage bild;
    
    float drinknamex,drinknamey;
    float j=2;

     rezept = rezeptListe.getJSONArray(cocktailInFocus);
     cocktailHeader = rezept.getJSONObject(0);
     //println("Cocktail: ",cocktailHeader.getString("DrinkName"));
     
     bild=loadImage("pics/"+cocktailHeader.getString("Bild"));
     image(bild,bildxpos,bildypos+yOffset);   //,bildsizex,bildsizey);

     //Drinkname
     drinknamex=width/4;
     drinknamey=height/5;
     fill(255);
     textSize(width/20);
     text(cocktailHeader.getString("DrinkName"),drinknamex,drinknamey+yOffset);

     //Zutat
     textSize(width/27);
     for(int i=1;i<rezept.size();i++){
      cocktailZutat = rezept.getJSONObject(i);
      text(cocktailZutat.getString("Zutat"),drinknamex,j*drinknamey+yOffset);
      j=j+0.5;
     }
  }
  
  
  
  // Liefert den index des gewählten Cocktails 0...n ; -1 bedeutet Abbruch
  int getNrClicked() {

    float xpos,ypos;
    int bildnummer=-1,i;
    
    xpos=width/20;
    ypos=height/10;
    for(i=0;(i<rezeptListe.size()) && (i<8);i++) {
      if((mouseX>xpos) && (mouseX<xpos+xph) && (mouseY<ypos+yph) && (mouseY>ypos)) bildnummer=i;
      xpos=xpos+width/4;
      
      if(i==3) { ypos=height/2; xpos=width/20;}
    }
    
    return bildnummer;
  }
  
  boolean Bildclicked(){
    if((mouseX>bildxpos) && (mouseX<bildxpos+bildsizex) && (mouseY<bildypos+bildsizey) && (mouseY>bildypos)) return true;
    else return false;
  }

  //Hier wird die Sequenz der Pumpenbefehle an c-trone geschickt
  // Pumpen #,Umdrehungen
  // NEU: Außerdem wird de Lichtfarbe der Glasbeleuchtung aus dem Rezept gelesen
  //      und an c-trone geschickt. 
  void mix(Serial s){
      String zutat;
      float menge;
      int pmp;
      int c;
      float pmpCal=0;
      int turns;
      String command;
      String lightColor;
      
      println("Cocktail: ",cocktailInFocus);
      rezept = rezeptListe.getJSONArray(cocktailInFocus);
        
      //Ermitteln dre Lichtfarbe aus dem Rezept
      cocktailHeader = rezept.getJSONObject(0);
      lightColor = cocktailHeader.getString("Lichtfarbe");
      println(lightColor);
      s.write("L"+lightColor.charAt(0)+" \n");   // Glasbeleuchtung an c-trone
      
      //Lesen der Anzahl von umdrehung pro centi-liter
      pmpCal = pumpMap.getFloat("PumpCalibration");
      
      for(int i=1;i<rezept.size();i++){
         cocktailZutat = rezept.getJSONObject(i);
         zutat=cocktailZutat.getString("Zutat");
         menge=cocktailZutat.getFloat("Menge");
         pmp= pumpMap.getInt(zutat);
         println(zutat+" "+menge+" "+"nrpump="+pmp);
         
         turns = int(menge * pmpCal);
         println(pmp,turns);
         
         command = "" + pmp + "," + turns + "\n";
         println(command);
         s.write(command);   // send to ctrone
         
         //Warten auf Rückmeldung (='*') von c-trone
         c=' ';
         while (c != '*') {
           //print(".");
           if (s.available() > 0) c=s.read();
           delay(10);
         }
      }
      s.write("LX \n");   // Glasbeleuchtung aus
   }
}
