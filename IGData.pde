import java.util.*;
import java.lang.reflect.*;


Profile g_me;

StringBuilder g_sb = new StringBuilder();

void setup() {
  g_me = new Profile();
  size(900, 900);
  g_sb.append("2019-03-14T09:24:16");
}



void draw() {

  background(0);
  List<MediaObject> c = null;
  List<MediaObject> l = null;
  List<MediaObject> p = null;

  fill(255, 0, 0);

  text(g_sb.toString(), 100, 100);
  text(g_units[g_unitIndex], 30, 100);

  
    try {

      

      Date d= g_format.parse(g_sb.toString());

      c = g_me.getComments(d, g_units[g_unitIndex]);
      l = g_me.getLikes(d, g_units[g_unitIndex]);
      p = g_me.getPhotos(d, g_units[g_unitIndex]);
    } 
    catch (ParseException x) {
      text(x.getMessage(), 100, 200);
    }
  



  if (c != null && l != null && p != null) {
    rect(30, (900-c.size()), 45, c.size());
    rect(30+45+20, (900-l.size()), 45, l.size());
    rect(30+45+20+45+20, (900-p.size()), 45, p.size());

    text("Comments: "+c.size(), 200, 200);
    text("Likes: "+l.size(), 200, 215);
    text("Photos: "+p.size(), 200, 230);
  }
}

String[] g_units = {"a", "y", "m", "d"};
int g_unitIndex = 0;

void keyPressed() {

  if (key == TAB) {
    if (g_unitIndex + 1 >= g_units.length) {
      g_unitIndex = 0;
      return;
    }
     g_unitIndex++;
     return;
  }
  
  if ((key == BACKSPACE) && g_sb.length() > 0) {
    g_sb.deleteCharAt(g_sb.length() - 1);
  } else if (keyCode == DELETE && g_sb.length() > 0) {
    g_sb.setLength(0);
  } else if (keyCode != SHIFT && keyCode != CONTROL && keyCode != ALT) {
    g_sb.append(key);
  }
}


void printf(String s, Object... args) {
  println(String.format(s, args));
}
