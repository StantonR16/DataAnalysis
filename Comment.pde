public class Comment extends MediaObject {

  private String m_value;
  
  public Comment() {
  }
  
  @Override
  public void init(JSONArray rg) {
    super.init(rg);
    m_value = rg.getString(1);
    
  }
  
  public String toString() {
    return String.format("%s: \"%s\"", super.toString(), m_value);
  }
}
