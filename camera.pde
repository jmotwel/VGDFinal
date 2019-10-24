

class cameraObj{
    var xOff;
    var yOff;

    cameraObj(){
        xOff=0;
        yOff=0;
    }

    boolean isInCam(target){
        return (target.x>=-this.xOffset-50 && target.x<=-this.xOffset+400&&target.y+50>=-this.yOffset && target.y<=-this.yOffset+400);
    }

    void update(target){
        var x=-target.x + 200;
        var y=-target.y + 200;
        x = min(0,x);
        y = min(0,y);
        x = max(-mapWidth,x);
        y = max(-mapHeight,y);
        this.xOffset = x;
        this.yOffset = y;
        //println(this.xOffset+" "+this.yOffset);
        translate(this.xOffset,this.yOffset);
    }
    
}