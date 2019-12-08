
class monster{
    var m_xpos, m_ypos, m_width, m_height;
    var myId;
    var myImage;
    var myCRate;
    var myName;
    var bAt, bDef, bHP, bSpA, bSpD, bS;
    var ivAt, ivDef, ivHp, ivSpA, ivSpD, ivS;
    var isShiny;
    var myBoost;

    monster(id, xpos, ypos, boost){
        cset=loadImage("character.png");
        m_xpos = xpos;
        m_ypos = ypos;
        m_width = 100;
        m_height = 100;
        myId = id;
        myBoost = boost;
        isShiny = (random(1,(8192/boost))===1);
        myImage = getPokeImage(myId);
        myName = pokedex[id].ename;
        myCRate = pokedex[id].crate;
        ivAt = random(1,32);
        ivDef = random(1,32);
        ivHp = random(1,32);
        ivSpA = random(1,32);
        ivSpD = random(1,32);
        ivS = random(1,32);
        bAt = pokedex[id]['base']['Attack'];
        bDef = pokedex[id]['base']['Defense'];
        bHP= pokedex[id]['base']['HP'];
        bSpA = pokedex[id]['base']['Sp.Atk'];
        bSpD = pokedex[id]['base']['Sp.Def'];
        bS = pokedex[id]['base']['Speed'];


    }
    void display(){
        image(myImage,m_xpos,m_ypos, m_width, m_height);
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
        var a;
        if(isShiny){
            a = 1;
        }
        else{
            a = 0
        }
        var score = (10000/myCRate)+(a*(8192/myBoost))+bAt+bHP+bDef+bHP+bSpA+bSpD+bS+ivAt+ivHp+ivDef+ivHp+ivSpA+ivSpD+ivS;
        return round(score);
    }


}