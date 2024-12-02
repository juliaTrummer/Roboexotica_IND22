class Box {
  float x, y, w, h;
  int defaultColor;
  int currentColor;
  boolean hasIngredient;
  int currentId;

  Box(float x, float y, float w, float h, int boxColor) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.defaultColor = boxColor;
    this.currentColor = boxColor;
    this.hasIngredient = false;
    this.currentId = -1; // -1 means no ingredient
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

  void setHasIngredient(boolean hasIngredient, int id) {
    this.hasIngredient = hasIngredient;
    this.currentId = id;
    if (!hasIngredient) {
      resetColor(); // Reset color when no ingredient
    }
  }

  boolean getHasIngredient() {
    return this.hasIngredient;
  }

  int getCurrentId() {
    return this.currentId;
  }
}
