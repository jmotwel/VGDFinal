/* @pjs preload="tileset.png, character.png, character2.png, gameboy.png"; */
PImage[] fragment;
var gameState = 0;
var menuState = 0;
var m=new tilemap();
var p;
int n=10;
var isMousePressed=0;
var mapHeight;
var mapWidth;
var cam;
var pg;

// Start animation variables
var gb = loadImage("gameboy.png");
var gb_x = 185;
var gbWidth = 30;
//var p2 = loadImage("character2.png").get(400-32,234-64,32,64);

var barMap=[[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
            [0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0],
            [0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0],
            [0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0],
            [0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0],
            [0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0],
            [0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0],
            [0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0],
            [0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0],
            [0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0],
            [0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0],
            [0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0],
            [0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0],
            [0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0],
            [0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0],
            [0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0],
            [0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0],
            [0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0],
            [0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0],
            [0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0],
            [0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0],
            [0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0],
            ];
var tMap = [[176,177,176,177,176,177,176,177,176,177,176,177,176,177,176,177,176,177,176,177,176,177,176,177],
            [184,185,184,185,184,185,184,185,184,185,184,185,184,185,184,185,184,185,184,185,184,185,184,185],
            [176,177,462,462,462,462,462,462,462,462,462,462,462,462,462,462,462,462,462,462,462,462,176,177],
            [184,185,462,462,462,462,462,462,462,462,462,462,462,462,462,462,462,462,462,462,462,462,184,185],
            [176,177,462,462,462,462,462,462,462,462,462,462,462,462,462,462,462,462,462,462,462,462,176,177],
            [184,185,462,462,462,462,462,462,462,462,462,462,462,462,462,462,462,462,462,462,462,462,184,185],
            [176,177,462,462,462,462,462,462,462,462,462,462,462,462,462,462,462,462,462,462,462,462,176,177],
            [184,185,462,462,462,462,462,462,462,462,462,462,462,462,462,462,462,462,462,462,462,462,184,185],
            [176,177,462,462,462,462,462,462,462,462,462,462,462,462,462,462,462,462,462,462,462,462,176,177],
            [184,185,462,462,462,462,462,462,462,462,462,462,462,462,462,462,462,462,462,462,462,462,184,185],
            [176,177,462,462,462,462,462,462,462,462,462,462,462,462,462,462,462,462,462,462,462,462,176,177],
            [184,185,462,462,462,462,462,462,462,462,462,462,462,462,462,462,462,462,462,462,462,462,184,185],
            [176,177,462,462,462,462,462,462,462,462,462,462,462,462,462,462,462,462,462,462,462,462,176,177],
            [184,185,462,462,462,462,462,462,462,462,462,462,462,462,462,462,462,462,462,462,462,462,184,185],
            [176,177,462,462,462,462,462,462,462,462,462,462,462,462,462,462,462,462,462,462,462,462,176,177],
            [184,185,462,462,462,462,462,462,462,462,462,462,462,462,462,462,462,462,462,462,462,462,184,185],
            [176,177,462,462,462,462,462,462,462,462,462,462,462,462,462,462,462,462,462,462,462,462,176,177],
            [184,185,462,462,462,462,462,462,462,462,462,462,462,462,462,462,462,462,462,462,462,462,184,185],
            [176,177,462,462,462,462,462,462,462,462,462,462,462,462,462,462,462,462,462,462,462,462,176,177],
            [184,185,462,462,462,462,462,462,462,462,462,462,462,462,462,462,462,462,462,462,462,462,184,185],
            [176,177,176,177,176,177,176,177,176,177,176,177,176,177,176,177,176,177,176,177,176,177,176,177],
            [184,185,184,185,184,185,184,185,184,185,184,185,184,185,184,185,184,185,184,185,184,185,184,185]
            ];
var ground =[[563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563],
            [563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563],
            [563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563],
            [563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563],
            [563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563],
            [563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563],
            [563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563],
            [563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563],
            [563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563],
            [563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563],
            [563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563],
            [563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563],
            [563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563],
            [563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563],
            [563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563],
            [563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563],
            [563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563],
            [563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563],
            [563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563],
            [563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563],
            [563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563],
            [563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563],
            ];

var buttonObj = function(x,y,width,height,text){
    this.x=x;
    this.y=y;
    this.width=width;
    this.height=height;
    this.c1=255;
    this.c2=255;
    this.c3=255;
    this.selected=0;
    this.dir=-1;
    this.t=text;
};

buttonObj.prototype.update = function(){
    if(mouseX<this.x+this.width&&mouseX>this.x&&
        mouseY<this.y+this.height&&mouseY>this.y){
            this.selected=1;
            if(isMousePressed&&this.t==="Instructions"){
                menuState=3;
            }
            else if(isMousePressed&&this.t==="Go Back"){
                menuState=0;
            }
            else if(isMousePressed&&this.t==="Start Game"){
                menuState=0;
                gameState=2;
            }
    }
    else{
        this.selected=0;
    }
    if(this.selected){
        this.c1=220;
        this.c2=220;
        this.c3=220;
        
    }
    else{
        this.c1=255;
        this.c2=255;
        this.c3=255;
    }
    
};

buttonObj.prototype.display = function(){
    pushMatrix();
    fill(this.c1, this.c2, this.c3);
    translate(this.x,this.y);
    rect(0,0,this.width,this.height,10);
    textSize(20);
    fill(0, 0, 0);
    text(this.t,(this.width/2)-(this.width*0.30),(this.height/2)+(this.height*0.1));
    popMatrix();
};




mapHeight = (tMap.length)*32;
mapWidth = (tMap[0].length)*32;
cam = new cameraObj(mapHeight,mapWidth);
var pokeArr=[];

var keys=[];
void keyPressed(){keys[keyCode] = true; };
void keyReleased() { keys[keyCode] = false; };
void mousePressed(){ isMousePressed=true;};
void mouseReleased(){ isMousePressed=false;};

void setup(){
    size(400, 400,P2D);
    pg = createGraphics(mapWidth, mapHeight,P2D);
    m.initMap(pg,tMap,ground,mapWidth,mapHeight);
    p=new player(200,200);
    for( var i = 1; i<=31; i++){
        pokeArr.push(loadImage("./pokemon/"+i+".png"))
    }
}

var t = 0;
gameState = 0;
var scrollx,scrolly=0;
var buttons = [new buttonObj(20,100,360,50,"Start Game"),new buttonObj(20,170,360,50,"Instructions"),new buttonObj(250,320,120,50,"Go Back")];
buttons[0].selected=1;


void draw(){
    
    switch(gameState){
    case 0: // Gameboy zoom and fade
        if (keys[32]){ // Space
            gameState = 1;
        }
        background(94, 114, 242);
        pushMatrix();
        image(pg.get(100,100,gbWidth,gbWidth),0,0);    // Move trees out of frame
        if (gbWidth <= 390){gbWidth+=10;}
        else if (t <= 255){t+=5;}
        else{gameState=1;}
        tint(255, 255-t);
        image(gb, 0, 0, gbWidth, gbWidth*1.729);
        noTint();
        popMatrix();
        break;
    case 1: // Animation into instruction screen
    // Add menu code here
        for(var i = 0;i<buttons.length-1;i++){
            buttons[i].display();
            buttons[i].update();
        }
        if(menuState===0){
            image(pg,-100,-100);    // Move trees out of frame
            textSize(40);
            text("Pokemon",110,50);
            textSize(20);
            text("Authors: Jason Wojcik and James Otwell",20,80);
            for(var i = 0;i<buttons.length-1;i++){
                buttons[i].display();
                buttons[i].update();
            }
            pushMatrix();
            translate(scrollx,0);
            for(var i =0; i<pokeArr.length;i++){
                image(pokeArr[i],i*128,300);
            }
            scrollx--;
            if(scrollx<-4096){
                scrollx=400;
            }
            popMatrix();
        }
        else if(menuState===1){
            print("bad state");
        }
        else if(menuState===3){
            image(pg,-100,-100);    // Move trees out of frame
            fill(255);
            rect(20,20,360,360,10);
            fill(0);
            textSize(40);
            text("Instructions:",30,60);
            textSize(15);
            text("Use the mouse to select buttons in menu",30,90);
            text("Use WSAD to move the player",30,110);
            buttons[buttons.length-1].display();
            buttons[buttons.length-1].update();
        }
        break;
    case 2:
        background(100);
        stroke(255);
        pushMatrix();
        cam.update(p);

        image(pg,0,0);
        //image(p2, 100, 100);
        p.display();
        if (keys[68]) {//right
            p.isMoving=1;
            p.m_dir=2;
            
        }
        else if (keys[65]) {//left
            p.isMoving=1;
            p.m_dir=1;
        }
        else if (keys[87]) {//up
            p.isMoving=1;
            p.m_dir=3;
        
        }
        else if (keys[83]) {//down
            p.isMoving=1;
            p.m_dir=0;
        }
        else{
            p.isMoving=0;
            state=1;
            prevState=0;
        }
        popMatrix();
        break;
    }
};

