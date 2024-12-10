class Circles {
  float radius = 175; // Radius of each circle
  float spacing = 20; // Spacing between circles
  ArrayList<Circle> circleList;

  Circles(PApplet applet) {
    circleList = new ArrayList<Circle>();
    float totalWidth = (4 * (radius * 2)) + ((4 - 1) * spacing);
    float startX = (applet.width - totalWidth) / 2 + radius;
    float centerY = applet.height / 2 + 150;

    for (int i = 0; i < 4; i++) {
      float centerX = startX + i * ((radius * 2) + spacing);
      Circle circle = new Circle(centerX, centerY, radius, getColour(i), getCircleName(i));
      circleList.add(circle);
    }
  }

  // Draw all circles
  void drawCircles() {
    for (Circle circle : circleList) {
      circle.drawCircle();
    }
  }

  int getColour(int state) {
    switch (state) {
    case 0:
      return color(126, 241, 75); // Green
    case 1:
      return color(242, 19, 164); // Pink
    case 2:
      return color(18, 25, 191); // Blue
    case 3:
      return color(242, 185, 10); // Yellow
    default:
      return color(255); // Default color (white)
    }
  }


void ingredientsInCircle(int id, float coordinateX, float coordinateY) {
    for (Circle circle : circleList) {
        boolean isInside = circle.isInside(coordinateX, coordinateY);

        if (circle.getCurrentId() == id) {
            // Object remains in the same circle
            if (isInside) {
                // Do nothing, maintain the current state
                return;
            } else {
                // Object moves out of the circle
                circle.setHasIngredient(false, -1);
                circle.resetColour();
            }
        } else if (!circle.getHasIngredient() && isInside) {
            // Object enters an empty circle
            circle.setColour(color(100, 255, 100)); // Green highlight for valid
            circle.setHasIngredient(true, id);
        }
    }
}


  String getCircleName(int state) {
    switch (state) {
    case 0:
      return "Base";
    case 1:
      return "Sirup";
    case 2:
      return "Juice";
    case 3:
      return "Garnish";
    default:
      return "";
    }
  }
}

