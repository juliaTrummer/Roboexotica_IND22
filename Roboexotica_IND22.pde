import TUIO.*;

TuioProcessing tuioClient;

Boxes boxes = new Boxes(); 

void setup() {
  size(1000, 600);

  tuioClient = new TuioProcessing(this);
  println("TUIO Client initialized. Listening for events...");
}

void draw() {
  background(0); // Clear the screen

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
  chosenAlcohol(tobj.getSymbolID());
  
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

void chosenAlcohol(int drinkType){
  switch (drinkType) {
      case 0:
          println("You chose Whiskey.");
          break;
      case 1:
          println("You chose Vodka.");
          break;
      case 2:
          println("You chose Gin.");
          break;
      case 3:
          println("You chose Rum.");
          break;
      case 4:
          println("You chose Cranberry.");
          break;
      case 5:
          println("You chose Pineapple.");
          break;
      case 6:
          println("You chose Orange.");
          break;
      case 7:
          println("You chose Ginger Ale.");
          break;
      case 8:
          println("You chose Coconut Sirup.");
          break;
      case 9:
          println("You chose Grenadine.");
          break;
      case 10:
          println("You chose Blue Curacao.");
          break;
      case 11:
          println("You chose Elderflower Sirup.");
          break;
      case 12:
          println("You chose Mint.");
          break;
      case 13:
          println("You chose Lime Slices.");
          break;
      case 14:
          println("You chose Olives.");
          break;
      case 15:
          println("You chose Cocktail Cherries.");
          break;
      default:
          println("Unknown ingredient.");
  }
}