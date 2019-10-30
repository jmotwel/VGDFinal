

class tilemap{
    PImage mapset;

    var cols=8;
    var rows=651;
    var numTiles=8*651;
    tilemap(){
        mapset=loadImage("tileset.png");

    }

    PImage drawTile(tileNum,iWidth,iHeight){
        var tileRow= (tileNum/8) | 0;
        var tileCol= (tileNum%8) | 0;
        return mapset.get(tileCol*32,tileRow*32,iWidth,iHeight);
    }



    var initMap(pg,tmap,ground,mapWidth,mapHeight){
        pg.beginDraw();
        for (var i = 0; i < tmap.length; i++) {
            for (var j = 0; j <tmap[0].length; j++) {
                
                pg.image(drawTile(ground[i][j],32,32),j*32,i*32);
                pg.image(drawTile(tmap[i][j],32,32),j*32,i*32);
            }
        }
        pg.endDraw();
        return pg;
    }
}