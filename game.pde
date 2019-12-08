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
var pokedex;
var pokemon = [];
var enemy;
var maxEncounter =0;

// For fight menu
var fightMenu = 0;
var selected = 0;

var pokeIndex = 0;
var totalScore = 0;
var scoreText = 0;
var highScore = 0;

// Start animation variables
var gb = loadImage("gameboy.png");
var gb_x = 185;
var gbWidth = 30;
var boost = 1;
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

    if(keyCode===87&&gameState===3){
        if(fightMenu === 1){
            fightMenu = 0;
        }
        //println("here");
    }
    else if(keyCode===83&&gameState===3){
        if(fightMenu === 0){
            fightMenu = 1;
        }
        //println("here2")
    }
    else if(keyCode===ENTER&&gameState===3){
        selected = 1;
    }
    else if(keyCode === 57){    // Shiny catch
        boost=8192;
        gameState=2;
    }
    else if(keyCode === 56){    // One more catch
        totalScore=0;
        pokemon = [];
        scoreText=0;
        pokeIndex=0;
        pokemon.push(new monster(1,29,29,1,59,59));
        pokemon.push(new monster(2,29,29,1,59,59));
        pokemon.push(new monster(3,29,29,1,59,59));
        pokemon.push(new monster(4,29,29,1,59,59));
        pokemon.push(new monster(5,29,29,1,59,59));
        counter = 0;
        gameState=2;
    }
    else if(keyCode === 55){    // Restart game
        totalScore=0;
        pokemon = [];
        counter=0;
        scoreText=0;
        pokeIndex=0;
        pokemon = [];
        gb_x = 185;
        gbWidth = 30;
        gameState=0;
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

int calcRandomPokemon(){
    var temp = (int)random(1,maxEncounter);
    for (var i=0; i<pokedex.length;i++){
        temp-=pokedex[i].crate;
        if(temp<=0){
            return i;
        }
    }
    return 1;
};


void setup(){
    size(400, 400,P2D);
    pg = createGraphics(mapWidth, mapHeight,P2D);
    m.initMap(pg,tMap,ground,ground2,ground3,mapWidth,mapHeight);
    p=new player(3*tileSize,3*tileSize);
    for( var i = 1; i<=31; i++){
        pokeArr.push(loadImage("./pokemon/"+i+".png"))
    }
    pokedex = (function() {
        var json = null;
        $.ajax({
            'async': false,
            'global': false,
            'url': "/pokedex_trim.json",
            'dataType': "json",
            'success': function(data){
                json = data;
            }
        });
        return json;
    })();

    for(var i = 0; i< pokedex.length;i++){
        maxEncounter += pokedex[i].crate;
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

var explosionObj = function(a) {
    this.position = new PVector(0, 0);
    this.direction = new PVector(0, 0);
    this.size = random(1, 3);
    if (a === 0) {
        this.c1 = random(0, 250);
    }
    else {
        this.c1 = random(100, 255);
    }
    if (a === 1) {
        this.c2 = random(0, 250);
    }
    else {
        this.c2 = random(100, 255);
    }
    if (a === 3) {
        this.c3 = random(0, 250);
    }
    else {
        this.c3 = random(100, 255);
    }
    this.timer = 0;
};    

///// EXPERIMENT number of particles ////
var fireworkObj = function(a) {
    this.position = new PVector(200, 380);
    this.direction = new PVector(0, 0);
    this.target = new PVector(mouseX, mouseY);
    this.step = 0;
    this.explosions = [];
    for (var i = 0; i < 200; i++) {
        this.explosions.push(new explosionObj(a));   
    }    
};    

var firework = [new fireworkObj(0), new fireworkObj(1), new fireworkObj(2), new fireworkObj(0)];

//// EXPERIMENT direction of explosion /////
fireworkObj.prototype.draw = function() {
    fill(255, 255, 255);
    noStroke();
    ellipse(this.position.x, this.position.y, 2, 2);
    
    this.position.add(this.direction);
    if (dist(this.position.x, this.position.y, this.target.x, this.target.y) < 4) {
        this.step = 2;
        for (var i = 0; i < this.explosions.length; i++) {
            this.explosions[i].position.set(this.target.x, this.target.y);
            
            this.explosions[i].direction.set(random(0, 360), random(-0.3, 0.3));
/*	    this.explosions[i].direction.set(random(-0.3, 0.3), 
		random(-0.3, 0.3)); // cartesian (instead of polar) direction */
            this.explosions[i].timer = 180;
        }
    }    
};

//// EXPERIMENT direction of explosion /////
explosionObj.prototype.draw = function() {
    fill(this.c1, this.c2, this.c3, this.timer);	// 4th value fader
    noStroke();
    ellipse(this.position.x, this.position.y, this.size, this.size);
    
    this.position.x += this.direction.y*cos(this.direction.x);
    this.position.y += this.direction.y*sin(this.direction.x);
/*  this.position.add(this.direction); // random cartesian direction */
    this.position.y += (90/(this.timer + 100));    //gravity
    this.timer--;
};


void drawFireWorks(){
    //background(0, 0, 0);

    for (var j = 0; j < firework.length; j++) {
        if (firework[j].step === 0) {
            firework[j].position.set(200, 450);
            firework[j].target.set(random(100, 300), random(50, 120));
            firework[j].direction.set(firework[j].target.x - firework[j].position.x, firework[j].target.y - firework[j].position.y);
            var s = random(1, 2) / 100;
            firework[j].direction.mult(s);
            firework[j].step++;
        } 
        else if (firework[j].step === 1) {
            firework[j].draw();
        } 
        else if (firework[j].step === 2) {
            for (var i = 0; i < firework[j].explosions.length; i++) {
                firework[j].explosions[i].draw();   
            } 
            if (firework[j].explosions[0].timer <= 0) {
                firework[j].step = 0;   
            }
        }
    }
}








// gameState = 3;
void draw(){
    if (keys[32]){ // Space
            gameState = 1;
    }
    switch(gameState){
    case 0: // Gameboy zoom and fade
        if (keys[32]){ // Space
            gameState = 1;
        }
        background(94, 114, 242);
        pushMatrix();

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
            counter = 0;
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
            text("Use W and S to control menu and enter to select",30,150);
            text("Catch 6 Pokemon to finish the game",30,170);
            text("Run away to find higher scoring pokemon",30,190);
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
            var r = random(1,10);
            if((((int)r)===1) && (px>=26 && px <=29 && py>=5 && py<=8)){
                gameState=3;
                counter = 0;
                int i = calcRandomPokemon();

                enemy = new monster(i,50,50,boost,50,50);
                break;
            }
            checkCollision(2);
        }
        else if (keys[65]&&!p.isMoving) {//left
            var r = random(1,10);
            if((((int)r)===1) && (px>=26 && px <=29 && py>=5 && py<=8)){
                gameState=3;
                counter = 0;
                int i = calcRandomPokemon();

                enemy = new monster(i,50,50,boost,50,50);
                break;
            }
            checkCollision(1);
            
        }
        else if (keys[87]&&!p.isMoving) {//up
            var r = random(1,10);
            if((((int)r)===1) && (px>=26 && px <=29 && py>=5 && py<=8)){
                gameState=3;
                counter = 0;
                int i = calcRandomPokemon();
                enemy = new monster(i,50,50,boost,50,50);
                break;
            }
            checkCollision(3)
            
        
        }
        else if (keys[83]&&!p.isMoving) {//down
            var r = random(1,10);
            if((((int)r)===1) && (px>=26 && px <=29 && py>=5 && py<=8)){
                gameState=3;
                counter =0;
                int i = calcRandomPokemon();
                enemy = new monster(i,50,50,boost,50,50);
                break;
            }
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
    case 3:
        // Battle
        pushMatrix();

        // Black stripe fill
        fill(0,0,0);
        noStroke();
        if(counter <= 13){
            rect(400 - counter*32, 0, 420, 40);
        }
        else if(counter <= 26){
            rect(0, (counter-26)*32, 40, 420);
        }
        else if(counter <= 39){
            rect((counter-39)*32, 360, 420, 40);
        }
        else if(counter <= 52){
            rect(360, (52-counter)*32, 40, 420);    // First
        }
        else if(counter <= 65){
            rect((65 - counter)*32, 40, 420, 40);
        }
        else if(counter <= 78){
            rect(40, (counter-78)*32, 40, 420);
        }
        else if(counter <= 91){
            rect((counter-91)*32, 320, 420, 40);
        }
        else if(counter <= 104){
            rect(320, (104-counter)*32, 40, 420);    // Second
        }
        else if(counter <= 117){
            rect((117 - counter)*32, 80, 420, 40);
        }
        else if(counter <= 130){
            rect(80, (counter-130)*32, 40, 420);
        }
        else if(counter <= 143){
            rect((counter-143)*32, 280, 420, 40);
        }
        else if(counter <= 156){
            rect(280, (156-counter)*32, 40, 420);    // Third
        }
        else if(counter <= 169){
            rect((169 - counter)*32, 120, 420, 40);
        }
        else if(counter <= 182){
            rect(120, (counter-182)*32, 40, 420);
        }
        else if(counter <= 195){
            rect((counter-195)*32, 240, 420, 40);
        }
        else if(counter <= 208){
            rect(240, (208-counter)*32, 40, 420);    // Fourth
        }
        else if(counter <= 221){
            rect((221 - counter)*32, 160, 420, 40);
        }
        else if(counter <= 234){
            rect(160, (counter-234)*32, 40, 420);
        }
        else if(counter <= 247){
            rect((counter-247)*32, 200, 420, 40);   // Last
        }
        // Battle screen
        else{
            counter --; // Slow down
            background(217, 214, 210);

            // Draw player
            var pImgX = (300 - counter)*7.5;
            if(pImgX <= 20){
                pImgX = 20
            }
            image(throw1, pImgX, 200, 100, 100);

            // Draw enemy
            var eImgX = (counter-300)*7.5;
            if(eImgX >= 300){
                eImgX = 300;
                fill(255,255,255);
                stroke(0,0,0);
                rect(6, 10, 230, 75);
                rect(9, 12, 226, 71);
                fill(0,0,0);
                textSize(26);
                text(enemy.myName, 20, 40);
                text("Score: "+ enemy.calcScore(), 60, 70);

            }
            // var enemyImg = pokemon.image  -- something like this?
            var enemyImg = enemy.myImage;  // Place holder for now
            image(enemyImg, eImgX, 10, 100, 100);

            // Draw text box
            fill(255,255,255);
            stroke(0,0,0);
            rect(1, 300, 398, 99);
            rect(3, 302, 394, 95);

            // Get moves for text
            // pokemon.moves
            fill(0,0,0);
            textSize(26);

            if(counter <= 380){
                text("Wild "+ enemy.myName+"\nAppeared!", 10, 330);
            }
            else{
                text("  Catch", 10, 330);
                text("  Run Away", 10, 370);
                if(fightMenu === 0){
                    triangle(10, 314, 10, 329, 20, 321.5);
                    if(selected){
                        selected = 0;
                        counter=0;
                        gameState=2;
                        pokemon.push(enemy);
                        if(pokemon.length > 5 ){
                            gameState = 4;
                        }
                        // Random chance???
                    }
                }
                else if(fightMenu === 1){
                    triangle(10, 355, 10, 370, 20, 362.5);
                    if(selected){
                        gameState = 2;
                        selected = 0;
                        counter=0;
                    }
                }
            }
        }

        popMatrix();
        counter+=2;      // Increment frame counter
        break;
    case 4:
        pushMatrix();
        background(217, 214, 210);

        if(counter <= 160){
            image(throw1, 10, 300, 100, 100);
        }
        else if(counter <= 180){
            image(throw2, 10, 300, 100, 100);
        }
        else if(counter <= 200){
            image(throw3, 10, 300, 100, 100);
        }
        else if(counter <= 220){
            image(ball, 160+counter-366, 215-counter+366, 20, 20);
            image(throw4, 10, 300, 100, 100);
        }
        else if(counter <= 400){
            image(ball, 160+counter-366, 215-counter+366, 20, 20);
            image(throw5, 10, 300, 100, 100);
        }
        else if(counter<=1000){
            image(throw1, 10, 300, 100, 100);
            pokemon[pokeIndex].m_xpos = 150;
            pokemon[pokeIndex].m_ypos = 150;
            pokemon[pokeIndex].display();

            // Draw text box
            if(pokeIndex === 0){
                totalScore = pokemon[pokeIndex].calcScore();
            }

            fill(255,255,255);
            stroke(0,0,0);
            rect(150, 300, 248, 99);
            rect(152, 302, 244, 95);
            fill(0,0,0);
            textSize(26);
            text(pokemon[pokeIndex].myName, 155, 335);
            textSize(18);
            text("Catch Rate: " + pokemon[pokeIndex].myCRate, 155, 355);
            text("Score: " + pokemon[pokeIndex].calcScore(), 155, 375);
            scoreText = totalScore;
        }
        else{
            if(pokeIndex < 5){
                if(pokeIndex < 5){counter = 0;}
                pokeIndex++;
                totalScore += pokemon[pokeIndex].calcScore();
            }
            else{
               image(throw1, 10, 300, 100, 100); 
               if(totalScore >= highScore){
                    highScore = totalScore;
                    textSize(30);
                    fill(255,0,0);
                    text("!!! NEW HIGH SCORE !!!", 30, 185);
                    drawFireWorks();
               }
                pokemon[5].m_xpos = 300;
                pokemon[5].m_ypos = 10;
                pokemon[5].display();
                if (keys[32]){ // Space
                    gameState = 1;
                    totalScore=0;
                    pokemon = [];
                    counter=0;
                    pokeIndex=0;
                    scoreText=0;
                }
                textSize(20);
                fill(255);
                text("Press space to restart", 100, 210);
            }
        }
        textSize(35);
        fill(0,0,0);
        text(scoreText, 165, 140);

        if(pokeIndex>0){
            pokemon[0].m_xpos = 0;
            pokemon[0].m_ypos = 10;
            pokemon[0].display();
        }
        if(pokeIndex>1){
            pokemon[1].m_xpos = 60;
            pokemon[1].m_ypos = 10;
            pokemon[1].display();
        }
        if(pokeIndex>2){
            pokemon[2].m_xpos = 120;
            pokemon[2].m_ypos = 10;
            pokemon[2].display();
        }
        if(pokeIndex>3){
            pokemon[3].m_xpos = 180;
            pokemon[3].m_ypos = 10;
            pokemon[3].display();
        }
        if(pokeIndex>4){
            pokemon[4].m_xpos = 240;
            pokemon[4].m_ypos = 10;
            pokemon[4].display();
        }

        popMatrix();
        counter+=8;
        break;
    }
    
};

