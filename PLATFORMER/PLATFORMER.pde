import fisica.*;
FWorld world;


color white        =#FFFFFF;
color black        =#000000;   //spike
color green        =#0DFF00;
color red          =#FF0000;
color yellow       =#FFFF00;   //trampoline
color blue         =#0000FF;
color  purple      =#6F3198;
color  grey        =#A1A1A1;
color cyan          =#00BBFF;  //ice
color dbrown       =#765339;    //normal ground
color lbrown       =#FFAD60;
color middleGreen  =#00FF00;
color leftGreen    =#009F00;
color rightGreen   =#006F00;
color centerGreen  =#004F00;
color treeTrunkBrown  =#FF9500;



PImage MAP3, MAP4, MAP41, MAP412, brick, ice, spike, treetrunk, treeintersect, treetopc, treetope, treetopw, bridgec, bridgee, bridgew, bridgeRailsc, bridgeRailse, bridgeRailsw, trampoline, lava0, lava1, lava2, lava3, lava4, lava5, goomba0, goomba1, goomba2, idle0, idle1, jump0, runright1, runright2;
//Gif lva;
PImage[] lava;
PImage[] goomba;
PImage[] idle;
PImage[] jump;
PImage[] run;
PImage[] action;
int gridSize =32;
float zoom=1;
int lives, score;

Fplayer player;
ArrayList<FGameObject> terrain;



boolean wkey, akey, skey, dkey, upkey, downkey, rightkey, leftkey, spacekey;

void setup() {
  size(600, 400);
  Fisica.init(this);

  terrain = new ArrayList<FGameObject>();

  // MAP4= loadImage("MAP4.png");
  MAP41= loadImage("MAP4.1.png");
  MAP412= loadImage("MAP4.12.png");
  spike= loadImage("spike.png");
  brick= loadImage("brick.png");
  treetrunk= loadImage("tree_intersect.png");
  treeintersect= loadImage("tree_trunk.png");
  treetopc= loadImage("treetop_center.png");
  treetope= loadImage("treetop_e.png");
  treetopw= loadImage("treetop_w.png");
  ice= loadImage("blueBlock.png");
  bridgec= loadImage("bridge_center.png");
  bridgew= loadImage("bridge_w.png");
  bridgee= loadImage("bridge_e.png");
  bridgeRailsc= loadImage("bridgeRails_center.png");
  bridgeRailsw= loadImage("bridge_w.png");
  bridgee= loadImage("bridge_e.png");
  trampoline= loadImage("trampoline.png");
  goomba0= loadImage("goomba0.png");
  goomba1= loadImage("goomba1.png");
  goomba2= loadImage("goomba2.png");

  // lave
  lava= new PImage[6];

  lava[0] = loadImage("lava0.png");
  lava[1] = loadImage("lava1.png");
  lava[1] = loadImage("lava2.png");
  lava[3] = loadImage("lava3.png");
  lava[4] = loadImage("lava4.png");
  lava[5] = loadImage("lava5.png");


  //player
  idle = new PImage[2];
  idle[0] = loadImage("idle0.png");
  idle[1] = loadImage("idle1.png");

  jump = new PImage[1];
  jump[0] = loadImage("jump0.png");


  run= new  PImage[3];
  run[0] = loadImage("runright0.png");
  run[1] = loadImage("runright1.png");
  run[2] =  loadImage("runright2.png");

  action= idle;

//goomba
  goomba= new  PImage[3];
  goomba[0] = loadImage("goomba0.png");
  goomba[1] = loadImage("goomba1.png");
  goomba[2] =  loadImage("goomba2.png");

  //score and lives
  lives=2;
  score=0;

  loadWorld(MAP412);
  loadPlayer();
}

void loadWorld(PImage img) {
  world = new FWorld(-2000, -2000, 2000, 2000);
  world.setGravity(0, 900);

  for (int y=0; y<img.height; y++) {
    for (int x=0; x<img.width; x++) {
      color c=img.get(x, y);//current
      color s= img.get(x, y+1); //below
      color w= img.get(x-1, y);//west of pixel
      color e= img.get(x+1, y);//east of pixel

      FBox b= new FBox(gridSize, gridSize);
      b.setPosition(x*gridSize, y*gridSize);
      b.setStatic(true);

      if (c== dbrown) {
        b.attachImage(brick);
        b.setFriction(4);
        b.setName("stone");
        world.add(b);
      } else if (c==cyan) {
        b.attachImage(ice);
        b.setFriction(2);
        b.setName("ice");
        world.add(b);
      } else if (c==black) {
        b.attachImage(spike);

        b.setName("spike");
        world.add(b);
      } else if (c==lbrown) {
        b.attachImage(treetrunk);
        b.setSensor(true);

        b.setName("treetrunk");
        world.add(b);
      } else if (c==green && s== lbrown ) { //intersection
        b.attachImage(treeintersect);
        //   b.setSensor(true);
        b.setName("treetop");
        world.add(b);
      } else if (c==green && w==green && e==green) { //midpiece
        b.attachImage(treetopc);
        // b.setSensor(true);
        b.setName("treetop");
        world.add(b);
      } else if (c==green && w!=green) { //west
        b.attachImage(treetopw);
        //  b.setSensor(true);
        b.setName("treetop");
        world.add(b);
      } else if (c==green && e!= green) { //east
        b.attachImage(treetope);
        // b.setSensor(true);
        b.setName("treetop");
        world.add(b);
      } else if ( c==purple) {
        FBridge br = new FBridge(x*gridSize, y*gridSize);
        b.attachImage(bridgec);
        b.setName("bridge");
        terrain.add(br);
        world.add(br);
      } else if (c==yellow) {
        b.attachImage(trampoline);
        b.setRestitution(2);
        b.setName("trampoline");
        world.add(b);
      } else if (c==red) {
        FLava la = new FLava(x*gridSize, y*gridSize);
        la.setName("lava");
        terrain.add(la);
        world.add(la);
      }
    }
  }
}


void loadPlayer() {
  player = new Fplayer();
  world.add(player);
}

void draw() {
  background(black);
  drawWorld();
  actWorld();
}

void actWorld() {

  player.act();
  for (int i=0; i<terrain.size(); i++) {
    FGameObject t = terrain.get(i);
    t.act();
  }
}


void drawWorld() {
  pushMatrix();
  translate(-player.getX()*zoom+width/2, -player.getY()*zoom+height/2);
  scale(zoom);
  world.step();
  world.draw();
  popMatrix();
}
