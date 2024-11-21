enum AlcoholType{
    WHISKEY(0,"Whiskey",40,10,10,new int[] {255, 0, 0}),
    VODKA(1,"Vodka",40,10,10,new int[] {255, 0, 0}),
    GIN(2,"Gin",40,10,10,new int[] {255, 0, 0}),
    RUM(3,"Rum",40,10,10,new int[] {255, 0, 0});

    private int id;
    private String name;
    private int weight;
    private int phValue;
    private int amount;
    private int[] rgb;

    AlcoholType(int id, String name, int weight, int phValue, int amount, int[] rgb){
        this.id = id;
        this.name = name;
        this.weight = weight;
        this.phValue = phValue;
        this.amount = amount;
        this.rgb = rgb;
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
}

enum JuiceType{
    CRANBERRY,
    PINEAPPLE,
    ORANGE,
    GINGERALE;
}

enum Sirup{
    COCONUT,
    GRENADINE,
    BLUECURACAU,
    ELDERFLOWER;
}

enum Garnish{
    MINT,
    LIMESLICES,
    CHERRIES,
    OLIVES;
}

class Ingredient {

    Ingredient (){

    }
}
