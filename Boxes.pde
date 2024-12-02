class Boxes {
  float boxWidth = 200;
  float boxHeight = 200;
  float spacing = 20;
  ArrayList<Box> boxList;

  Boxes(PApplet applet) {
    boxList = new ArrayList<Box>();
    float totalWidth = (4 * boxWidth) + ((4 - 1) * spacing);
    float startX = (applet.width - totalWidth) / 2;
    float centerY = applet.height / 2;

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

void ingredientsInBox(int id, float coordinateX, float coordinateY) {
  for (Box box : boxList) {
    // Check if the box already contains the given ID
    if (box.getCurrentId() == id) {
      // The ID is already in this box, ensure the box stays active
      if (box.isInside(coordinateX, coordinateY)) {
        box.setColor(100); // Ensure it's highlighted
      } else {
        // If the ID moves out, clear the ingredient from this box
        box.setHasIngredient(false, -1);
        box.resetColor();
      }
    } else if (!box.getHasIngredient() && box.isInside(coordinateX, coordinateY)) {
      // If the box is empty and the ID is inside
      box.setColor(100);
      box.setHasIngredient(true, id);
    }
  }
}
}
