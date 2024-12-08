class SecondaryWindow extends PApplet {

  float speed = 2;
  float alpha = 0;
  boolean fadingIn = true;
  float titleSize = height * 1.5;
  PFont titleFont, baseFont;
  boolean intro, outro;

  PImage introScreen; 
  Card card;

  SecondaryWindow(PImage introScreen) {
    PApplet.runSketch(new String[] {"Secondary Window"}, this);
    this.titleFont = titleFont;
    this.baseFont = baseFont;
    this.intro = true;
    this.outro = false;
    this.introScreen = introScreen;
  }

  public void settings() {
    size(1900, 1080);
  }

  public void setup() {
    surface.setTitle("Secondary Window");
    background(0);
  }

  public void draw() {
    background(0);

    if (intro==true) {
      drawIntroScreen();
    }
    
    if(outro==true){
      card.drawPhoto();
    }
  }

  void changeScreen() {
    intro = false;
  }

  void setCard(PImage img) {
      this.card = new Card(img, this);  // Pass the context to the Card
      intro = false;
      outro = true;
  }

  void drawIntroScreen() {
   introScreen.resize(width, height);
   image(introScreen, 0, 0);
  }
}
