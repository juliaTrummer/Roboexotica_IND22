class Circles {
    float radius = 175; // Radius of each circle
    float spacing = 20; // Spacing between circles
    ArrayList<Circle> circleList;

    Circles(PApplet applet) {
        circleList = new ArrayList<Circle>();
        float totalWidth = (4 * (radius * 2)) + ((4 - 1) * spacing);
        float startX = (applet.width - totalWidth) / 2 + radius;
        float centerY = applet.height / 2;

        for (int i = 0; i < 4; i++) {
            float centerX = startX + i * ((radius * 2) + spacing);
            Circle circle = new Circle(centerX, centerY, radius);
            circleList.add(circle);
        }
    }

    // Draw all circles
    void drawCircles() {
        for (Circle circle : circleList) {
            circle.drawCircle();
        }
    }

    // Check if an ingredient is inside a circle
    void ingredientsInCircle(int id, float coordinateX, float coordinateY) {
        for (Circle circle : circleList) {
            // Check if the circle already contains the given ID
            if (circle.getCurrentId() == id) {
                // The ID is already in this circle, ensure the circle stays active
                if (circle.isInside(coordinateX, coordinateY)) {
                    circle.setColour(color(100, 100, 255)); // Ensure it's highlighted
                } else {
                    // If the ID moves out, clear the ingredient from this circle
                    circle.setHasIngredient(false, -1);
                    circle.resetColour();
                }
            } else if (!circle.getHasIngredient() && circle.isInside(coordinateX, coordinateY)) {
                // If the circle is empty and the ID is inside
                circle.setColour(color(100, 255, 100)); // Set a highlight color
                circle.setHasIngredient(true, id);
            }
        }
    }
}
