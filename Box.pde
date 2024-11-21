class Boxes {
  float x, y, w, h;
  float boxWidth = 200;   
  float boxHeight = 200; 
  float spacing = 20; 

  Boxes() {
    float totalWidth = (4 * boxWidth) + ((4 - 1) * spacing);
    float startX = (width - totalWidth) / 2; 
    float centerY = height / 2; 

    for (int i = 0; i < 4; i++) {
      x = startX + i * (boxWidth + spacing); 
      display(x, centerY - boxHeight / 2, boxWidth, boxHeight);
    }
  }

  void display(float x, float y, float w, float h) {
    rect(x, y, w, h);
  }
}