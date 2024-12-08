import TUIO.*;
import java.util.ArrayList;
import processing.sound.SoundFile;
import ddf.minim.*;

TuioProcessing tuioClient;
Circles circles;
Shaker shaker;
boolean cocktailShaken;

ArrayList<Ingredient> alcoholList, juiceList, sirupList, garnishList;
Minim minim;
SoundManager soundManager;

boolean stepOne = true;
boolean stepTwo, stepThree = false;

SecondaryWindow secondWindow;

void setup() {
  fullScreen();

  circles = new Circles(this);
  minim = new Minim(this);
  soundManager = new SoundManager();
  shaker = new Shaker(width - 200, 200, 150, new Sound (minim, "data/sounds/shake_Sound.mp3"));

  secondWindow = new SecondaryWindow(loadImage("data/IntroScreen.jpeg"));

  createAlcoholicList();
  createJuiceList();
  createSirupList();
  createGarnishList();

  tuioClient = new TuioProcessing(this);
  println("TUIO Client initialized. Listening for events...");
}

void createAlcoholicList () {
  alcoholList = new ArrayList();
  alcoholList.add(new Ingredient(0, "Whiskey", 40, 10, 10, new int[] {255, 0, 0}, new Sound(minim, "data/sounds/b_whiskey.mp3")));
  alcoholList.add(new Ingredient(1, "Vodka", 40, 10, 10, new int[] {255, 0, 0}, new Sound(minim, "data/sounds/b_vodka.mp3")));
  alcoholList.add(new Ingredient(2, "Gin", 40, 10, 10, new int[] {255, 0, 0}, new Sound(minim, "data/sounds/b_gin.mp3")));
  alcoholList.add(new Ingredient(3, "Rum", 40, 10, 10, new int[] {255, 0, 0}, new Sound(minim, "data/sounds/b_rum.mp3")));
}

void createJuiceList() {
  juiceList = new ArrayList();
  juiceList.add(new Ingredient(4, "Cranberry", 40, 10, 10, new int[] {255, 0, 0}, new Sound(minim, "data/sounds/f_cranberry.mp3")));
  juiceList.add(new Ingredient(5, "Pineapple", 40, 10, 10, new int[] {255, 0, 0}, new Sound(minim, "data/sounds/f_pineapple.mp3")));
  juiceList.add(new Ingredient(6, "Orange", 40, 10, 10, new int[] {255, 0, 0}, new Sound(minim, "data/sounds/f_orange.mp3")));
  juiceList.add(new Ingredient(7, "Gingerale", 40, 10, 10, new int[] {255, 0, 0}, new Sound(minim, "data/sounds/f_ginger_ale.mp3")));
}

void createSirupList() {
  sirupList = new ArrayList();
  sirupList.add(new Ingredient(8, "Coconut", 40, 10, 10, new int[] {255, 0, 0}, new Sound(minim, "data/sounds/s_coconut.mp3")));
  sirupList.add(new Ingredient(9, "Grenadine", 40, 10, 10, new int[] {255, 0, 0}, new Sound(minim, "data/sounds/s_grenadine.mp3")));
  sirupList.add(new Ingredient(10, "Blue Curacau", 40, 10, 10, new int[] {255, 0, 0}, new Sound(minim, "data/sounds/s_blue_curacao.mp3")));
  sirupList.add(new Ingredient(11, "Elderflower", 40, 10, 10, new int[] {255, 0, 0}, new Sound(minim, "data/sounds/s_elderflower.mp3")));
}

void createGarnishList() {
  garnishList = new ArrayList();
  garnishList.add(new Ingredient(12, "Lime Slices", 40, 10, 10, new int[] {255, 0, 0}, new Sound(minim, "data/sounds/t_lime_slices.mp3")));
  garnishList.add(new Ingredient(13, "Mint", 40, 10, 10, new int[] {255, 0, 0}, new Sound(minim, "data/sounds/t_mint.mp3")));
  garnishList.add(new Ingredient(14, "Olives", 40, 10, 10, new int[] {255, 0, 0}, new Sound(minim, "data/sounds/t_olives.mp3")));
  garnishList.add(new Ingredient(15, "Cocktail Cherries", 40, 10, 10, new int[] {255, 0, 0}, new Sound(minim, "data/sounds/t_cocktail_cherries.mp3")));
}

void draw() {

  if(stepOne == true){
    drawMainScreen();
  }else if(stepTwo == true){
    drwaWaitingScreen();
  }else if(stepThree == true){
    //drawOutroScreen();
  }

  // Display all active TUIO objects
  for (TuioObject tobj : tuioClient.getTuioObjectList()) {
    fill(0, 255, 0); // Green for objects
    noStroke();
    float x = tobj.getScreenX(width);
    float y = tobj.getScreenY(height);
    ellipse(x, y, 10, 10);
    fill(255);
    textAlign(CENTER);
    text("ID: " + tobj.getSymbolID(), x, y - 30); // Display object ID
    text("Angle: " + degrees(tobj.getAngle()), x, y + 30); // Display angle
  }
}

void addTuioObject(TuioObject tobj) {
  println("New object added: ID " + tobj.getSymbolID() + ", Session " + tobj.getSessionID());

  int id = tobj.getSymbolID();
  float tuioX = tobj.getScreenX(width);
  float tuioY = tobj.getScreenY(height);
  
  for (Circle circle : circles.circleList) {
    if (circle.isInside(tuioX, tuioY)&&stepOne==true) {
      if (circle.getHasIngredient() == false || circle.getCurrentId() == id) {
        if (isValidIdForCircle(circle, id)) {
          circle.setColour(color(0, 255, 0, 70)); // Green for valid ID
          circle.setHasIngredient(true, id);
          secondWindow.changeScreen();
          Ingredient ingredient = getIngredientById(id);
          if (ingredient != null) {
            soundManager.addSound(id, ingredient.getSound());
            soundManager.start(); // Ensure synchronized playback
          }
        } else {
          circle.setColour(color(255, 0, 0, 70)); // Red for invalid ID
          circle.setHasIngredient(true, id);
        }
      }
    }
  }
}

void updateTuioObject(TuioObject tobj) {
  println("Object updated: ID " + tobj.getSymbolID() + ", New Position (" +
    tobj.getScreenX(width) + ", " + tobj.getScreenY(height) + ")");

  int id = tobj.getSymbolID();
  float tuioX = tobj.getScreenX(width);
  float tuioY = tobj.getScreenY(height);

  for (Circle circle : circles.circleList) {
    if (circle.isInside(tuioX, tuioY)&&stepOne==true) {
      if (!circle.getHasIngredient() || circle.getCurrentId() == id) {
        if (isValidIdForCircle(circle, id)) {
          circle.setColour(color(0, 255, 0, 70)); // Green for valid ID
          circle.setHasIngredient(true, id);
          Ingredient ingredient = getIngredientById(id);
          if (ingredient != null) {
            soundManager.addSound(id, ingredient.getSound());
            soundManager.start(); // Ensure synchronized playback
          }
        } else {
          circle.setColour(color(255, 0, 0, 70)); // Red for invalid ID
          circle.setHasIngredient(true, id);
        }
      }
    } else if (circle.getCurrentId() == id) {
      circle.setHasIngredient(false, -1); // Clear the ingredient
      circle.resetColour(); // Reset color to default
      soundManager.removeSound(id);
    }
  }
}

void removeTuioObject(TuioObject tobj) {
  println("Object removed: ID " + tobj.getSymbolID());

  int id = tobj.getSymbolID();
  if (tobj.getSymbolID()==16) {
    shaker.clearId();
    soundManager.stop();
    stepTwo = true;
    stepOne = false;

    secondWindow.setCard(loadImage("data/Animation.jpg"));

    //create qr 
    //repeat
  }

  for (Circle circle : circles.circleList) {
    if (circle.getCurrentId() == id) {
      circle.setHasIngredient(false, -1); // Clear ingredient
      circle.resetColour(); // Reset color
      soundManager.removeSound(id);
    }
  }
}

// Called after every TUIO frame (use to update the display)
void refresh(TuioTime frameTime) {
  // This method is called once per TUIO frame.
}

Ingredient getIngredientById(int id) {
  if (id >= 0 && id <= 3) {
    return getIngredientFromList(alcoholList, id);
  } else if (id >= 4 && id <= 7) {
    return getIngredientFromList(juiceList, id);
  } else if (id >= 8 && id <= 11) {
    return getIngredientFromList(sirupList, id);
  } else if (id >= 12 && id <= 15) {
    return getIngredientFromList(garnishList, id);
  }
  return null;
}

Ingredient getIngredientFromList(ArrayList<Ingredient> list, int id) {
  for (Ingredient ingredient : list) {
    if (ingredient.getId() == id) {
      return ingredient;
    }
  }
  return null;
}

boolean isValidIdForCircle(Circle circle, int id) {
  int index = circles.circleList.indexOf(circle); // Get circle index in the list
  if (index == 0 && id >= 0 && id <= 3) return true;      // First circle: IDs 0-3
  if (index == 1 && id >= 4 && id <= 7) return true;      // Second circle: IDs 4-7
  if (index == 2 && id >= 8 && id <= 11) return true;     // Third circle: IDs 8-11
  if (index == 3 && id >= 12 && id <= 15) return true;    // Fourth circle: IDs 12-15
  return false;
}

void drawMainScreen() {
  background(0);
  fill(255);
  circles.drawCircles();
  shaker.drawShaker();
  soundManager.updatePosition();
}

void drwaWaitingScreen(){
  background(0);
  
}