
class monster{
    var m_xpos, m_ypos;
    var myId;
    var myImage;
    var myCRate;
    var myName;
    var bAt, bDef, bHP, bSpA, bSpD, bS;
    var ivAt, ivDef, ivHP, ivSpA, ivSpD, ivS;
    var m_width,m_height;
    var isShiny;
    var myBoost;
    monster(id, xpos, ypos, boost,width,height){
        cset=loadImage("character.png");
        m_xpos = xpos;
        m_ypos = ypos;
        myId = id;
        myBoost = boost;
        isShiny = (random(1,(8192/boost))===1);
        myImage = getPokeImage(myId);
        myName = pokedex[id-1].ename;
        myCRate = pokedex[id-1].crate;
        ivAt = random(1,32);
        ivDef = random(1,32);
        ivHp = random(1,32);
        ivSpA = random(1,32);
        ivSpD = random(1,32);
        ivS = random(1,32);
        bAt = pokedex[id-1]['base']['Attack'];
        bDef = pokedex[id-1]['base']['Defense'];
        bHP= pokedex[id-1]['base']['HP'];
        bSpA = pokedex[id-1]['base']['Sp.Atk'];
        bSpD = pokedex[id-1]['base']['Sp.Def'];
        bS = pokedex[id-1]['base']['Speed'];
        m_width = width;
        m_height = height;


    }
    void display(){
        image(myImage,m_xpos,m_ypos,m_width,m_height);
    }
    PImage getPokeImage(id){
        if(id>0 && id<=151){
            if(isShiny){
                return loadImage("./pokemon/shiny/"+id+".png");
            }
            else
                return loadImage("./pokemon/"+id+".png");
        }
        else{
            return null;
        }
    }

    int calcScore(){
        var a = 0;
        if(isShiny){
            a = 1;
        }
        else{
            a = 0;
        }
        return round((10000/myCRate)+(a*(8192))+bAt+bHP+bDef+bDef+bSpA+bSpD+bS+ivAt+ivHp+ivDef+ivHP+ivSpA+ivSpD+ivS);
    }


}