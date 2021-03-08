player p;
pillar pi;
float speed = 15;
float ground;
float roof;
boolean loose = false;
void setup() {
  noSmooth();
  //fullScreen(P2D);
  size(1080, 1920, P3D);
  ground = height/4;
  roof = height/6;
  p = new player();
  pi = new pillar();
  p.loadImg();
  background(200);
  noStroke();
  mouseX = width/2;
  mouseY = height/2;
}


void draw() {
  if (loose == true) {
    delay(1000);
    loose = false;
  }
  translate(0, height);
  scale(1, -1);
  background(200);
  //-----------------------------------------------------------------------------------
  fill(0);
  rect(0, 0, width, ground);
  rect(0, height - roof, width, roof);
  pi.show();
  p.show();
  p.move(pi.mode);
  pi.move();
  if (p.collision(pi.pos.x, pi.pillarWidth, pi.pillarHeight, pi.mode)) {
    reset();
  }
  p.stick();

  if (pi.pos.x + pi.pillarWidth < 0) {
    pi = new pillar();
  }
}


void reset() {
  pi = new pillar();
  loose = true;
  background(0);
}
