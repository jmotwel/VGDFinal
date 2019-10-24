

class tilemap{
    PImage mapset;
    var cols=8;
    var rows=651;
    var numTiles=8*651;
    tilemap(){
        mapset=loadImage("tileset.png");
    }

    void drawTile(tileNum,x,y){
        var tileRow= (tileNum/8) | 0;
        var tileCol= (tileNum%8) | 0;
        image(mapset.get(tileCol*32,tileRow*32,32,32),x,y);
    }
}