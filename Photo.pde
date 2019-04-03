class Photo extends MediaObject {
  private String m_caption, m_path;
  
  @Override
  public void init(JSONArray rg) {
    m_caption = rg.getString(0);
    setDateInternal(rg.getString(1));
    m_path = rg.getString(2);
  }
}
