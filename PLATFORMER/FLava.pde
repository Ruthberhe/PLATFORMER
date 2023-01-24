class FLava extends FGameObject{
   int frames;
  FLava(float x, float y){
    super();
    setPosition(x, y);
    setName("lava");
    setSensor(true);
    setStatic(true);
  
  }
  
  
  void act(){
     if(frames >= lava.length) frames=0;
    if(frameCount % 10==0){
      attachImage(lava[frames]);
      frames++;
    }
    
    
  }
    
    


}
