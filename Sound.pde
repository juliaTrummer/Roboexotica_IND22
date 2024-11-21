import java.io.File; 
import processing.sound.*;

ArrayList<SoundFile> sounds = new ArrayList<SoundFile>();  // List to store sound files
ArrayList<String> filenames = new ArrayList<String>();  // List to store filenames
/*
void setup() {
  size(400, 400);
  File folder = new File(dataPath("Sounds"));
  File[] files = folder.listFiles();
  for (File f : files) {
    if (f.isFile() && (f.getName().endsWith(".mp3") || f.getName().endsWith(".wav"))) {
      filenames.add(f.getName());
      sounds.add(new SoundFile(this, "sounds/" + f.getName()));
    }
  }

  for (SoundFile sound : sounds) {
    sound.play(); //<>//
  }

  for (String filename : filenames) {
    println(filename);
  }
}

void draw() {
  background(200);
}
*/  