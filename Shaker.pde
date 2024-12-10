class Shaker {
    float x, y, radius;
    int currentId = -1; // -1 means no ID is currently on it.
    int colour = 255; // Default color (white)
    Sound sound; 

    Shaker(float x, float y, float radius, Sound sound) {
        this.x = x;
        this.y = y;
        this.radius = radius;
        this.sound = sound;
    }

    void drawShaker() {
        fill(30, 255, 255, 64);
        stroke(colour);
        ellipse(x, y, radius * 2, radius * 2);
    }

    void setColor(int newColour) {
        this.colour = newColour;
    }

    boolean isInside(float tx, float ty) {
        float dx = tx - x;
        float dy = ty - y;
        return (dx * dx + dy * dy <= radius * radius); // Check distance from center
    }

    Sound getSound(){
        return this.sound;
    }
}
