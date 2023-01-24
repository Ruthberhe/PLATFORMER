class FGoomba extends FGameObject{
  int direction =L;
  int speed =50;
  int frame=0;
  
  FGoomba(float x, float y){
    super();
    setPosition(x, y);
    setName("goomba");
    setRotatable(false);
  }
  
  void act(){
    animate();
    collide();
    move();
  }
  
  void animate(){
      if (frame >= action.length) frame=0;
    if (frameCount % 5==0) {
      if (direction==R)  attachImage(goomba[frame]);
      if (direction==L)  attachImage(reverseImage(goomba[frame]));
      frame++;
    }
    
  }
  
  void collide(){
    if( isTouching("wall")){
      direction *=-1;
      setPosition(getX()+direction, getY());
    }
    
    if(isTouching("player")){
      world.remove(this);
     // enemies.remove(this);
    }
  }
  
  void move(){
    float vy= getVelocityY();
    setVelocity(speed*direction, vy);
  }
   PImage reverseImage( PImage image ) {
    PImage reverse;
    reverse = createImage(image.width, image.height, ARGB );

    for ( int i=0; i < image.width; i++ ) {
      for (int j=0; j < image.height; j++) {
        int xPixel, yPixel;
        xPixel = image.width - 1 - i;
        yPixel = j;
        reverse.pixels[yPixel*image.width+xPixel]=image.pixels[j*image.width+i] ;
      }
    }
    return reverse;
  }
}
