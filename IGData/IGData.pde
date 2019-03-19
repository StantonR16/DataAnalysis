import java.util.*;
import java.io.Console;
import java.nio.charset.Charset;
import java.lang.reflect.Constructor;
import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import static java.lang.System.out;

void setup() {
  JSONObject obj=loadJSONObject("p1/comments.json");
  
  Constructor[] crap=CommentCrap.class.getDeclaredConstructors();
  println(crap.length);
  
  List<CommentCrap> mediaComments = deserialize(CommentCrap.class, obj,"media_comments");
  println("Comments: " + mediaComments.size());
  
}

public class CommentCrap implements Serializable {

  private String m_name, m_value, m_date;
  
  public CommentCrap(JSONArray rg) {
    
  }
  
  public void init(JSONArray rg) {
    assert rg!=null;
    m_date = rg.getString(0);
    m_value = rg.getString(1);
    m_date = rg.getString(2);
  }
}

interface Serializable {
  void init(JSONArray array);
}

<T extends Serializable> List<T> deserialize(Class<T> clazz,JSONObject obj, String key) {
  JSONArray rg = obj.getJSONArray(key);
  assert rg.size() > 0;
  List<T> values = new ArrayList<T>(rg.size());
  
  for (int i = 0; i < rg.size(); i++) {
    T t = null;
    // God Java sucks
    try {
      Constructor c = clazz.getDeclaredConstructors()[0];
      c.setAccessible(true);
      t = (T) c.newInstance(rg.getJSONArray(i));
    } catch (Exception x) {
      println(x);
      x.printStackTrace();
    } 
    t.init(rg.getJSONArray(i));
    values.add(t);
  }
  return values;
}
