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
var tileSize=32;
var cam;
var pg;

// Start animation variables
var gb = loadImage("gameboy.png");
var gb_x = 185;
var gbWidth = 30;
//var p2 = loadImage("character2.png").get(400-32,234-64,32,64);

var barMap=[[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1],
            [0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
            [0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0],
            [0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0],
            [0,1,0,0,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0],
            [0,1,0,0,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0],
            [0,1,0,0,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0],
            [0,1,0,0,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0],
            [0,1,0,0,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0],
            [0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0],
            [0,1,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0],
            [0,1,0,0,0,1,1,1,1,1,0,0,0,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0],
            [0,1,0,0,0,1,1,1,1,1,0,0,0,1,1,1,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0],
            [0,1,0,0,0,1,1,1,1,1,0,0,0,1,1,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0],
            [0,1,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0],
            [0,1,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0],
            [0,1,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0],
            [0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0],
            [0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0],
            [0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0],
            [0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
            [0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,1,1,1,1,1,1,1,1,1,1],
            ];
var tMap = [[176,177,176,177,176,177,176,177,176,177,176,177,176,177,176,177,176,177,176,177,176,177,176,177,176,177,176,177,176,177,176,177,176,177],
            [184,185,184,185,184,185,184,185,184,185,184,185,184,185,184,185,184,185,184,185,184,185,184,185,184,185,184,185,184,185,184,185,184,185],
            [176,177,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,176,177],
            [184,185,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,184,185],
            [176,177,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,176,177],
            [184,185,-1,-1,-1,3067,3068,3069,3070,-1,-1,3099,3100,3101,3102,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,184,185],
            [176,177,-1,-1,-1,3075,3076,3077,3078,-1,-1,3107,3108,3109,3110,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,176,177],
            [184,185,-1,-1,-1,3083,3084,3085,3086,-1,-1,3115,3116,3117,3118,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,184,185],
            [176,177,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,176,177],
            [184,185,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,184,185],
            [176,177,-1,-1,-1,-1,-1,-1,-1,4133,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,176,177],
            [184,185,-1,-1,-1,4137,4138,4139,4140,4141,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,184,185],
            [176,177,-1,-1,-1,4145,4146,4147,4148,4149,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,176,177],
            [184,185,-1,-1,-1,4153,4154,4155,4156,4157,4158,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,184,185],
            [176,177,-1,-1,-1,4161,4162,4163,4164,4165,4166,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,176,177],
            [184,185,-1,-1,-1,4169,4170,4171,4172,4173,4174,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,184,185],
            [176,177,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,176,177],
            [184,185,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,184,185],
            [176,177,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,176,177],
            [184,185,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,184,185],
            [176,177,176,177,176,177,176,177,176,177,176,177,176,177,176,177,176,177,176,177,176,177,176,177,176,177,176,177,176,177,176,177,176,177],
            [184,185,184,185,184,185,184,185,184,185,184,185,184,185,184,185,184,185,184,185,184,185,184,185,184,185,184,185,184,185,184,185,184,185]
            ];
var ground3=[[-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
            [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
            [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
            [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
            [-1,-1,-1,-1,2364,2365,2365,2365,2365,2366,2364,2365,2365,2365,2366,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
            [-1,-1,-1,-1,2372,-1,-1,-1,-1,2374,2372,-1,-1,-1,2374,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
            [-1,-1,-1,-1,2372,-1,-1,-1,-1,2374,2372,-1,-1,-1,2374,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
            [-1,-1,-1,-1,2372,-1,-1,-1,-1,2374,2372,-1,-1,-1,2374,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
            [-1,-1,-1,-1,2380,2396,2397,2381,2381,2382,2380,2396,2397,2381,2382,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
            [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
            [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
            [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
            [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
            [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
            [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
            [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
            [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
            [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
            [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
            [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
            [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
            [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
            ];        
var ground2=[[-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
            [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
            [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
            [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
            [-1,-1,-1,835,836,836,836,836,836,836,836,836,836,836,836,837,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
            [-1,-1,-1,843,844,844,844,844,844,844,844,844,844,844,844,845,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,559,559,559,559,-1,-1,-1,-1],
            [-1,-1,-1,843,844,844,844,844,844,844,844,844,844,844,844,845,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,559,559,559,559,-1,-1,-1,-1],
            [-1,-1,-1,843,844,844,844,844,844,844,844,844,844,844,844,845,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,559,559,559,559,-1,-1,-1,-1],
            [-1,-1,-1,843,844,844,844,844,844,844,844,844,844,844,844,845,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,559,559,559,559,-1,-1,-1,-1],
            [-1,-1,-1,843,844,844,844,844,844,844,844,844,844,844,844,845,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
            [-1,-1,-1,-1,843,844,844,844,844,844,845,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
            [-1,-1,-1,-1,843,844,844,844,844,844,845,-1,1088,1089,1089,1089,1089,1089,1089,1090,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
            [-1,-1,-1,-1,843,844,844,844,844,844,845,-1,1096,1097,1097,1097,1097,1097,1097,1098,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
            [-1,-1,-1,-1,843,844,844,844,844,844,845,-1,1096,1097,1097,1097,1097,1097,1097,1098,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
            [-1,-1,-1,-1,843,844,844,844,844,844,845,-1,1096,1097,1097,1097,1097,1097,1097,1098,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
            [-1,-1,-1,-1,851,852,852,852,852,852,853,-1,1096,1097,1097,1097,1097,1097,1097,1098,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
            [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,1096,1097,1097,1097,1097,1097,1097,1098,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
            [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,1104,1105,1105,1105,1105,1105,1105,1106,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
            [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
            [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
            [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
            [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
            ];
var ground =[[563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563],
            [563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563],
            [563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563],
            [563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563],
            [563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563],
            [563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563],
            [563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563],
            [563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563],
            [563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563],
            [563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563],
            [563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563],
            [563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563],
            [563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563],
            [563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563],
            [563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563],
            [563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563],
            [563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563],
            [563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563],
            [563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563],
            [563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563],
            [563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563],
            [563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563,563],
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
void keyReleased() { 
    keys[keyCode] = false; 
    if(keyCode===82&&!p.runState){
        p.runState=true;
    }
    else if(keyCode===82&&p.runState){
        p.runState=false;
    }
};
void mousePressed(){ isMousePressed=true;};
void mouseReleased(){ isMousePressed=false;};

void checkCollision(dir){
    var px = round(p.m_xpos/tileSize);
    var py = round(p.m_ypos/tileSize);
    var playerCollision=false;
    if(dir === 0){//down
        if(barMap[py+1][px]===1){
            playerCollision= true;
        }
    }
    if(dir === 1){//left
        if(barMap[py][px-1]===1){
            playerCollision= true;
        }
    }
    if(dir ===2){//right
        if(barMap[py][px+1]===1){
            playerCollision= true;
        }
    }
    if(dir===3){//up
        if(barMap[py-1][px]===1){
            playerCollision= true;
        }
    }

    if(playerCollision == false)
    {
        p.move(dir);
        p.m_dir=dir;
    }
    else if(playerCollision == true)
    {
        p.m_dir=dir;
    }
};



void setup(){
    size(400, 400,P2D);
    pg = createGraphics(mapWidth, mapHeight,P2D);
    m.initMap(pg,tMap,ground,ground2,ground3,mapWidth,mapHeight);
    p=new player(3*tileSize,3*tileSize);
    for( var i = 1; i<=31; i++){
        pokeArr.push(loadImage("./pokemon/"+i+".png"))
    }
};

var t = 0;
gameState = 0;
var scrollx,scrolly=0;
var buttons = [new buttonObj(20,100,360,50,"Start Game"),new buttonObj(20,170,360,50,"Instructions"),new buttonObj(250,320,120,50,"Go Back")];
buttons[0].selected=1;
var counter = 0;
var logo = loadImage("pokemon_logo.png");
var throw1 = loadImage("throwing1.png");
var throw2 = loadImage("throwing2.png");
var throw3 = loadImage("throwing3.png");
var throw4 = loadImage("throwing4.png");
var throw5 = loadImage("throwing5.png");
var ball = loadImage("pokeball.png");

void draw(){
    switch(gameState){
    case 0: // Gameboy zoom and fade
        if (keys[32]){ // Space
            gameState = 1;
        }
        background(94, 114, 242);
        pushMatrix();
        if(isMousePressed&&gameState===0){
            gameState=1;
        }
        if (counter <= 36){gbWidth+=10;}
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
        popMatrix();
        counter++;
        break;
    case 1: // Animation into instruction screen
    // Add menu code here
        for(var i = 0;i<buttons.length-1;i++){
            buttons[i].display();
            buttons[i].update();
        }
        if(menuState===0){
            image(pg,-100,-100);    // Move trees out of frame
            fill(255);
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
            text("Press R to toggle run mode",30,130);
            buttons[buttons.length-1].display();
            buttons[buttons.length-1].update();
        }
        break;
    case 2:
        background(100);
        stroke(255);
        pushMatrix();
        cam.update(p);
        var py = round(p.m_ypos/tileSize);
        var px = round(p.m_xpos/tileSize);
        image(pg,0,0);
        //image(p2, 100, 100);
        if(px>=26 && px <=29 && py>=5 && py<=8){
            image(m.drawTile(573,32,32),px*tileSize,py*tileSize);
        }
        p.display();
        
        if (keys[68]&&!p.isMoving) {//right
            checkCollision(2);
            
        }
        else if (keys[65]&&!p.isMoving) {//left
            checkCollision(1);
        }
        else if (keys[87]&&!p.isMoving) {//up
            checkCollision(3)
        
        }
        else if (keys[83]&&!p.isMoving) {//down
            checkCollision(0);

        }
        else{
            if(!p.isMoving){
                state=1;
                prevState=0;
            }
        }
        

        popMatrix();
        break;
    }
};

