import oscP5.*;
import netP5.*;
import java.util.ArrayList;
import ddf.minim.*;

import java.util.HashSet;
import java.util.Set;
import java.util.regex.*;

OscP5 oscP5;
NetAddress myBroadcastLocation;
NetAddress remoteLocation;

Circles circles;
Shaker shaker;
boolean cocktailShaken;

ArrayList<Ingredient> alcoholList, juiceList, sirupList, garnishList;
Minim minim;
SoundManager soundManager;

boolean stepOne = true;
boolean stepTwo, stepThree = false;

SecondaryWindow secondWindow;

Set<Integer> activeIds = new HashSet<>();
Set<Integer> currentFrameIds = new HashSet<>();
HashMap<Integer, Long> idLastUpdateTime = new HashMap<>();
final long TIMEOUT_DURATION = 5000;

int interval = 1000;
int lastSendTime = 0;

long lastShakerUpdateTime = 0; // Last time the shaker's position was updated
long shakerRemovalDelay = 2000; // 2 seconds delay (in milliseconds)
boolean displayShakerInfoText = false;

void setup() {
  size(1900, 1080);
  oscP5 = new OscP5(this, 5555);
  remoteLocation = new NetAddress("192.168.1.12", 5555);

  circles = new Circles(this);
  minim = new Minim(this);
  soundManager = new SoundManager();
  shaker = new Shaker(width - 200, 200, 150, new Sound(minim, "data/sounds/shaker.mp3"));

  secondWindow = new SecondaryWindow(loadImage("data/IntroScreen.jpeg"));

  createAlcoholicList();
  createJuiceList();
  createSirupList();
  createGarnishList();

  lastShakerUpdateTime = millis();
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

  // Send OSC message periodically
  if (millis() - lastSendTime > interval) {
    //sendOscMessage();
    //sendOscMessage1();
    //sendOscMessage2();
    //sendOscMessage3();
    sendOscMessage5();
    lastSendTime = millis();
  }
  checkShakerRemoval();
}

void checkShakerRemoval() {
  long currentTime = millis();
  if (currentTime - lastShakerUpdateTime > shakerRemovalDelay) {
    shaker.getSound().play();
  }
}

void oscEvent(OscMessage msg) {
  if (msg.checkTypetag("isfff")) {
    String label = msg.get(1).stringValue();
    int id = extractIntFromLabel(label);
    float x = msg.get(2).floatValue();
    float y = msg.get(3).floatValue();

    if (id == -1) {
      println("Invalid ID extracted from label: " + label);
      return;
    }

    if (id == 16) {
      lastShakerUpdateTime = millis();
      if (!shaker.isInside(x, y)) {
        displayShakerInfoText = true;    
     }
      return;
    }

    // Check if the ID is new or already active
    if (!activeIds.contains(id)) {
      // New ID, handle as a new addition
      activeIds.add(id);
      handleObjectUpdate(id, x, y); // Add sound and process the update
    } else {
      // Existing ID, just update its position and sound if necessary
      handleObjectUpdate(id, x, y);
    }

    // Check for removed items (IDs that were active but no longer in any circle)
    Set<Integer> removedIds = new HashSet<>(activeIds); // Start with all active IDs
    for (Circle circle : circles.circleList) {
      if (circle.getCurrentId() != -1) {
        removedIds.remove(circle.getCurrentId()); // Remove IDs still in the circles
      }
    }
    // Remove sounds and reset circles for removed IDs
    for (int removedId : removedIds) {
      handleObjectRemoval(removedId); // ID is no longer present, so handle removal
      activeIds.remove(removedId); // Remove from active IDs
    }
  }
}

void handleObjectUpdate(int id, float x, float y) {
  // Map x and y coordinates to screen dimensions
  float screenX = x;
  float screenY = y;

  for (Circle circle : circles.circleList) {
    // If the circle already contains this ID
    if (circle.getCurrentId() == id) {

      // If the ID moved out of the circle, reset the circle
      if (!circle.isInside(screenX, screenY)) {
        // ID moved out of the circle
        circle.setHasIngredient(false, -1);
        circle.resetColour();
        soundManager.removeSound(id); // Stop the sound for this ID
      }
    } else if (!circle.getHasIngredient() && circle.isInside(screenX, screenY)) {
      // The circle does not yet contain an ingredient, and the ID is inside
      if (isValidIdForCircle(circle, id)) {
        circle.setColour(color(0, 255, 0, 70)); // Valid ID color
        circle.setHasIngredient(true, id);
        circle.setCurrentId(id); // Link the circle with the current ID
        // Retrieve the ingredient and play its sound
        Ingredient ingredient = getIngredientById(id);
        if (ingredient != null) {
          soundManager.addSound(id, ingredient.getSound()); // Play sound for this ID
          soundManager.start();
          //println("Sound added and playing for ID: " + id);
        } else {
          //println("Ingredient not found for ID: " + id);
        }
      } else {
        // Invalid ID for this circle
        circle.setColour(color(255, 0, 0, 70)); // Invalid ID color
      }
    }
  }
}

void handleObjectRemoval(int id) {
  //println("Object removed: ID " + id);
  for (Circle circle : circles.circleList) {
    if (circle.getCurrentId() == id) {
      // Clear the circle and reset its color
      circle.setHasIngredient(false, -1);
      circle.resetColour(); // Reset to the initial color

      Ingredient ingredient = getIngredientById(id);
      if (ingredient != null) {
        soundManager.removeSound(id); // Stop the sound
      }
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
  int index = circles.circleList.indexOf(circle);
  if (index == 0 && id >= 0 && id <= 3) return true; // First circle: IDs 0-3
  if (index == 1 && id >= 4 && id <= 7) return true; // Second circle: IDs 4-7
  if (index == 2 && id >= 8 && id <= 11) return true; // Third circle: IDs 8-11
  if (index == 3 && id >= 12 && id <= 15) return true; // Fourth circle: IDs 12-15
  return false;
}

void drawMainScreen() {
  background(0);
  fill(255);
  circles.drawCircles();
  shaker.drawShaker();
  soundManager.updatePosition();
  if(displayShakerInfoText){
    fill(255, 0, 0); // Red text color
    textSize(24);
    text("Place Shaker back to where it belongs!", 20, 40); // Draw message at the top-left
  }
}

void drawWaitingScreen() {
  background(0);
}

int extractIntFromLabel(String label) {
  Pattern pattern = Pattern.compile("\\d+");
  Matcher matcher = pattern.matcher(label);
  if (matcher.find()) {
    return Integer.parseInt(matcher.group());
  } else {
    println("No digits found in label: " + label);
    return -1;
  }
}

void sendOscMessage() {
  OscMessage msg = new OscMessage("");
  msg.add(12345);
  msg.add("5");
  msg.add(395.0);
  msg.add(690.0);
  msg.add(0.0);
  oscP5.send(msg, remoteLocation);
}

void sendOscMessage1() {
  OscMessage msg = new OscMessage("");
  msg.add(12345);
  msg.add("6");
  msg.add(765.0);
  msg.add(690.0);
  msg.add(0.0);
  oscP5.send(msg, remoteLocation);
}

void sendOscMessage2() {
  OscMessage msg = new OscMessage("");
  msg.add(12345);
  msg.add("8");
  msg.add(1135.0);
  msg.add(690.0);
  msg.add(0.0);
  oscP5.send(msg, remoteLocation);
}


void sendOscMessage3() {
  OscMessage msg = new OscMessage("");
  msg.add(12345);
  msg.add("10");
  msg.add(1505.0);
  msg.add(690.0);
  msg.add(0.0);
  oscP5.send(msg, remoteLocation);
}

void sendOscMessage4() {
  OscMessage msg = new OscMessage("");
  msg.add(12345);
  msg.add("13");
  msg.add(1505.0);
  msg.add(690.0);
  msg.add(0.0);
  oscP5.send(msg, remoteLocation);
}

void sendOscMessage5() {
  OscMessage msg = new OscMessage("");
  msg.add(12345);
  msg.add("16");
  msg.add(1400.0);
  msg.add(200.0);
  msg.add(0.0);
  oscP5.send(msg, remoteLocation);
}
