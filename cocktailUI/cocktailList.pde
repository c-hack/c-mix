class cocktailList {
  
  JSONArray rezeptListe;
  JSONArray rezept;
  JSONObject cocktailHeader, cocktailZutat;
  int cocktailInFocus;
  
  int xpos,ypos;
  PImage[] photo = new PImage[8];
  float xph,yph;

  cocktailList(String filename) {
     rezeptListe = loadJSONArray(filename);  
     cocktailInFocus = 0;
     xph=height/4;   //Bildgröße für Icon
     yph=height/4;

    for (int i=0; (i<rezeptListe.size())&&(i<8); i++) {
      rezept = rezeptListe.getJSONArray(i);
      cocktailHeader = rezept.getJSONObject(0);
      photo[i]=loadImage(cocktailHeader.getString("Bild"));
    }
  }

  // Diese Methode soll alle Cocktails mit jeweils einem kleinen Symbol darstellen
  // Zur Zeit werden nur die Namen in der Konsole angezeigt
  // ToDo: Grafische Anzeige mit Fotos  
  void displayAll(int xOffset) {
    float xpos, ypos;
    
    xpos=width/20;
    ypos=height/10;
    for (int i=0; (i<rezeptListe.size())&&(i<8); i++) {
      rezept = rezeptListe.getJSONArray(i);
      cocktailHeader = rezept.getJSONObject(0);
      fill(255);
      textSize(width/40);
      textAlign(CENTER,TOP);
      text(cocktailHeader.getString("DrinkName"), xpos+xph/2+xOffset, ypos+yph); 
      image(photo[i],xpos+xOffset,ypos,xph,yph);
      xpos=xpos+width/4;
     
      if(i==3){ypos=height/2; xpos=width/20; }
    }
  }
  
  // Legt fest auf welchen Cocktail sich die nächsten Aktionen beziehen
  void setFocus(int index) {
    cocktailInFocus = index;
  }
  
  // Zeigt den Cocktail im Fokus an
  // ToDo: Grafische Darstellung mit Bild und liste der Zutaten
  void display() {
      PImage bild;
      float bildsizex,bildsizey;
      float bildxpos,bildypos;
      float drinknamex,drinknamey;
      float j=2;
      float rectx,recty;

     //Cockt. Bild
      bildsizex=width/3;
      bildsizey=width/3;
      bildxpos=width/2+bildsizex/4;;
      bildypos=height/4;
  
      rezept = rezeptListe.getJSONArray(cocktailInFocus);
      cocktailHeader = rezept.getJSONObject(0);
      //println("Cocktail: ",cocktailHeader.getString("DrinkName"));
       
       /**/bild=loadImage(cocktailHeader.getString("Bild"));
       image(bild,bildxpos,bildypos,bildsizex,bildsizey);
  
       //Drinkname
       drinknamex=width/20;
       drinknamey=height/5;
       textSize(width/15);
       text(cocktailHeader.getString("DrinkName"),drinknamex,drinknamey);
  
       //Zutat
       textSize(width/25);
       for(int i=1;i<rezept.size();i++){
        cocktailZutat = rezept.getJSONObject(i);
        text(cocktailZutat.getString("Zutat"),2*drinknamex,j*drinknamey);
        j=j+0.5;
       }
  
      //Abbrechen Knöpf
      rectx=width/20;
      recty=8*height/10;
      noStroke();
      fill(73,94,105);
      rect(rectx,recty,width/5,width/20);
   
      //Text
      fill(255);
      textSize(width/25);
      text("Abbrechen",rectx,recty+width/40);
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
  
 
  // Hier wird gecheckt, ob entweder der MIX button (return 1) oder Abbruch (return 0) 
  // gedrückt wurde 
  int getButtonClicked() {
    return 0;
  }
}