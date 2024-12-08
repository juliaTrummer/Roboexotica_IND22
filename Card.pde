class Card {
  PImage img;
  PApplet parent;  // Reference to the PApplet instance

  Card(PImage img, PApplet parent) {
    this.img = img;
    this.parent = parent;  // Assign the PApplet instance
  }

  void drawPhoto() {
    parent.background(0);

    // Scale Polaroid frame dimensions based on the screen size
    float frameWidth = parent.width * 0.25;  // Reduce to 25% of screen width
    float frameHeight = frameWidth * 1.25;  // Maintain Polaroid aspect ratio

    float photoWidth = frameWidth * 0.8;  // Photo takes up 80% of frame width
    float photoHeight = photoWidth;  // Keep the photo square

    // Center the frame
    float frameX = (parent.width - frameWidth) / 2;
    float frameY = (parent.height - frameHeight) / 2;

    // Draw the Polaroid frame
    parent.fill(255);
    parent.noStroke();
    parent.rect(frameX, frameY, frameWidth, frameHeight);

    // Draw the photo area inside the Polaroid frame
    parent.fill(200);
    float photoX = frameX + frameWidth * 0.1;  // Adjust margin inside the frame
    float photoY = frameY + frameWidth * 0.1;
    parent.rect(photoX, photoY, photoWidth, photoHeight);

    // Draw the photo if loaded
    if (img != null) {
      img.resize((int)photoWidth, (int)photoHeight);  // Resize the image to fit the photo area
      parent.image(img, photoX, photoY);  // Display the image
    }

    // Add some text below the photo (optional, like a Polaroid caption)
    parent.fill(50);  // Dark gray text
    parent.textSize(frameWidth * 0.05);  // Text size scales with frame width
    parent.textAlign(parent.CENTER, parent.CENTER);
    parent.text("My McMoment...XD", frameX + frameWidth / 2, frameY + frameHeight - frameWidth * 0.1);
  }
}
