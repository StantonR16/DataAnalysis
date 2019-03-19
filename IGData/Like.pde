class Like implements Serializable {
  private String m_date, m_name;
  
  Like() {}
  
  void init(JSONArray rg) {
    m_date = rg.getString(0);
    m_name = rg.getString(1);
  }
}
