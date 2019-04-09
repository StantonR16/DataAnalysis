import java.util.*;
import java.lang.reflect.*;
import java.time.*;

Profile g_me;

int g_mod = 10;

int g_unitIndex = 0;
String[] g_units = {"d", "m", "y", "a"};


Date g_date;
Date g_dateLim;

List<Integer> g_commentCount;
List<Integer> g_likeCount;
List<Integer> g_photoCount;

static final String DATE_START_SZ = "2017-01-01T00:00:00";
static final String DATE_LIM_SZ = "2019-04-01T00:00:00";

static final color COMMENT_CLR = #FF0000;
static final color LIKE_CLR = #00FF00;
static final color PHOTO_CLR = #42DFF4;

static final int DIM = 900;

final static float SCALAR = .33f;

void setup() {

  g_me = new Profile();
  size(900, 900);
  assert height == DIM;
  assert width == DIM;

  //"2019-03-14T09:24:16"
  // Aug 3 2015


  strokeWeight(6);
  smooth();

  g_commentCount = new ArrayList<Integer>();
  g_likeCount = new ArrayList<Integer>();
  g_photoCount = new ArrayList<Integer>();

  g_date = parse(DATE_START_SZ);
  g_dateLim = parse(DATE_LIM_SZ);

  frameRate(60);
}

Date parse(String s) {
  try {

    return g_format.parse(s);
  } 
  catch (Exception x) {
    return null;
  }
}

Date addOneDay(Date date)
{
  if (date.equals(g_dateLim) || date.compareTo(g_dateLim) > 0) {
    return parse(DATE_START_SZ);
  }
  Calendar cal = Calendar.getInstance();
  cal.setTime(date);
  cal.add(Calendar.DATE, 1);
  return cal.getTime();
}

void draw() {

  background(0);


  if (frameCount % g_mod == 0) {
    g_date = addOneDay(g_date);
  }
  
  List<MediaObject> c = null;
  List<MediaObject> l = null;
  List<MediaObject> p = null;

  fill(#FFFFFF);

  //text(g_sb.toString(), 100, 100);
  text("Mode: "+g_units[g_unitIndex], 30, 100);

  String unitStr = "INVALID";
  String uBuf = g_units[g_unitIndex];

  if (uBuf.equals("d")) unitStr = "day";
  if (uBuf.equals("m")) unitStr = "month";
  if (uBuf.equals("y")) unitStr = "year";
  if (uBuf.equals("a")) unitStr = "exact moment";

  text(String.format("Data on the %s of %s", unitStr, g_date), 30, 50);

  c = g_me.getComments(g_date, g_units[g_unitIndex]);
  l = g_me.getLikes(g_date, g_units[g_unitIndex]);
  p = g_me.getPhotos(g_date, g_units[g_unitIndex]);


  g_commentCount.add(c.size());
  g_likeCount.add(l.size());
  g_photoCount.add(p.size());





  if (c != null && l != null && p != null) {

    // I could make a class for this but whatever xd

    final float C_DIM = DIM-c.size() * SCALAR;
    final int C_OFS = 800 - (30);
    graphBar(c.size(), COMMENT_CLR, C_OFS, C_DIM, "Comments", 200);

    final float L_DIM = DIM-l.size() * SCALAR;
    final int L_OFS = 800 - (30+45+20);
    graphBar(l.size(), LIKE_CLR, L_OFS, L_DIM, "Likes", 215);

    final float P_DIM = DIM-p.size() * SCALAR;
    final int P_OFS = 800 - (30+45+20+45+20);
    graphBar(p.size(), PHOTO_CLR, P_OFS, P_DIM, "Photos", 230);
  }

  lineGraph(g_commentCount, COMMENT_CLR, 300);
  lineGraph(g_likeCount, LIKE_CLR, 500);
  lineGraph(g_photoCount, PHOTO_CLR, 700);
  noStroke();
}



void graphBar(int size, color c, float ofs, float dim, String label, int y) {
  final int CLAMP = 20;
  fill(c);
  rect(ofs, (dim), 45, size * SCALAR);
  text(label, ofs, (dim)-CLAMP);
  text(label+": "+size, 30, y);
}



void lineGraph(List<Integer> rg, color c, int clamp) {

  float lineWidth = 1*((float) width/(rg.size()-1));
  for (int i=0; i<rg.size()-1; i++) {
    stroke(c);
    line(i*lineWidth, rg.get(i)+clamp, (i+1)*lineWidth, rg.get(i+1)+clamp);
  }

  final int VAL_LIM = 100;
  if (rg.size() == VAL_LIM) {
    for (int i = 0; i < VAL_LIM / 2; i++)
      rg.remove(i);
  }
}

void keyPressed() {

  if (key == TAB) {

    assert false;

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
