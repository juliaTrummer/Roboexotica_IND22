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

  boxes = new Boxes();
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

Ingredient getObject(int id) {
  if (id <= 3) {
    return getObject(alcoholList, id);
  } else if (id > 3 && id <= 7) {
    return getObject(juiceList, id);
  } else if (id > 7 && id <= 11) {
    return getObject(sirupList, id);
  } else {
    return getObject(garnishList, id);
  }
}

Ingredient getObject(ArrayList<Ingredient> ingredients, int id){
  for(Ingredient ingredient : ingredients){
    if(ingredient.getId()==id){
      return ingredient;
    }
  }
  return null;
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

// Called when a new object becomes visible
void addTuioObject(TuioObject tobj) {
  println("New object added: ID " + tobj.getSymbolID() + ", Session " + tobj.getSessionID());
}

// Called when an object moves
void updateTuioObject(TuioObject tobj) {
  println("Object updated: ID " + tobj.getSymbolID() + ", New Position (" +
    tobj.getScreenX(width) + ", " + tobj.getScreenY(height) + ")");

  float tuioX = tobj.getScreenX(width); // Replace with TUIO input's x-coordinate
  float tuioY = tobj.getScreenY(height); // Replace with TUIO input's y-coordinate

  boxes.checkPoint(tuioX, tuioY, getObject(tobj.getSymbolID()));
}

// Called when an object is removed
void removeTuioObject(TuioObject tobj) {
  println("Object removed: ID " + tobj.getSymbolID());
  
}

// Called when a new cursor is detected
void addTuioCursor(TuioCursor tcur) {
  println("New cursor added: Cursor ID " + tcur.getCursorID() + ", Session " + tcur.getSessionID());
}

// Called when a cursor moves
void updateTuioCursor(TuioCursor tcur) {
  println("Cursor updated: Cursor ID " + tcur.getCursorID() + ", New Position (" +
    tcur.getScreenX(width) + ", " + tcur.getScreenY(height) + ")");
}

// Called when a cursor is removed
void removeTuioCursor(TuioCursor tcur) {
  println("Cursor removed: Cursor ID " + tcur.getCursorID());
}

// Called when a new blob is detected
void addTuioBlob(TuioBlob tblb) {
  println("New blob added: Blob ID " + tblb.getSessionID());
}

// Called when a blob moves
void updateTuioBlob(TuioBlob tblb) {
  println("Blob updated: Blob ID " + tblb.getSessionID() + ", New Position (" +
    tblb.getScreenX(width) + ", " + tblb.getScreenY(height) + ")");
}

// Called when a blob is removed
void removeTuioBlob(TuioBlob tblb) {
  println("Blob removed: Blob ID " + tblb.getSessionID());
}

// Called after every TUIO frame (use to update the display)
void refresh(TuioTime frameTime) {
  // This method is called once per TUIO frame.
}
