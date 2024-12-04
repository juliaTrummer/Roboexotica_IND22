class Circle {
    float centerX, centerY; // Center of the circle
    float radius;           // Radius of the circle
    int colour;              // Current colour
    boolean hasIngredient;  // Whether the circle contains an ingredient
    int currentId;
    int initialColour;          // The ID currently in the circle

    // Constructor
    Circle(float x, float y, float r, int colour) {
        centerX = x;
        centerY = y;
        radius = r;
        this.colour = color(0,0,0);
        this.initialColour = colour;
        hasIngredient = false;
        currentId = -1; // No ID initially
    }

    void drawCircle() {
        noFill();
        stroke(initialColour);
        strokeWeight(5);
        ellipse(centerX, centerY, radius*2, radius*2);

        noStroke();
        fill(colour);
        ellipse(centerX, centerY, radius*2, radius*2);

        fill(initialColour);
        ellipse(centerX, centerY, radius/2, radius/2);
        fill(colour);
        ellipse(centerX, centerY, radius/10, radius/10);
    }

    // Check if a point is inside the circle
    boolean isInside(float x, float y) {
        float dist = dist(x, y, centerX, centerY);
        return dist <= radius;
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
}
