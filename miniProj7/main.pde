/* @pjs preload="tiles.png"; */

var floor,wall;
var pLeft = [];
var pRight = [];
var pDown = [];
var pUp = [];
var eLeft;
var eRight;
var eDown;
var eUp;
var b;
var p;
var e,e1;
var cols=20;
var rows=20;
var blankGrid=new Array(cols);
var stage=0;
var tmap = [
"wwwwwwwwwwwwwwwwwwww",
"wffffffffffffffffffw",
"wfwfwfwwwwwwwwwfwffw",
"wfwfwfffffffffwfwffw",
"wfwfwfwwwwwwwfwfwffw",
"wfwfwfffffffwfwfwffw",
"wfwfwwwwwwwfwfwfwffw",
"wfwffffffffffffffffw",
"wfwwwwwwwwwwwwwwwwfw",
"wffffffffffffffffffw",
"wfwwwwwwwfwwwwwwwwww",
"wffffffffffffffffffw",
"wfwwwwwwwwwwwwwwfffw",
"wffwfffffffffffffffw",
"wffwffwwwwwwwwwwfffw",
"wffwfffffffffffffffw",
"wffwfffffffffffffffw",
"wffwwwwwwwwwwwwwfffw",
"wffffffffffffffffffw",
"wwwwwwwwwwwwwwwwwwww",
];

var keys=[];
void keyPressed(){keys[keyCode] = true; };
void keyReleased() { keys[keyCode] = false; };

var remFromArray = function(arr,it){
    for(var i =arr.length-1;i>=0;i--){
        if(arr[i]===it){
            arr.splice(i,1);
        }
    }
};
var heuristic = function(a,b){
    var d=abs(a.x-b.x)+abs(a.y-b.y);
    return d;
};

var wallObj = function(x, y) {
    this.x = x;
    this.y = y;
};

var qObj = function(x, y) {
    this.x = x;
    this.y = y;
    this.fcost = 0;
};

qObj.prototype.set = function(a, b) {
    this.x = a;
    this.y = b;
};

var graph = new Array(20);
var cost = new Array(20);
var inq = new Array(20);
var comefrom = new Array(20);
for (var i=0; i<20; i++) {
    graph[i] = new Array(20);
    cost[i] = new Array(20);
    inq[i] = new Array(20);
    comefrom[i] = new Array(20);
}
var path = [];
var q = [];
for (i=0; i<400; i++) {
    path.push(new PVector(0, 0));
    q.push(new qObj(0, 0));
}
for (i=0; i<20; i++) {
    for(var j=0; j<20; j++) {
        comefrom[i][j] = new PVector(0, 0);
    }
}
var pathLen = 0;
var pathFound = 0;
var qLen = 0;
var qStart = 0;

var initialized = 0;

var walls = [];

var initializeTilemap = function () {
    for (var i=0; i<tmap.length; i++) {
        for (var j=0; j<tmap[i].length; j++) {
            if (tmap[i][j] === "w") {
                walls.push(new wallObj(j*20, i*20));
                graph[i][j] = -1;
            }
            else {
                graph[i][j] = 0;
            }
        }
    }
};

var initGraph = function(x, y) {
    for (var i = 0; i< 20; i++) {
        for (var j = 0; j<20; j++) {
            if (graph[i][j] > 0) {
                graph[i][j] = 0;
            }
            inq[i][j] = 0;
            cost[i][j] = 0;
        }
    }
    
    graph[x][y] = 1;
};

var targetObj = function(x, y) {
    this.x = x;
    this.y = y;
};
var target = new targetObj(0, 0);
var targetPos = new targetObj(0, 0);
var finalDest = new targetObj(0, 0);
//////////////////////////////////////////////////////////////////////
var findAStarPath = function(x, y) {
    var i, j, a, b;
    qLen = 0;
    graph[x][y] = 1;
    inq[x][y] = 1;
    q[qLen].set(x, y);
    q[qLen].fcost = 0;
    qLen++;
    pathLen = 0;
    qStart = 0;
    
    var findMinInQ = function() {
        var min = q[qStart].fcost;
        var minIndex = qStart;
        for (var i = qStart+1; i<qLen; i++) {
            if (q[i].fcost < min) {
                min = q[i].qStart;
                minIndex = i;
            }
        }
        if (minIndex !== qStart) {  // swap
            var t1 = q[minIndex].x;
            var t2 = q[minIndex].y;
            var t3 = q[minIndex].fcost;
            q[minIndex].x = q[qStart].x;
            q[minIndex].y = q[qStart].y;
            q[minIndex].fcost = q[qStart].fcost;
            q[qStart].x = t1;
            q[qStart].y = t2;
            q[qStart].fcost = t3;
        }
    };
    
    var setComeFrom = function(a, b, i, j) {
        inq[a][b] = 1;
        comefrom[a][b].set(i, j);
        q[qLen].set(a, b);
        cost[a][b] = cost[i][j] + 10;
        q[qLen].fcost = cost[a][b] + dist(b*20+10, a*20+10, finalDest.x,
finalDest.y);
        qLen++;
    };
    
    while ((qStart < qLen) && (pathFound === 0)) {
        findMinInQ();
        i = q[qStart].x;
        j = q[qStart].y;
        
        graph[i][j] = 1;
        qStart++;
        if ((i === targetPos.x) && (j === targetPos.y)) {
            pathFound = 1;
        }
        
        a = i+1;
        b = j;
        if ((a < 20) && (pathFound === 0)) {
            if ((graph[a][b] === 0) && (inq[a][b] === 0)) {
                setComeFrom(a, b, i, j);
            }
        }
        a = i-1;
        b = j;
        if ((a >= 0) && (pathFound === 0)) {
            if ((graph[a][b] === 0) && (inq[a][b] === 0)) {
                setComeFrom(a, b, i, j);
            }
        }
        a = i;
        b = j+1;
        if ((b < 20) && (pathFound === 0)) {
            if ((graph[a][b] === 0) && (inq[a][b] === 0)) {
                setComeFrom(a, b, i, j);
            }
        }
        a = i;
        b = j-1;
        if ((b >= 0) && (pathFound === 0)) {
            if ((graph[a][b] === 0) && (inq[a][b] === 0)) {
                setComeFrom(a, b, i, j);
            }
        }
    }   // while
    
    while ((i !== x) || (j !== y)) {
        a = comefrom[i][j].x;
        b = comefrom[i][j].y;
        path[pathLen].set(b*20 + 10, a*20+10);
        
        pathLen++;
        i = a;
        j = b;
    }
};


var cell = function(i,j){
    this.x=i;
    this.y=j;
    this.f=0;
    this.g=0;
    this.h=0;
    this.neighbors=[];
    this.prev;
    this.wall=0;


    this.addNeighbors=function(grid){
        var i = this.x;
        var j = this.y;
        if(i<cols-1){
            this.neighbors.push(grid[i+1][j]);
        }
        if(i>0){
            this.neighbors.push(grid[i-1][j]);
        }
        if(j<rows-1){
            this.neighbors.push(grid[i][j+1]);
        }
        if(j>0){
            this.neighbors.push(grid[i][j-1]);
        }
        
        
        
    }
}

var playerObj = function(x,y) {
    this.x = x;
    this.y = y;
    this.dir = 0;
    this.fr=0;
    this.delayMove=0;
};

playerObj.prototype.canMove = function(x,y){
    if(tmap[y][x]!=="w"){
        if(e.x===x && e.y===y||e1.x===x&&e1.y===y)
        {
            return false;
        }
        else{
            return true;
        }
    }
    else{
        return false;
    }
};

playerObj.prototype.display = function(){
    if(frameCount%10===0){
        if(this.fr===3){
            this.fr=0;
        }
        else{
            this.fr=this.fr+1;
        }
    }

    if(this.dir===0){//down
        image(pDown[this.fr],this.x*20,this.y*20);
    }
    else if(this.dir===1){//left
        image(pLeft[this.fr],this.x*20,this.y*20);
    }
    else if(this.dir===2){//right
        image(pRight[this.fr],this.x*20,this.y*20);
    }
    else if(this.dir===3){//up
        image(pUp[this.fr],this.x*20,this.y*20);
    }

};

playerObj.prototype.control = function(){
    if (keys[68]) {//right
        this.dir=2;
        if(this.canMove(this.x+1,this.y)&&this.delayMove<=0){
            this.x+=1;
            this.delayMove=30;
        }
        else{
            if(this.delayMove>0){
                this.delayMove-=1;
            }
        }
    }
    else if(keys[65]) {//left
        this.dir=1;
        if(this.canMove(this.x-1,this.y)&&this.delayMove<=0){
            this.x-=1;
            this.delayMove=30;
        }
        else{
            if(this.delayMove>0){
                this.delayMove-=1;
            }
        }
    }
    else if(keys[87]) {//up
        this.dir=3;
        if(this.canMove(this.x,this.y-1)&&this.delayMove<=0){
            this.y-=1;
            this.delayMove=30;
        
        }
        else{
            if(this.delayMove>0){
                this.delayMove-=1;
            }
        }
    }
    else if(keys[83]) {//down
        this.dir=0;
        if(this.canMove(this.x,this.y+1)&&this.delayMove<=0){
            this.y+=1;
            this.delayMove=30;
            
        }else{
            if(this.delayMove>0){
                this.delayMove-=1;
            }
        }
    }
    else if(this.delayMove>0){
        this.delayMove-=1;
    }
    
};

var enemyObj = function(x,y) {
    this.x = x;
    this.y = y;
    this.dir = 0;
    this.delayMove=0;
    this.grid;
    this.openSet=[];
    this.closedSet=[];
    this.start;
    this.end;
    this.path=[];
    this.maxSearch=15;
    this.mvCell=0;
    this.done=0;
    this.high=0;
    this.highest;
};

enemyObj.prototype.display = function(){

    if(this.dir===0){//down
        image(eDown,this.x*20,this.y*20);
    }
    else if(this.dir===1){//left
        image(eLeft,this.x*20,this.y*20);
    }
    else if(this.dir===2){//right
        image(eRight,this.x*20,this.y*20);
    }
    else if(this.dir===3){//up
        image(eUp,this.x*20,this.y*20);
    }

};


enemyObj.prototype.calcPath = function(){
    
    target.x = p.x*20;
    target.y = p.y*20;
    finalDest.x = target.x;
    finalDest.y = target.y;
    targetPos.x = Math.floor(finalDest.y / 20);
    targetPos.y = Math.floor(finalDest.x / 20);
    var i = Math.floor(this.y);
    var j = Math.floor(this.x);

    initGraph(i, j);
    pathFound = 0;
    pathLen = 0;
    findAStarPath(i, j);
    pathLen--;
    target.x = path[pathLen].x;
    target.y = path[pathLen].y;
    
};

enemyObj.prototype.move=function(){
    println(pathLen);
    if(pathFound&&this.delayMove<=0){
        
        
        if (pathLen > 0) {
        posx = Math.floor(path[pathLen-1].x / 20);
        posy = Math.floor(path[pathLen-1].y / 20);
        if(posx===p.x&&posy===p.y){
            stage=1;
        }
        else{
            this.x=posx;
            this.y=posy;
            
            this.delayMove=30;
        }

        
        }

        
    }
    else{
        this.delayMove-=1;
    }
    pathFound=0;
    
};
void initIm(){
	floor = b.get(211,148,20,20);
    wall = b.get(274,253,20,20);
    pLeft.push(b.get(85,64,20,20));
    pLeft.push(b.get(106,64,20,20));
    pLeft.push(b.get(127,64,20,20));
    pLeft.push(b.get(148,64,20,20));

    pRight.push(b.get(85,85,20,20));
    pRight.push(b.get(106,85,20,20));
    pRight.push(b.get(127,85,20,20));
    pRight.push(b.get(148,85,20,20));

    pDown.push(b.get(85,106,20,20));
    pDown.push(b.get(106,106,20,20));
    pDown.push(b.get(127,106,20,20));
    pDown.push(b.get(148,106,20,20));
    
    pUp.push(b.get(85,127,20,20));
    pUp.push(b.get(106,127,20,20));
    pUp.push(b.get(127,127,20,20));
    pUp.push(b.get(148,127,20,20));

    eLeft=b.get(85,43,20,20);
    eRight=b.get(106,43,20,20);
    eDown=b.get(127,43,20,20);
    eUp=b.get(148,43,20,20);

};

void initTm(){
    for (var i = 0; i < tmap.length; i++) {
        for (var j = 0; j < tmap[i].length; j++) {
            if(tmap[i][j]==="w"){
                image(wall,j*20,i*20);
            }
            else if(tmap[i][j]==="f"){
                image(floor,j*20,i*20);
            }
        }
    }
    
};

void setup(){
    size(400, 400,P2D); 
    frameRate(60);
    b = loadImage("tiles.png");
    initIm();
    initializeTilemap();
    p=new playerObj(1,1);
    e=new enemyObj(9,10);
    e1=new enemyObj(17,17);
    for (var i=0;i<cols;i++){
        blankGrid[i]=new Array(rows);
    }
    
    for (var i = 0; i < cols; i++) {
        for (var j = 0; j < rows; j++) {
            blankGrid[i][j]=new cell(i,j);
        }
    }

    for (var i = 0; i < cols; i++) {
        for (var j = 0; j < rows; j++) {
            blankGrid[i][j].addNeighbors(blankGrid);
        }
    }


    println(graph[2][2]);

};


void draw(){
    if(stage===0){
	background(255);
    initTm();
    
    p.display();
    p.control();

    e.display();
    text("Steps left: " + pathLen, 320, 10);
    e.calcPath();
    e.move();
    e1.display();
    e1.calcPath();
    e1.move();
    }
    else{
        background(255);
        textSize(20);
        text("Caught You!", 100, 100);
    }
};
