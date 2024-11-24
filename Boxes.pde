class Boxes {
  float boxWidth = 200;
  float boxHeight = 200;
  float spacing = 20;
  ArrayList<Box> boxList;
  AlcoholType currentAlcohol;

  Boxes() {

    boxList = new ArrayList<Box>();
    float totalWidth = (4 * boxWidth) + ((4 - 1) * spacing);
    float startX = (width - totalWidth) / 2;
    float centerY = height / 2;

    for (int i = 0; i < 4; i++) {
      float x = startX + i * (boxWidth + spacing);
      float y = centerY - boxHeight / 2;
      int randomColor = color(255);
      Box box = new Box(x, y, boxWidth, boxHeight, randomColor);
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
  void checkPoint(float px, float py, int id) {
    boolean anyHit = false; // To track if any box is hit
    for (Box box : boxList) {
      if (box.isInside(px, py)) {
        box.setColor(color(255, 0, 0)); // Set color to red if the point is inside
        anyHit = true;
        getIngredients(id);
      } else {
        box.resetColor(); // Reset to default color if the point is outside
      }
    }
  }

  void getIngredients(int id) {
    switch(id) {
    case 0:
      currentAlcohol = AlcoholType.WHISKEY;
      break;
    case 1:
      currentAlcohol = AlcoholType.VODKA;
      break;
    case 2:
      currentAlcohol = AlcoholType.GIN;
      break;
    case 3:
      currentAlcohol = AlcoholType.RUM;
      break;
    default:
      currentAlcohol = null; // or handle invalid ID
      break;
    }

    if (currentAlcohol != null) { 
      currentAlcohol.getMp3Sound().play();
    }
  }
}
