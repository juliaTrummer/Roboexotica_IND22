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
        noFill();
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

    void setId(int id) {
        this.currentId = id;
        setColor(color(0, 255, 0)); // Green when ID is present
        sound.stop();
    }

    void clearId() {
        this.currentId = -1;
        setColor(color(255, 0, 0)); // Red when no ID
        sound.play();
    }
}
