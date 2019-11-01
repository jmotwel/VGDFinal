/* @pjs preload="tileset.png, character.png, character2.png, gameboy.png"; */
PImage[] fragment;
var gameState = 0;
var m=new tilemap();
var p;
int n=10;
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
mapHeight = (tMap.length)*32;
mapWidth = (tMap[0].length)*32;
cam = new cameraObj(mapHeight,mapWidth);


var keys=[];
void keyPressed(){keys[keyCode] = true; };
void keyReleased() { keys[keyCode] = false; };

void setup(){
    size(400, 400,P2D);
    pg = createGraphics(mapWidth, mapHeight,P2D);
    m.initMap(pg,tMap,ground,mapWidth,mapHeight);
    p=new player(200,200);
}

var t = 0;
gameState = 0;
void draw(){
    
    switch(gameState){
    case 0: // Gameboy zoom and fade
        if (keys[32]){ // Space
            gameState = 1;
        }
        background(100);
        pushMatrix();
        image(pg,-100,-100);    // Move trees out of frame
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
        if (keys[32]){ // Space
            gameState = 2;
        }
        background(100);
        pushMatrix();
        image(pg,-100,-100);    // Move trees out of frame
        popMatrix();
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

