import java.util.function.*;


class Profile {
  private final List<MediaObject> m_likes;
  private final List<MediaObject> m_comments;
  private final List<MediaObject> m_photos;

  public Profile() {
    JSONObject commentsObj = loadJSONObject("p1"+"/comments.json");
    m_comments = deserializeComments(commentsObj, "media_comments");

    JSONObject likesObj = loadJSONObject("p1"+"/likes.json");
    m_likes = deserializeLikes(likesObj, "media_likes");

    JSONObject photosObj = loadJSONObject("p2"+"/media.json");
    m_photos = deserializePhotos(photosObj, "photos");
  }

  public List<MediaObject> getPhotos() {
    return m_photos;
  }

  public List<MediaObject> getPhotos(Date d) {
    return whereTimeIs(m_photos, d);
  }

public List<MediaObject> getPhotos(Date d,String u) {
    return whereTimeIs(m_photos, d,u);
  }

  public List<MediaObject> getComments() {
    return m_comments;
  }
  public List<MediaObject> getComments(Date d) {
    return whereTimeIs(m_comments, d);
  }
  
  public List<MediaObject> getComments(Date d,String u) {
    return whereTimeIs(m_comments, d,u);
  }
  
  public List<MediaObject> getLikes() {
    return m_likes;
  }
  public List<MediaObject> getLikes(Date d) {
    return whereTimeIs(m_likes, d);
  }
  public List<MediaObject> getLikes(Date d,String u) {
    return whereTimeIs(m_likes, d,u);
  }



  public Photo getPhoto(int i) {
    return (Photo) m_photos.get(i);
  }

  public Comment getComment(int i) {
    return (Comment) m_comments.get(i);
  }

  public MediaObject getLike(int i) {
    return m_likes.get(i);
  }


private List<MediaObject> whereTimeIs(List<MediaObject> list, Date d) {

  return whereTimeIs(list,d,"a");
}
  private List<MediaObject> whereTimeIs(List<MediaObject> list, Date d, String u) {
    List<MediaObject> listCpy = new ArrayList<MediaObject>();
    for (MediaObject m : list) {

      if (u.equals("a")) {
        if (m.getDate().equals(d)) {
          listCpy.add(m);
        }
        
      }
      
      if (u.equals("d")) {
        if (m.getDate().getDay() == d.getDay()) {
          listCpy.add(m);
        }
        
      }
      
      if (u.equals("y")) {
          if (m.getDate().getYear() == d.getYear()) {
            listCpy.add(m);
          }
          
        }
        
        if (u.equals("m")) {
            if (m.getDate().getMonth() == d.getMonth()) {
              listCpy.add(m);
            }
          }
    }
      return listCpy;
    }
  }
