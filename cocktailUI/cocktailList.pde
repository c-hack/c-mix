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
      fill(0, 0, 0);
      textSize(32);
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
       
       bild=loadImage("margarita.jpg");
       image(bild,bildxpos,bildypos,bildsizex,bildsizey);
  
       //Drinkname
       drinknamex=width/20;
       drinknamey=height/5;
       textSize(60);
       text("Caipirihna",drinknamex,drinknamey);
  
       //Zutat
       textSize(30);
       for(int i=0;i<3;i++){
        text("Gsaft",2*drinknamex,j*drinknamey);
        j=j+0.5;
       }
  
      //Abbrechen Knöpf
      rectx=width/20;
      recty=8*height/10;
      noStroke();
      fill(73,94,105);
      rect(rectx,recty,width/8,width/30);
   
      //Text
      fill(255);
      textSize(30);
      text("Abbrechen",rectx,recty+width/40);
       }
  
  // Liefert den index des gewählten Cocktails 0...n ; -1 bedeutet Abbruch
  int getNrClicked() {
    // hier checken wir, welcher der Cocktails angeklickt wurde
    // Nur sinnvoll, wenn wir in der Übersichtsanzeige sind.
    return 0;
  }

  // Hier wird gecheckt, ob entweder der MIX button (return 1) oder Abbruch (return 0) 
  // gedrückt wurde 
  int getButtonClicked() {
    return 0;
  }

}
  