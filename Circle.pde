class Circle {
  // Existing properties
  float centerX, centerY;
  float radius;
  int colour;
  boolean hasIngredient;
  int currentId;
  int initialColour;
  String name;

  Sound sound; // Reference to a sound

  // Constructor
  Circle(float x, float y, float r, int colour, String name) {
    centerX = x;
    centerY = y;
    radius = r;
    this.colour = color(0, 0, 0);
    this.initialColour = colour;
    hasIngredient = false;
    currentId = -1;
    this.name = name;
    this.sound = null; // Initialize with no sound
  }

  void setSound(Sound sound) {
    this.sound = sound;
  }

  Sound getSound() {
    return sound;
  }

  // Check if a point is inside the circle
  boolean isInside(float x, float y) {
    float d = dist(x, y, centerX, centerY);
    return d <= radius;
  }

  // Setters and Resetters
  void setColour(int c) {
    colour = c;
  }

  void resetColour() {
    colour = color(0); // Reset to default white
  }

  void setHasIngredient(boolean has, int id) {
    hasIngredient = has;
    currentId = id;
  }

  boolean getHasIngredient() {
    return hasIngredient;
  }

  int getCurrentId() {
    return currentId;
  }

  void addText(String text, float centerX, float centerY, float radius, color colour) {
    fill(colour);
    textSize(42);  // Set the font size
    textAlign(CENTER, CENTER);
    text(text, centerX, centerY+radius+(height*0.1));
  }

   void drawCircle() {
    noFill();
    stroke(initialColour);
    strokeWeight(5);
    ellipse(centerX, centerY, radius*2, radius*2);
    addText(name, centerX, centerY, radius, initialColour);
    noStroke();
    fill(colour);
    ellipse(centerX, centerY, radius*2, radius*2);
    fill(initialColour);
    ellipse(centerX, centerY, radius/2, radius/2);
    fill(colour);
    ellipse(centerX, centerY, radius/10, radius/10);
  }
}
