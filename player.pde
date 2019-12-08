

class player{
    var m_xpos,m_ypos,m_dir,isMoving,m_total;
    var cset;
    var pDown,pLeft,pRight,pUp;
    var canMove;
    var runState;
    var m_speed;
    var curFrame;
    var notMoving;
    var frow,fcol;
    player(xpos,ypos){
        cset=loadImage("character.png");
        m_xpos = xpos;
        m_ypos = ypos;
        m_dir=0;
        isMoving=false;
        canMove=true;
        runState=false;
        notMoving=true;
        state=1;
        prevState=0;

    }
    void display(){
        //fill(255);
        //ellipse(m_xpos,m_ypos,10,10);
        //println(isMoving);
        if(runState){
            m_speed=2;
        }
        else{
            m_speed=1;
        }
        canMove=false;
        if(isMoving&&m_total<tileSize){
            
            if(m_dir === 0){//down
                m_ypos+=m_speed;
            }
            if(m_dir === 1){//left
                m_xpos-=m_speed;
            }
            if(m_dir ===2){//right
                m_xpos+=m_speed;
            }
            if(m_dir===3){//up
                m_ypos-=m_speed;
            }
            m_total+=m_speed;
            canMove=false;
        }
        if(m_total>=tileSize){
            isMoving=false;
            canMove=true;
            var push = m_total-tileSize;
            if(m_dir === 0){//down
                m_ypos-=push;
            }
            if(m_dir === 1){//left
                m_xpos+=push;
            }
            if(m_dir ===2){//right
                m_xpos-=push;
            }
            if(m_dir===3){//up
                m_ypos+=push;
            }
            m_total=0;
            if(curFrame===0){
                curFrame=1;
            }
            else{
                curFrame=0;
            }
        }
        animate();
    }
    void move(direction){
        m_dir=direction;
        isMoving=true;
    }
    void animate(){
        if(m_total<tileSize/2){
            if(runState){
                if(m_dir===0){
                    fcol=4;
                    frow=0;
                }
                else if(m_dir===1){
                    fcol=4;
                    frow=1;
                }
                else if(m_dir===2){
                    fcol=4;
                    frow=2;
                }
                else if(m_dir===3){
                    fcol=4;
                    frow=3;
                }
            }
            else if(runState===false){
                if(m_dir===0){
                    fcol=1;
                    frow=0;
                }
                else if(m_dir===1){
                    fcol=1;
                    frow=1;
                }
                else if(m_dir===2){
                    fcol=1;
                    frow=2;
                }
                else if(m_dir===3){
                    fcol=1;
                    frow=3;
                }
            }
        }

        if(m_total>=tileSize/2){
            if(curFrame===0&&runState){
                if(m_dir===0){
                    fcol=3;
                    frow=0;
                }
                else if(m_dir===1){
                    fcol=3;
                    frow=1;
                }
                else if(m_dir===2){
                    fcol=3;
                    frow=2;
                }
                else if(m_dir===3){
                    fcol=3;
                    frow=3;
                }
            }
            else if(curFrame===0&&runState===false){
                if(m_dir===0){
                    fcol=0;
                    frow=0;
                }
                else if(m_dir===1){
                    fcol=0;
                    frow=1;
                }
                else if(m_dir===2){
                    fcol=0;
                    frow=2;
                }
                else if(m_dir===3){
                    fcol=0;
                    frow=3;
                }
            }
            else if(curFrame===1&&runState){
                if(m_dir===0){
                    fcol=5;
                    frow=0;
                }
                else if(m_dir===1){
                    fcol=5;
                    frow=1;
                }
                else if(m_dir===2){
                    fcol=5;
                    frow=2;
                }
                else if(m_dir===3){
                    fcol=5;
                    frow=3;
                }
            }
            else if(curFrame===1&&runState===false){
                if(m_dir===0){
                    fcol=2;
                    frow=0;
                }
                else if(m_dir===1){
                    fcol=2;
                    frow=1;
                }
                else if(m_dir===2){
                    fcol=2;
                    frow=2;
                }
                else if(m_dir===3){
                    fcol=2;
                    frow=3;
                }
            }
        }
        sprite = drawSprite(frow,fcol,32,32);
        image(sprite,m_xpos,m_ypos);
    }

    PImage drawSprite(tileRow,tileCol,iWidth,iHeight){
        return cset.get(tileCol*32,tileRow*32,iWidth,iHeight);
    }
    
}