import java.util.*;
import java.lang.reflect.*;

void setup () {
  Profile me = new Profile("p1");
  me.printDataForDate(TimeUnit.YEAR, 2017);
  me.printDataForDate(TimeUnit.YEAR, 2018);
  me.printDataForDate(TimeUnit.YEAR, 2019);
  
  
  println(me.getComment(0));
}



void printf(String s, Object... args) {
  println(String.format(s,args));
}
