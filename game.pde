 /* for preload */

PImage[] fragment;
int n=10;

void setup(){
    size(400,400);
    fragment=new PImage[n];
    for(int i=0;i<fragment.length;i++){
        fragment[i]=loadImage("./pokemon/" + str(i) + ".jpg");
    }
};
void draw(){
    background(100);
    stroke(255);
    ellipse(50, 50, 25, 25);

    for(int i=0;i<fragment.length;i++){
        image(fragment[i],20*i,20*i);
    }
};

