class Circle {
    float centerX, centerY; // Center of the circle
    float radius;           // Radius of the circle
    int colour;              // Current colour
    boolean hasIngredient;  // Whether the circle contains an ingredient
    int currentId;          // The ID currently in the circle

    // Constructor
    Circle(float x, float y, float r) {
        centerX = x;
        centerY = y;
        radius = r;
        colour = color(255); // Default white
        hasIngredient = false;
        currentId = -1; // No ID initially
    }

    // Draw the circle
    void drawCircle() {
        fill(colour);
        ellipse(centerX, centerY, radius * 2, radius * 2);
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
        colour = color(255); // Reset to default white
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
