class Box {
  float x, y, h, w;

  Box(float x, float y, float w, float h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }

  boolean isInside(float px, float py) {
    return px >= x && px <= x + w && py >= y && py <= y + h;
  }

  float getX () {
    return x;
  }

  float getY () {
    return y;
  }

  float getW () {
    return w;
  }

  float getH () {
    return h;
  }
}
