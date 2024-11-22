class Boxes {
  float boxWidth = 200;   
  float boxHeight = 200; 
  float spacing = 20; 
  ArrayList<Box> boxList;

  Boxes() {
    boxList = new ArrayList<Box>();
    float totalWidth = (4 * boxWidth) + ((4 - 1) * spacing);
    float startX = (width - totalWidth) / 2; 
    float centerY = height / 2; 
    
    for (int i = 0; i < 4; i++) {
      float x = startX + i * (boxWidth + spacing); 
      boxList.add(new Box(startX, centerY, boxWidth, boxHeight));
    }
  }

  void drawBoxes(){
    for(Box box : boxList){
      display(box.getX(), box.getY(), box.getW(), box.getH());
    }
  }

  void display(float x, float y, float w, float h) {
    rect(x, y, w, h);
  }
}