import oscP5.*;
import netP5.*;
import java.util.ArrayList;
import processing.sound.SoundFile;
import ddf.minim.*;

OscP5 oscP5;
NetAddress myBroadcastLocation;

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

  oscP5 = new OscP5(this, 8000); // Listen on port 8000
  println("OSC Listener initialized. Waiting for messages...");

  circles = new Circles(this);
  minim = new Minim(this);
  soundManager = new SoundManager();
  shaker = new Shaker(width - 200, 200, 150, new Sound(minim, "data/sounds/shake_Sound.mp3"));

  secondWindow = new SecondaryWindow(loadImage("data/IntroScreen.jpeg"));

  createAlcoholicList();
  createJuiceList();
  createSirupList();
  createGarnishList();
}

void createAlcoholicList() {
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
  sirupList.add(new Ingredient(10, "Blue Curacao", 40, 10, 10, new int[] {255, 0, 0}, new Sound(minim, "data/sounds/s_blue_curacao.mp3")));
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
  if (stepOne) {
    drawMainScreen();
  } else if (stepTwo) {
    drawWaitingScreen();
  } else if (stepThree) {
    // Draw outro screen
  }
}

void oscEvent(OscMessage message) {
  if (message.checkAddrPattern("/tuio/object")) {
    String label = message.get(1).stringValue(); // Receive label as string
    int id = parseId(label); // Parse the label to extract integer ID
    float x = message.get(2).floatValue();
    float y = message.get(3).floatValue();
    float z = message.get(4).floatValue();
    boolean isSet = message.get(5).intValue() == 1;

    if (isSet) {
      handleSetObject(id, x, y, z);
    } else {
      handleRemoveObject(id);
    }
  }
}

int parseId(String label) {
  try {
    return Integer.parseInt(label); // Try to convert to an integer
  } catch (NumberFormatException e) {
    println("Invalid ID in label: " + label);
    return -1; // Return -1 for invalid IDs
  }
}

void handleSetObject(int id, float x, float y, float z) {
  if (id == -1) return; // Skip processing if ID is invalid

  for (Circle circle : circles.circleList) {
    if (circle.isInside(x, y) && stepOne) {
      if (!circle.getHasIngredient() || circle.getCurrentId() == id) {
        if (isValidIdForCircle(circle, id)) {
          circle.setColour(color(0, 255, 0, 70)); // Green for valid
          circle.setHasIngredient(true, id);
          secondWindow.changeScreen();
          Ingredient ingredient = getIngredientById(id);
          if (ingredient != null) {
            soundManager.addSound(id, ingredient.getSound());
            soundManager.start();
          }
        } else {
          circle.setColour(color(255, 0, 0, 70)); // Red for invalid
          circle.setHasIngredient(true, id);
        }
      }
    }
  }
}

void handleRemoveObject(int id) {
  if (id == -1) return; // Skip processing if ID is invalid

  for (Circle circle : circles.circleList) {
    if (circle.getCurrentId() == id) {
      circle.setHasIngredient(false, -1);
      circle.resetColour();
      soundManager.removeSound(id);
    }
  }
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

void drawWaitingScreen(){
  background(0);
  
}