class Fplayer extends FGameObject {

  int frame;
  int direction;
  int lives, score;
  
 
  Fplayer() {
    super();
    setPosition(100, -100);
    direction= R;
    setName("player");
    setRotatable(false);
    setFillColor(green);
    lives=5;
    score=0;
  }

  void act() {
    fill(red);
     text("SCORE: "+score, width/3, 50);
   text("LIVES: "+ lives, width-200, 50);
   
    handleInput();
    animate();
    if (isTouching("spike")) {
      setPosition(100, -100);
      lives--;
    }
    
     if (isTouching("lava")) {
      setPosition(100, -100);
      lives--;
    }
    
  }

  void handleInput() {
    float vx= getVelocityX();
    float vy= getVelocityY();
    if (abs(vy)<0.1) action= idle;
    if (upkey) {
      player.setVelocity(vx, -300);
    }
    if (leftkey) {
      player.setVelocity(-300, vy);
      action= run;
      direction=L;
    }
    if (rightkey) {
      player.setVelocity(300, vy);
      action= run;
      direction= R;
    }
    if (abs(vy) >0.1) action=jump;
  }

  void animate() {
    if (frame >= action.length) frame=0;
    if (frameCount % 5==0) {
      if (direction==R)  attachImage(action[frame]);
      if (direction==L)  attachImage(reverseImage(action[frame]));
      frame++;
    }
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
