class Box {
  float x, y, w, h;
  int defaultColor; 
  int currentColor;

  Box(float x, float y, float w, float h, int boxColor) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.defaultColor = boxColor;
    this.currentColor = boxColor;
  }

  void setColor(int c) {
    this.currentColor = c;
  }

  void resetColor() {
    this.currentColor = defaultColor;
  }

  int getColor() {
    return this.currentColor;
  }

  boolean isInside(float px, float py) {
    return px >= x && px <= x + w && py >= y && py <= y + h;
  }
}
