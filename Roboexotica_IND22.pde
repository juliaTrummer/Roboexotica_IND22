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

SoundManager soundManager;

void setup() {
  size(1200, 800);

  boxes = new Boxes(this);
  minim = new Minim(this);
  soundManager = new SoundManager();

  createAlcoholicList();
  createJuiceList();
  createSirupList();
  createGarnishList();

  tuioClient = new TuioProcessing(this);
  println("TUIO Client initialized. Listening for events...");
}

void createAlcoholicList () {
  alcoholList = new ArrayList();
  alcoholList.add(new Ingredient(0, "Whiskey", 40, 10, 10, new int[] {255, 0, 0}, new WavSound(minim, "data/sounds/b_whiskey.mp3")));
  alcoholList.add(new Ingredient(1, "Vodka", 40, 10, 10, new int[] {255, 0, 0}, new WavSound(minim, "data/sounds/b_vodka.mp3")));
  alcoholList.add(new Ingredient(2, "Gin", 40, 10, 10, new int[] {255, 0, 0}, new WavSound(minim, "data/sounds/b_gin.mp3")));
  alcoholList.add(new Ingredient(3, "Rum", 40, 10, 10, new int[] {255, 0, 0}, new WavSound(minim, "data/sounds/b_rum.mp3")));
}

void createJuiceList() {
  juiceList = new ArrayList();
  juiceList.add(new Ingredient(4, "Cranberry", 40, 10, 10, new int[] {255, 0, 0}, new WavSound(minim, "data/sounds/f_cranberry.mp3")));
  juiceList.add(new Ingredient(5, "Pineapple", 40, 10, 10, new int[] {255, 0, 0}, new WavSound(minim, "data/sounds/f_pineapple.mp3")));
  juiceList.add(new Ingredient(6, "Orange", 40, 10, 10, new int[] {255, 0, 0}, new WavSound(minim, "data/sounds/f_orange.mp3")));
  juiceList.add(new Ingredient(7, "Gingerale", 40, 10, 10, new int[] {255, 0, 0}, new WavSound(minim, "data/sounds/f_ginger_ale.mp3")));
}

void createSirupList() {
  sirupList = new ArrayList();
  sirupList.add(new Ingredient(8, "Coconut", 40, 10, 10, new int[] {255, 0, 0}, new WavSound(minim, "data/sounds/s_coconut.mp3")));
  sirupList.add(new Ingredient(9, "Grenadine", 40, 10, 10, new int[] {255, 0, 0}, new WavSound(minim, "data/sounds/s_grenadine.mp3")));
  sirupList.add(new Ingredient(10, "Blue Curacau", 40, 10, 10, new int[] {255, 0, 0}, new WavSound(minim, "data/sounds/s_blue_curacao.mp3")));
  sirupList.add(new Ingredient(11, "Elderflower", 40, 10, 10, new int[] {255, 0, 0}, new WavSound(minim, "data/sounds/s_elderflower.mp3")));
}

void createGarnishList() {
  garnishList = new ArrayList();
  garnishList.add(new Ingredient(12, "Lime Slices", 40, 10, 10, new int[] {255, 0, 0}, new WavSound(minim, "data/sounds/t_lime_slices.mp3")));
  garnishList.add(new Ingredient(13, "Mint", 40, 10, 10, new int[] {255, 0, 0}, new WavSound(minim, "data/sounds/t_mint.mp3")));
  garnishList.add(new Ingredient(14, "Olives", 40, 10, 10, new int[] {255, 0, 0}, new WavSound(minim, "data/sounds/t_olives.mp3")));
  garnishList.add(new Ingredient(15, "Cocktail Cherries", 40, 10, 10, new int[] {255, 0, 0}, new WavSound(minim, "data/sounds/t_cocktail_cherries.mp3")));
}

void draw() {

  background(0); // Clear the screen
  fill(255);
  boxes.drawBoxes();
  soundManager.updatePosition();

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
          Ingredient ingredient = getIngredientById(id);
          if (ingredient != null) {
            WavSound sound = ingredient.getWavSound();
            soundManager.addSound(id, sound);
            soundManager.start(); // Start playback if not already playing
          }
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

    boolean isInsideValidBox = false;

    for (int i = 0; i < boxes.boxList.size(); i++) {
        Box box = boxes.boxList.get(i);

        if (box.isInside(tuioX, tuioY)) {
            isInsideValidBox = true;

            if (!box.getHasIngredient() || box.getCurrentId() == id) {
                if (isValidIdForBox(i, id)) {
                    // Valid placement
                    box.setColor(color(0, 255, 0)); // Green for valid ID
                    if (!box.getHasIngredient()) {
                        box.setHasIngredient(true, id);
                        Ingredient ingredient = getIngredientById(id);
                        if (ingredient != null) {
                            soundManager.addSound(id, ingredient.getWavSound());
                            soundManager.start(); // Ensure synchronized playback
                        }
                    }
                } else {
                    // Invalid placement
                    box.setColor(color(255, 0, 0)); // Red for invalid ID
                    if (!box.getHasIngredient()) {
                        box.setHasIngredient(true, id);
                    }
                }
            }
        } else if (box.getCurrentId() == id) {
            // If the ID is moved out of this box, reset the box
            box.setHasIngredient(false, -1);
            box.resetColor();
            soundManager.removeSound(id);
        }
    }

    // If the object is not inside any box, remove its sound
    if (!isInsideValidBox) {
        soundManager.removeSound(id);
    }

    // Synchronize playback positions for all sounds
    soundManager.updatePosition();
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
      box.resetColor();
      Ingredient ingredient = getIngredientById(id);
      soundManager.removeSound(id);
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
