

class cameraObj{
    var xOff;
    var yOff;
    var mHeight, mWidth;
    cameraObj(mapHeight,mapWidth){
        xOff=0;
        yOff=0;
        mHeight = mapHeight;
        mWidth = mapWidth;
    }

    boolean isInCam(target){
        return (target.m_xpos>=-this.xOff-50 && target.m_xpos<=-this.xOff+400&&target.m_ypos+50>=-this.yOff && target.m_ypos<=-this.yOff+400);
    }

    void update(target){
        var x=-target.m_xpos + 200;
        var y=-target.m_ypos + 200;
        x = min(0,x);
        y = min(0,y);
        
        x = max(-mWidth+400,x);
        y = max(-mHeight+400,y);
        xOff = x;
        yOff = y;
        translate(xOff,yOff);
    }
    
}