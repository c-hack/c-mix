import ddf.minim.*;
import java.io.*;
Minim minim;
AudioPlayer player;
 
void setup()
{
  size(100, 100);
  minim = new Minim(this);
  player = minim.loadFile("marimba.mp3");
  player.play();
}
 
void draw()
{
  background(0);
  stroke(255);
 // player.play();
}
