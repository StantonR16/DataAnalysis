class Photo extends MediaObject {
  private String m_caption, m_path;
  
  public void initPhoto(JSONObject r) {
    m_caption = r.getString("caption");
    m_path = r.getString("path");
    setDateInternal(r.getString("taken_at"));
  }
  
  public String toString() {
    return super.toString() + ": " + m_caption;
  }
}
