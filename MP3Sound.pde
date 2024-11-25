public class MP3Sound {
    private SoundFile sound;
    private PApplet parent; // Reference to the main PApplet instance

    // Constructor that takes a PApplet instance and file path
    public MP3Sound(PApplet parent, String filePath) {
        this.parent = parent; // Store the PApplet reference
        sound = new SoundFile(parent, filePath); // Use parent (PApplet) to create SoundFile
        if (sound.isLoaded()) {
            parent.println("Sound file loaded successfully.");
        } else {
            parent.println("Failed to load sound file.");
        }
    }

    // Method to play the sound
    public void play() {
        if (sound.isLoaded()) {
            sound.play();
        } else {
            parent.println("Sound file is not loaded, cannot play.");
        }
    }
}