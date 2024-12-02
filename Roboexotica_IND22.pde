import TUIO.*;
import java.util.ArrayList;
import processing.sound.SoundFile;
import ddf.minim.*;

TuioProcessing tuioClient;
Boxes boxes;
ArrayList<Ingredient> alcoholList;
ArrayList<Ingredient> juiceList;
ArrayList<Ingredient> sirupList;
ArrayList<Ingredient> garnishList;
Minim minim;

void setup() {
  size(1200, 800);

  boxes = new Boxes(this);
  minim = new Minim(this);

  createAlcoholicList();
  createJuiceList();
  createSirupList();
  createGarnishList();

  tuioClient = new TuioProcessing(this);
  println("TUIO Client initialized. Listening for events...");
}

void createAlcoholicList () {
  alcoholList = new ArrayList();
  alcoholList.add(new Ingredient(0, "Whiskey", 40, 10, 10, new int[] {255, 0, 0}, new WavSound(minim,"data/sounds/cranberry.mp3")));
  alcoholList.add(new Ingredient(1, "Vodka", 40, 10, 10, new int[] {255, 0, 0}, new WavSound(minim,"data/sounds/vodka.mp3")));
  alcoholList.add(new Ingredient(2, "Gin", 40, 10, 10, new int[] {255, 0, 0}, new WavSound(minim,"data/sounds/gin.mp3")));
  alcoholList.add(new Ingredient(3, "Rum", 40, 10, 10, new int[] {255, 0, 0}, new WavSound(minim,"data/sounds/rum.mp3")));
}

void createJuiceList() {
  juiceList = new ArrayList();
  juiceList.add(new Ingredient(4, "Cranberry", 40, 10, 10, new int[] {255, 0, 0}, new WavSound(minim,"data/sounds/cranberry.mp3")));
  juiceList.add(new Ingredient(5, "Pineapple", 40, 10, 10, new int[] {255, 0, 0}, new WavSound(minim,"data/sounds/cranberry.mp3")));
  juiceList.add(new Ingredient(6, "Orange", 40, 10, 10, new int[] {255, 0, 0}, new WavSound(minim,"data/sounds/cranberry.mp3")));
  juiceList.add(new Ingredient(7, "Gingerale", 40, 10, 10, new int[] {255, 0, 0}, new WavSound(minim,"data/sounds/cranberry.mp3")));
}

void createSirupList() {
  sirupList = new ArrayList();
  sirupList.add(new Ingredient(8, "Coconut", 40, 10, 10, new int[] {255, 0, 0}, new WavSound(minim,"data/sounds/cranberry.mp3")));
  sirupList.add(new Ingredient(9, "Grenadine", 40, 10, 10, new int[] {255, 0, 0}, new WavSound(minim,"data/sounds/cranberry.mp3")));
  sirupList.add(new Ingredient(10, "Blue Curacau", 40, 10, 10, new int[] {255, 0, 0}, new WavSound(minim,"data/sounds/cranberry.mp3")));
  sirupList.add(new Ingredient(11, "Elderflower", 40, 10, 10, new int[] {255, 0, 0}, new WavSound(minim,"data/sounds/cranberry.mp3")));
}

void createGarnishList() {
  garnishList = new ArrayList();
  garnishList.add(new Ingredient(12, "Coconut", 40, 10, 10, new int[] {255, 0, 0}, new WavSound(minim,"data/sounds/cranberry.mp3")));
  garnishList.add(new Ingredient(13, "Grenadine", 40, 10, 10, new int[] {255, 0, 0}, new WavSound(minim,"data/sounds/cranberry.mp3")));
  garnishList.add(new Ingredient(14, "Blue Curacau", 40, 10, 10, new int[] {255, 0, 0}, new WavSound(minim,"data/sounds/cranberry.mp3")));
  garnishList.add(new Ingredient(15, "Elderflower", 40, 10, 10, new int[] {255, 0, 0}, new WavSound(minim,"data/sounds/cranberry.mp3")));
}

void draw() {

  background(0); // Clear the screen
  fill(255);
  boxes.drawBoxes();

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

  // Display all active TUIO cursors
  for (TuioCursor tcur : tuioClient.getTuioCursorList()) {
    fill(255, 0, 0); // Red for cursors
    noStroke();
    float x = tcur.getScreenX(width);
    float y = tcur.getScreenY(height);
    ellipse(x, y, 20, 20);
    fill(255);
    textAlign(CENTER);
    text("Cursor: " + tcur.getCursorID(), x, y - 20);
  }

  // Display all active TUIO blobs
  for (TuioBlob tblb : tuioClient.getTuioBlobList()) {
    fill(0, 0, 255); // Blue for blobs
    noStroke();
    float x = tblb.getScreenX(width);
    float y = tblb.getScreenY(height);
    ellipse(x, y, 40, 40);
    fill(255);
    textAlign(CENTER);
    text("Blob: " + tblb.getSessionID(), x, y - 20);
  }
}

void addTuioObject(TuioObject tobj) {
  println("New object added: ID " + tobj.getSymbolID() + ", Session " + tobj.getSessionID());

  int id = tobj.getSymbolID();
  float tuioX = tobj.getScreenX(width);
  float tuioY = tobj.getScreenY(height);

  for (int i = 0; i < boxes.boxList.size(); i++) {
    Box box = boxes.boxList.get(i);

    if (box.isInside(tuioX, tuioY)) {
      if (!box.getHasIngredient()) {
        if (isValidIdForBox(i, id)) {
          box.setColor(color(0, 255, 0)); // Green for valid ID
          box.setHasIngredient(true, id);
        } else {
          box.setColor(color(255, 0, 0)); // Red for invalid ID
          box.setHasIngredient(true, id); // Mark box occupied even if invalid
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

  for (int i = 0; i < boxes.boxList.size(); i++) {
    Box box = boxes.boxList.get(i);

    if (box.isInside(tuioX, tuioY)) {
      if (!box.getHasIngredient() || box.getCurrentId() == id) {
        if (isValidIdForBox(i, id)) {
          box.setColor(color(0, 255, 0)); // Green for valid ID
          box.setHasIngredient(true, id);
        } else {
          box.setColor(color(255, 0, 0)); // Red for invalid ID
          box.setHasIngredient(true, id);
        }
      }
    } else if (box.getCurrentId() == id) {
      box.setHasIngredient(false, -1); // Remove ingredient if moved out
    }
  }
}

// Called when an object is removed
void removeTuioObject(TuioObject tobj) {
  println("Object removed: ID " + tobj.getSymbolID());

  int id = tobj.getSymbolID();

  for (Box box : boxes.boxList) {
    if (box.getCurrentId() == id) {
      box.setHasIngredient(false, -1); // Reset box state
      break;
    }
  }

  // Check all boxes to ensure proper color for any remaining invalid IDs
  for (int i = 0; i < boxes.boxList.size(); i++) {
    Box box = boxes.boxList.get(i);

    if (box.getHasIngredient() && !isValidIdForBox(i, box.getCurrentId())) {
      box.setColor(color(255, 0, 0)); // Highlight invalid IDs
    } else if (!box.getHasIngredient()) {
      box.resetColor(); // Reset to default if empty
    }
  }
}


// Called after every TUIO frame (use to update the display)
void refresh(TuioTime frameTime) {
  // This method is called once per TUIO frame.
}

// Helper method to validate if an ID is in the correct range for a box
boolean isValidIdForBox(int boxIndex, int id) {
  if (boxIndex == 0) return id >= 0 && id <= 3;  // First box: IDs 0-3
  if (boxIndex == 1) return id >= 4 && id <= 7;  // Second box: IDs 4-7
  if (boxIndex == 2) return id >= 8 && id <= 11; // Third box: IDs 8-11
  if (boxIndex == 3) return id >= 12 && id <= 15; // Fourth box: IDs 12-15
  return false; // Invalid for any box
}