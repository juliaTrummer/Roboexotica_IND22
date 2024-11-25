import ddf.minim.*;

public class WavSound {
    private AudioPlayer sound; 
    private Minim minim;

    public WavSound(Minim minim, String filePath) {
        this.minim = minim;
        println(filePath);
        sound = minim.loadFile(filePath);
    }

    // Method to play the sound
    public void play() {
        if (!sound.isPlaying()) {
            sound.rewind();
            sound.play();
        }
    }

    // Method to stop the sound
    public void stop() {
        if (sound.isPlaying()) {
            sound.pause();
            sound.rewind();
        }
    }

    // Clean up the resources
    public void close() {
        sound.close(); // Release the AudioPlayer resources
    }
}
