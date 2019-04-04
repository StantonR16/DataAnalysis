import java.util.*;
import java.lang.reflect.*;


Profile g_me;

void setup() {
  g_me = new Profile();
  size(900,900);
}

StringBuilder g_sb = new StringBuilder();

void draw() {
  
  background(0);
  List<MediaObject> c = g_me.getComments();
  List<MediaObject> l = g_me.getLikes();
  List<MediaObject> p = g_me.getPhotos();
  
  fill(255,0,0);
  
  text(g_sb.toString(),100,100);
  
   try {
     g_format.parse(g_sb.toString());
   } catch (ParseException x) {
     text(x.getMessage(),100,200);
   }
  
  rect(30,(900-c.size()),45, c.size());
}

void keyPressed() {
  
  if ((key == BACKSPACE) && g_sb.length() > 0) {
    g_sb.deleteCharAt(g_sb.length() - 1);
  } 
  else if (keyCode == DELETE && g_sb.length() > 0) {
    g_sb.setLength(0);
  } else if (keyCode != SHIFT && keyCode != CONTROL && keyCode != ALT) {
    g_sb.append(key);
  }
}


void printf(String s, Object... args) {
  println(String.format(s, args));
}
