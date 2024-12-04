// Secondary Window Class
class SecondaryWindow extends PApplet {
  SecondaryWindow() {
    PApplet.runSketch(new String[] {"Secondary Window"}, this);
  }

  public void settings() {
    size(1900, 1080);
  }

  public void setup() {
    surface.setTitle("Secondary Window");
    background(0);
  }

  public void draw() {
    
  }
}