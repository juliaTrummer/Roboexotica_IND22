class Boxes {
  float boxWidth = 200;
  float boxHeight = 200;
  float spacing = 20;
  ArrayList<Box> boxList;
  Ingredient currentAlcohol;

  Boxes() {

    boxList = new ArrayList<Box>();
    float totalWidth = (4 * boxWidth) + ((4 - 1) * spacing);
    float startX = (width - totalWidth) / 2;
    float centerY = height / 2;

    for (int i = 0; i < 4; i++) {
      float x = startX + i * (boxWidth + spacing);
      float y = centerY - boxHeight / 2;
      Box box = new Box(x, y, boxWidth, boxHeight, 255);
      boxList.add(box);
    }
  }

  void drawBoxes() {
    for (Box box : boxList) {
      fill(box.getColor());
      rect(box.x, box.y, box.w, box.h);
    }
  }

  // Check if a point is inside any box
  void checkPoint(float px, float py, Ingredient ingredient) {
    boolean anyHit = false; // To track if any box is hit
    for (Box box : boxList) {
      if (box.isInside(px, py)) {
        box.setColor(color(255, 0, 0)); 
        ingredient.getWavSound().play();
        anyHit = true;
      } else {
        box.resetColor(); // Reset to default color if the point is outside
      }
    }
  }
}
