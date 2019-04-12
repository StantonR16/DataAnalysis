import java.text.*;

// Date format used by IG
static final SimpleDateFormat g_format = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss");

public class MediaObject {

  private String m_name, m_date;
  public MediaObject() {}
  
  public void init(JSONArray rg) {
    m_date = rg.getString(0);
    m_name = rg.getString(rg.size()-1);
  }
  
  public String toString() {
    return String.format("[%s] %s", m_name, m_date);
  }
  
  // Workaround
  void setDateInternal(String date) {
    m_date = date;
  }
  
  public String getName() { return m_name;}
  
  // Format: 2019-03-17T16:02:37
  public String getDateString() {return m_date;}
  
  
  public Date getDate() {
    try {
     return g_format.parse(m_date);
    } catch (Exception x) {
      return null;
    }
   
  }
}


// This is so inefficient lol

List<MediaObject> deserializePhotos(JSONObject obj, String key) {
  JSONArray rg = obj.getJSONArray(key);
  List<MediaObject> media = new ArrayList<MediaObject>(rg.size());
  
  for (int i = 0; i < rg.size(); i++) {
    Photo m = new Photo();
    m.initPhoto(rg.getJSONObject(i));
    media.add(m);
  }
  
  return media;
  
}

List<MediaObject> deserializeLikes(JSONObject obj, String key) {
  JSONArray rg = obj.getJSONArray(key);
  List<MediaObject> media = new ArrayList<MediaObject>(rg.size());
  
  for (int i = 0; i < rg.size(); i++) {
    MediaObject m = new MediaObject();
    m.init(rg.getJSONArray(i));
    media.add(m);
  }
  
  return media;
  
}

List<MediaObject> deserializeComments(JSONObject obj, String key) {
  JSONArray rg = obj.getJSONArray(key);
  List<MediaObject> media = new ArrayList<MediaObject>(rg.size());
  
  for (int i = 0; i < rg.size(); i++) {
    MediaObject m = new Comment();
    m.init(rg.getJSONArray(i));
    media.add(m);
  }
  
  return media;
  
}
