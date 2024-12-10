import ddf.minim.*;

public class Sound {
    private AudioPlayer sound; 
    private Minim minim;

    public Sound(Minim minim, String filePath) {
        this.minim = minim;
        sound = minim.loadFile(filePath);
    }

    /**
     * Starts playback from a specific position (in milliseconds) and loops the sound.
     */
    public void playFromPosition(float position) {
        sound.cue((int) position);
        sound.loop();
    }

    /**
     * Gets the current playback position in milliseconds.
     */
    public int getCurrentPosition() {
        return sound.position();
    }

    /**
     * Stops playback and rewinds the sound to the beginning.
     */
    public void stop() {
        sound.pause();
        sound.rewind();
    }

    /**
     * Plays the sound from the beginning or resumes if paused.
     */
    public void play() {
        sound.play();
    }

    /**
     * Checks whether the sound is currently playing.
     */
    public boolean isPlaying() {
        return sound.isPlaying();
    }

    /**
     * Releases resources used by the sound.
     */
    public void close() {
        sound.close();
    }

    /**
     * Sets the volume of the sound.
     * @param volume Value between 0.0 (mute) and 1.0 (full volume).
     */
    public void setVolume(float volume) {
        sound.setGain((volume - 1.0f) * 60); // Adjust gain based on volume
    }
}
