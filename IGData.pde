import java.util.*;
import java.lang.reflect.*;

void setup () {
  
  
  
  JSONObject commentsObj = loadJSONObject("p1/comments.json");
  List<MediaObject> comments = deserialize(commentsObj, "media_comments");
  printf("Parsed %d comment objects", comments.size());
  
  
  JSONObject likesObj = loadJSONObject("p1/likes.json");
  List<MediaObject> likes = deserialize(likesObj, "media_likes");
  
  printf("Parsed %d like objects", likes.size());
}

void printf(String s, Object... args) {
  println(String.format(s,args));
}
List<MediaObject> deserialize(JSONObject obj, String key) {
  JSONArray rg = obj.getJSONArray(key);
  List<MediaObject> media = new ArrayList<MediaObject>(rg.size());
  
  for (int i = 0; i < rg.size(); i++) {
    MediaObject m = new MediaObject();
    m.init(rg.getJSONArray(i));
    media.add(m);
  }
  
  return media;
  
}

public class MediaObject {

  private String m_name, m_date;
  public MediaObject() {}
  
  public void init(JSONArray rg) {
    m_date = rg.getString(0);
    m_name = rg.getString(rg.size()-1);
  }
}
public class Comment extends MediaObject {

  private String m_value;
  
  public Comment() {
  }
  
  @Override
  public void init(JSONArray rg) {
    super.init(rg);
    m_value = rg.getString(1);
    
  }
}
