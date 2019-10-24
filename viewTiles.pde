

PImage[] fragment;
PImage m;
var n=10;
var t=0;

var setup(){
    size(400,400);
    m=new tilemap();
};
void mouseClicked() {
    t-=32;
};
var draw(){
    background(200);
    pushMatrix();
    translate(0,t);
    image(m.mapset,0,0);
    var c=0;
    for(var j = 0; j<651; j++){
        for(var i = 0; i<8;i++){
            textSize(15);
            stroke(0);
            noFill();
            text(""+(c),i*32,(j+1)*32);
            rect(i*32,j*32,32,32);
            c++;
        }
    }
    popMatrix();
};