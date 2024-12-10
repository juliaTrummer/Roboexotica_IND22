import ddf.minim.*;

public class Sound {
    private AudioPlayer sound; 
    private Minim minim;

    public Sound(Minim minim, String filePath) {
        this.minim = minim;
        //println(filePath);
        sound = minim.loadFile(filePath);
    }

    public void playFromPosition(float position) {
        sound.cue((int) position);
        sound.loop();
    }

    public int getCurrentPosition() {
        return sound.position();
    }

    public void stop() {
        sound.pause();
        sound.rewind();
    }

    public void play(){
        sound.play();
    }

    public void close() {
        sound.close();
    }
}