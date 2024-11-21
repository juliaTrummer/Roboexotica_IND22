import java.io.File; 
import processing.sound.*;

/*
class MP3Sound {
  
  ArrayList<SoundFile> sounds = new ArrayList<SoundFile>();  // List to store sound files
  ArrayList<String> filenames = new ArrayList<String>();  // List to store filenames

  MP3Sound(){
    File folder = new File(dataPath("Sounds"));
    File[] files = folder.listFiles();
    for (File f : files) {
      if (f.isFile() && (f.getName().endsWith(".mp3") || f.getName().endsWith(".wav"))) {
        filenames.add(f.getName());
        sounds.add(new SoundFile(this, "sounds/" + f.getName()));
      }
    }

    for (SoundFile sound : sounds) {
      sound.play();
    }

    for (String filename : filenames) {
      println(filename);
    }
  }
}
*/
