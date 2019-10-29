

class player{
    var m_xpos,m_ypos,m_dir,isMoving;
    var cset;
    var pDown,pLeft,pRight,pUp;
    player(xpos,ypos){
        cset=loadImage("character.png");
        m_xpos = xpos;
        m_ypos = ypos;
        m_dir=0;
        isMoving=0;
        state=1;
        prevState=0;
        pDown={drawSprite(0,0,32,32),drawSprite(0,1,32,32),drawSprite(0,2,32,32)};
        pLeft={drawSprite(1,0,32,32),drawSprite(1,1,32,32),drawSprite(1,2,32,32)};
        pRight={drawSprite(2,0,32,32),drawSprite(2,1,32,32),drawSprite(2,2,32,32)};
        pUp={drawSprite(3,0,32,32),drawSprite(3,1,32,32),drawSprite(3,2,32,32)};
    }
    void display(){
        //fill(255);
        //ellipse(m_xpos,m_ypos,10,10);
        
            switch(m_dir)
            {
                case 0://down
                    
                    switch(state){
                        
                        case 0:
                            image(pDown[state],m_xpos,m_ypos);
                            if(isMoving){
                                m_ypos+=1;
                                if( frameCount%10===0){
                                    state=1;
                                    prevState=0;
                                }
                            }
                            break;
                        case 1:
                            image(pDown[state],m_xpos,m_ypos);
                            if(isMoving){
                                m_ypos+=1;
                                if(frameCount%10===0){
                                    if(prevState===0){
                                        state=2;
                                        prevState=1;
                                    }
                                    else{
                                        state=0;
                                        prevState=1;
                                    }
                                }
                            }
                            break;
                        case 2:
                            image(pDown[state],m_xpos,m_ypos);
                            if(isMoving){
                                m_ypos+=1;
                                if( frameCount%10===0){
                                    state=1;
                                    prevState=2;
                                }
                            }
                            break;
                            
                            
                    }
                    break;
                case 1://left
                    
                    switch(state){
                        
                        case 0:
                            image(pLeft[state],m_xpos,m_ypos);
                            if(isMoving){
                                m_xpos-=1;
                                if(frameCount%10===0){
                                    state=1;
                                    prevState=0;
                                }
                            }
                            break;
                        case 1:
                            image(pLeft[state],m_xpos,m_ypos);
                            if(isMoving){
                                m_xpos-=1;
                                if(frameCount%10===0){
                                    if(prevState===0){
                                        state=2;
                                        prevState=1;
                                    }
                                    else{
                                        state=0;
                                        prevState=1;
                                    }
                                }
                            }
                            break;
                        case 2:
                            image(pLeft[state],m_xpos,m_ypos);
                            if(isMoving){
                                m_xpos-=1;
                                if(frameCount%10===0){
                                    state=1;
                                    prevState=2;
                                }
                            }
                            break;
                            
                            
                    }
                    break;
                case 2://right
                    
                    switch(state){
                        
                        case 0:
                            image(pRight[state],m_xpos,m_ypos);
                            if(isMoving){
                                m_xpos+=1;
                            if(frameCount%10===0){
                                state=1;
                                prevState=0;
                            }
                            }
                            break;
                        case 1:
                            image(pRight[state],m_xpos,m_ypos);
                            if(isMoving){
                                m_xpos+=1;
                                if(frameCount%10===0){
                                    if(prevState===0){
                                        state=2;
                                        prevState=1;
                                    }
                                    else{
                                        state=0;
                                        prevState=1;
                                    }
                                }
                            }
                            break;
                        case 2:
                            image(pRight[state],m_xpos,m_ypos);
                            if(isMoving){
                                m_xpos+=1;
                                if(frameCount%10===0){
                                    state=1;
                                    prevState=2;
                                }
                            }
                            break;
                            
                            
                    }
                    break;
                case 3://up
                    
                    switch(state){
                        
                        case 0:
                            image(pUp[state],m_xpos,m_ypos);
                            if(isMoving){
                                m_ypos-=1;
                                if(frameCount%10===0){
                                    state=1;
                                    prevState=0;
                                }
                            }
                            break;
                        case 1:
                            image(pUp[state],m_xpos,m_ypos);
                            if(isMoving){
                                m_ypos-=1;
                                if(frameCount%10===0){
                                    if(prevState===0){
                                        state=2;
                                        prevState=1;
                                    }
                                    else{
                                        state=0;
                                        prevState=1;
                                    }
                                }
                            }
                            break;
                        case 2:
                            image(pUp[state],m_xpos,m_ypos);
                            if(isMoving){
                                m_ypos-=1;
                                if(frameCount%10===0){
                                    state=1;
                                    prevState=2;
                                }
                            }
                            break;
                            
                            
                    }
                    break;
            }
    }
    PImage drawSprite(tileRow,tileCol,iWidth,iHeight){
        return cset.get(tileCol*32,tileRow*32,iWidth,iHeight);
    }
    
}