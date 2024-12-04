// Secondary Window Class
class SecondaryWindow extends PApplet {
  SecondaryWindow() {
    PApplet.runSketch(new String[] {"Secondary Window"}, this);
  }

  public void settings() {
    size(300, 300);
  }

  public void setup() {
    surface.setTitle("Secondary Window");
    background(0);
  }

  public void draw() {
    
  }
}