import java.util.HashMap;

public class SoundManager {
    private HashMap<Integer, Sound> activeSounds;
    private boolean isPlaying;
    private int syncPosition;

    public SoundManager() {
        activeSounds = new HashMap<>();
        isPlaying = false;
        syncPosition = 0; // Start playback position
    }

    public boolean isPlaying(int id) {
        return activeSounds.containsKey(id) && activeSounds.get(id).isPlaying();
    }

    /**
     * Adds a sound associated with a specific ID.
     * If the sound is not already playing, it will start from the current sync position.
     */
    public void addSound(int id, Sound sound) {
        if (!activeSounds.containsKey(id)) {
            activeSounds.put(id, sound);
            if (!isPlaying) {
                sound.playFromPosition(syncPosition); // Start sound from sync position
                isPlaying = true; // Set isPlaying to true once the sound is started
            }
        }
    }

    /**
     * Removes a sound associated with a specific ID.
     * Stops the sound if it is playing and removes it from the list.
     */
    public void removeSound(int id) {
        if (activeSounds.containsKey(id)) {
            Sound sound = activeSounds.get(id);
            sound.stop(); // Stop sound when ingredient is removed
            activeSounds.remove(id);

            // If no sounds are left, stop playback
            if (activeSounds.isEmpty()) {
                isPlaying = false;
            }
        }
    }

    /**
     * Starts playback for all active sounds.
     * Ensures they start from the same position (syncPosition).
     */
    public void start() {
        if (!isPlaying) {
            syncPosition = 0; // Start from the beginning
            for (Sound sound : activeSounds.values()) {
                sound.playFromPosition(syncPosition); // Loop the sound from sync position
            }
            isPlaying = true;
        }
    }

    /**
     * Updates the playback position for synchronization.
     * Ensures all remaining sounds stay in sync.
     */
    public void updatePosition() {
        if (isPlaying && !activeSounds.isEmpty()) {
            // Update sync position based on any active sound
            Sound firstSound = activeSounds.values().iterator().next();
            syncPosition = firstSound.getCurrentPosition();
        }
    }

    /**
     * Stops all active sounds and resets playback state.
     */
    public void stop() {
        for (Sound sound : activeSounds.values()) {
            sound.stop();
        }
        activeSounds.clear();
        isPlaying = false;
        syncPosition = 0;
    }

    boolean hasActiveSounds() {
        return !activeSounds.isEmpty();
    }
}
