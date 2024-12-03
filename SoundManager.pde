import java.util.HashMap;

public class SoundManager {
    private HashMap<Integer, WavSound> activeSounds;
    private boolean isPlaying;
    private int syncPosition;

    public SoundManager() {
        activeSounds = new HashMap<>();
        isPlaying = false;
        syncPosition = 0; // Start playback position
    }

    /**
     * Adds a sound associated with a specific ID.
     * If playback is ongoing, the new sound starts playing in sync.
     */
    public void addSound(int id, WavSound sound) {
        if (!activeSounds.containsKey(id)) {
            activeSounds.put(id, sound);
            if (isPlaying) {
                sound.playFromPosition(syncPosition);
            }
        }
    }

    /**
     * Removes a sound associated with a specific ID.
     * Stops the sound if it is playing and removes it from the list.
     */
    public void removeSound(int id) {
        if (activeSounds.containsKey(id)) {
            WavSound sound = activeSounds.get(id);
            sound.stop();
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
            for (WavSound sound : activeSounds.values()) {
                sound.playFromPosition(syncPosition);
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
            WavSound firstSound = activeSounds.values().iterator().next();
            syncPosition = firstSound.getCurrentPosition();
        }
    }

    /**
     * Stops all active sounds and resets playback state.
     */
    public void stop() {
        for (WavSound sound : activeSounds.values()) {
            sound.stop();
        }
        activeSounds.clear();
        isPlaying = false;
        syncPosition = 0;
    }
}
