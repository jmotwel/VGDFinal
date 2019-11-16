var sketchProc=function(processingInstance){ with (processingInstance){
size(400, 400); 
frameRate(60);

var t = 0;
var gameState = 0;
var gb = loadImage("gameboy.png");
var logo = loadImage("pokemon_logo.png");
var throw1 = loadImage("throwing1.png");
var throw2 = loadImage("throwing2.png");
var throw3 = loadImage("throwing3.png");
var throw4 = loadImage("throwing4.png");
var throw5 = loadImage("throwing5.png");
var ball = loadImage("pokeball.png");
var gb_x = 185;
var gbWidth = 30;
var counter = 0;

var draw = function() {
    switch(gameState){
    case 0: // Gameboy zoom and fade
        background(94, 114, 242);
        pushMatrix();
        // // image(pg.get(100,100,gbWidth,gbWidth),0,0);    // Move trees out of frame
        if (counter <= 36){gbWidth+=10;}   // Gameboy grows
        else{
            background(165, 166, 158);
            if(counter <= 76){
                textSize(17);
                text("\251 2019     James Otwell", 110, 120);
                text("\251 2019     Jason Wojcik", 110, 150);
            }
            else if(counter <= 146){
                image(logo, 100, 110, 200, 100);
            }
            else if(counter <= 306){
                fill(0,0,0);
                rect(80,60,270,220);
                image(throw1, 110, 230, 50, 50);
            }
            else if(counter <= 326){
                fill(0,0,0);
                rect(80,60,270,220);
                image(throw2, 110, 230, 50, 50);
            }
            else if(counter <= 346){
                fill(0,0,0);
                rect(80,60,270,220);
                image(throw3, 110, 230, 50, 50);
            }
            else if(counter <= 366){
                fill(0,0,0);
                rect(80,60,270,220);
                image(throw4, 110, 230, 50, 50);
            }
            else if(counter <= 426){
                fill(0,0,0);
                rect(80,60,270,220);
                image(throw5, 110, 230, 50, 50);
                image(ball, 137+counter-366, 230-counter+366, 10, 10);
            }
        }
        // else if (t <= 255){t+=5;}
        // else{gameState=1;}
        // tint(255, 255-t);
        // tint(255, 110);
        image(gb, 0, 0, gbWidth, gbWidth*1.729);
        if(counter <= 1200 && counter > 426){
            fill(0,0,0);
            rect(80,60,270,220);
            image(throw5, 110, 230, 50, 50);
            image(ball, 197, 170, 10, 10);
            fill(255,255,255, 0+(counter+426)/5);
            ellipse(202, 170, counter-426, counter-426);
            counter+=4;
        }
        else if(counter > 1200){
            gameState = 1;
        }
        noTint();
        popMatrix();
        break;
    case 1:
        background(0,0,0);  // Instructions here
        break;
    }
    counter++;
};
}};
