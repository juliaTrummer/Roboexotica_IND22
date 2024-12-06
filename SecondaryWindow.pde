// Secondary Window Class
class SecondaryWindow extends PApplet {
  
  float yOffset = 0;  // Offset for vertical animation
float speed = 2;    // Speed of the animation
float alpha = 0;    // Transparency value for fading
boolean fadingIn = true; // Direction of fade

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

 void draw() {
  background(240); // Light gray background

  // Main title animation
  textSize(100); // Set font size for the title
  fill(50); // Dark gray color
  textAlign(CENTER, CENTER); // Align text to center
  text("Here should be text", width / 2, height / 2 + yOffset);
  

  // Subtitle fade animation
  if (fadingIn) {
    alpha += 2; // Increase alpha
    if (alpha >= 255) fadingIn = false; // Reverse when fully visible
  } else {
    alpha -= 2; // Decrease alpha
    if (alpha <= 0) fadingIn = true; // Reverse when fully transparent
  }

  fill(100, alpha); // Text color with alpha transparency
  textSize(24); // Smaller font size for subtitle
  text("Here should be another text", width / 2, height / 2 + 70);
}
}