

class player{
    var m_xpos,m_ypos,m_dir,isMoving;
    player(xpos,ypos){
        m_xpos = xpos;
        m_ypos = ypos;
        m_dir=0;
        isMoving=0;
    }
    void display(){
        fill(255);
        ellipse(m_xpos,m_ypos,10,10);
        if(isMoving){
            switch(m_dir)
            {
                case 0:
                    m_xpos+=1.0;
                    break;
                case 1:
                    m_xpos-=1;
                    break;
                case 2:
                    m_ypos-=1;
                    break;
                case 3:
                    m_ypos+=1;
                    break;
            }
        }
    }
    
}