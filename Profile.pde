import java.util.function.*;
class Profile {
  private final List<MediaObject> m_likes;
  private final List<MediaObject> m_comments;
  private final List<MediaObject> m_photos;

  public Profile(String root) {
    JSONObject commentsObj = loadJSONObject(root+"/comments.json");
    m_comments = deserializeComments(commentsObj, "media_comments");

    JSONObject likesObj = loadJSONObject(root+"/likes.json");
    m_likes = deserializeLikes(likesObj, "media_likes");
    
    m_photos = null;//todo
  }
  
  public Comment getComment(int i) {
    return (Comment) m_comments.get(i);
  }
  
  private List<MediaObject> whereTimeIs(List<MediaObject> list, TimeUnit t, int v) {
    List<MediaObject> listCpy = new ArrayList<MediaObject>();
    for (MediaObject m : list) {
      
      int buf = -1;
      switch (t) {
        case YEAR:
          buf = m.year();
          break;
          case MONTH:
          buf = m.month();
          break;
          case DAY:
          buf = m.day();
          break;
      }
      if (buf == v) {
        listCpy.add(m);
      }
    }
    return listCpy;
  }
  
  public void printDataForDate(TimeUnit t, int v) {
   List<MediaObject> c = whereTimeIs(m_comments, t,v);
   List<MediaObject> l = whereTimeIs(m_likes, t,v);
   
   printf("Comments: %d",c.size());
   printf("Likes: %d",l.size());
   println();
  }
}

enum TimeUnit {
  YEAR, MONTH, DAY
}
