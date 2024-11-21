import TUIO.*;

TuioProcessing tuioClient;

Box[] boxes = new Box[4];
float boxWidth = 200;   
float boxHeight = 200; 
float spacing = 20; 

void setup() {
  size(1000, 600);

  tuioClient = new TuioProcessing(this);
  println("TUIO Client initialized. Listening for events...");


  float totalWidth = (boxes.length * boxWidth) + ((boxes.length - 1) * spacing);
  float startX = (width - totalWidth) / 2; 
  float centerY = height / 2; 

  for (int i = 0; i < boxes.length; i++) {
    float x = startX + i * (boxWidth + spacing); 
    boxes[i] = new Box(x, centerY - boxHeight / 2, boxWidth, boxHeight);
  }

}

void draw() {
  background(0); // Clear the screen

  for (Box box : boxes) {
    box.display();
  }

  // Display all active TUIO objects
  for (TuioObject tobj : tuioClient.getTuioObjectList()) {
    fill(0, 255, 0); // Green for objects
    noStroke();
    float x = tobj.getScreenX(width);
    float y = tobj.getScreenY(height);
    ellipse(x, y, 50, 50);
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