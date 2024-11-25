class Ingredient{

    private int id;
    private String name;
    private int weight;
    private int phValue;
    private int amount;
    private int[] rgb;
    WavSound wavSound; 

    Ingredient(int id, String name, int weight, int phValue, int amount, int[] rgb, WavSound wavSound){
        this.id = id;
        this.name = name;
        this.weight = weight;
        this.phValue = phValue;
        this.amount = amount;
        this.rgb = rgb;
        this.wavSound = wavSound;
    }

    int getId(){
        return id;
    }

    String getName() {
        return name;
    }

    int getWeight() {
        return weight;
    }

    int getPhValue(){
        return phValue;
    }

    int getAmount(){
        return amount;
    }

    int getColor(PApplet applet) {
        return applet.color(rgb[0], rgb[1], rgb[2]);
    }

    WavSound getWavSound(){
        return wavSound;
    }

}

