import java.util.*;
import java.lang.reflect.*;
import java.time.*;

Profile g_me;

String g_sb;

void setup() {
  g_me = new Profile();
  size(900, 900);
  //"2019-03-14T09:24:16"
  // Aug 3 2015
  g_sb = ("2017-01-01T00:00:00");

  try {
    
    g_date = g_format.parse(g_sb);
  } 
  catch (Exception x) {
  }
  
  frameRate(60);
}

int g_mod = 30;
Date g_date;

Date addOneDay(Date date)
{
  Calendar cal = Calendar.getInstance();
  cal.setTime(date);
  cal.add(Calendar.DATE, 1);
  return cal.getTime();
}

void draw() {

  background(0);
  if (frameCount % g_mod == 0) {
    g_date = addOneDay(g_date);
    g_sb = "";
    try {
      g_sb =(g_format.format(g_date));
    } 
    catch(Exception x) {
    }
  }
  List<MediaObject> c = null;
  List<MediaObject> l = null;
  List<MediaObject> p = null;

  fill(255, 0, 0);

  //text(g_sb.toString(), 100, 100);
  text("Mode: "+g_units[g_unitIndex], 30, 100);
  
  String unitStr = "INVALID";
  String uBuf = g_units[g_unitIndex];
  
  if (uBuf.equals("d")) unitStr = "day";
  if (uBuf.equals("m")) unitStr = "month";
  if (uBuf.equals("y")) unitStr = "year";
  if (uBuf.equals("a")) unitStr = "exact moment";
  
  text(String.format("Data on the %s of %s", unitStr,g_sb), 30, 50);

  c = g_me.getComments(g_date, g_units[g_unitIndex]);
  l = g_me.getLikes(g_date, g_units[g_unitIndex]);
  p = g_me.getPhotos(g_date, g_units[g_unitIndex]);





  if (c != null && l != null && p != null) {
    rect(800 - (30), (900-c.size()), 45, c.size());
    rect(800 - (30+45+20), (900-l.size()), 45, l.size());
    rect(800 - (30+45+20+45+20), (900-p.size()), 45, p.size());

    text("Comments: "+c.size(), 30, 200);
    text("Likes: "+l.size(), 30, 215);
    text("Photos: "+p.size(), 30, 230);
  }
}

String[] g_units = {"d", "m", "y", "a"};
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
}


void printf(String s, Object... args) {
  println(String.format(s, args));
}
