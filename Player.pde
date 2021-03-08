class player {
  gif runAnim = new gif(14);
  PVector pos = new PVector(width/20, ground);
  float vel = 0;
  float acc = - speed/20;
  float sizeY = height/10;
  float sizeX = width/15;
  float stickWidth = width/50;
  float stickLength;
  float pillarH;
  PVector stick;
  boolean jumping = false;
  boolean newGround = false;
  boolean newRoof = false;

  void loadImg() {
    runAnim.loadAnim();
  }

  void show() {
    //fill(100);
    //rect(pos.x, pos.y, sizeX, sizeY);
    runAnim.playAnim(pos.x, pos.y, sizeX, sizeY);
  }

  void move(int mode) {
    float stand;
    float top;
    if (newGround == true && mode == 0) {
      stand = pillarH + ground;
    } else {
      stand = ground;
    }
    if (newRoof == true && mode == 1) {
      top = height - roof - pillarH;
    } else {
      top = height - roof;
    }

    if (pos.y > stand) {
      vel += acc;
      pos.y += vel;
    } else {
      pos.y = stand;
    }

    if (pos.y + sizeY > top)pos.y = top - sizeY;
  }

  void stick() {
    if (mouseY < roof) {
      ducking();
    } else if (height - mouseY < ground) {
      jumping = true;
      jump();
    } else {
      jumping = false;
      PVector stickHandle = new PVector(pos.x + sizeX/2, pos.y + sizeY/1.5);
      PVector mouse = new PVector(mouseX, height - mouseY);
      stick = mouse.sub(stickHandle);
      float angle = stick.heading();
      stickLength = stick.mag() + width/20;
      pushMatrix();
      translate(stickHandle.x, stickHandle.y);
      rotate(angle);
      translate(- width/20, 0);
      fill(255);
      rect(0, 0, stickLength, stickWidth);
      popMatrix();
    }
  }

  void jump() {
    if (stick.x > -pos.x*2) {
      vel = 0;
      PVector stickHandle = new PVector(pos.x + sizeX/2, pos.y + sizeY/1.5);
      stick.y = ground - stickHandle.y - width/20;
      float angle = stick.heading();
      stickLength = stick.mag();
      pushMatrix();
      translate(stickHandle.x, stickHandle.y);
      rotate(angle);
      translate(- width/20, 0);
      fill(255);
      rect(0, 0, stickLength, stickWidth);
      popMatrix();
      pos.y += sqrt(pow(stickLength, 2) - pow(stick.x - speed, 2)) + stick.y;
      stick.x -= speed;
    } else {
      jumping = false;
    }
  }

  boolean collision(float pillarPos, float pillarWidth, float pillarHeight, int mode) {
    pillarH = pillarHeight;
    newGround = false;
    if (pos.y > pillarHeight + ground + vel && pos.x + sizeX > pillarPos && mode == 0)newGround = true;
    if (pos.x > pillarPos + pillarWidth && mode == 0)newGround = false;
    if (pos.y + sizeY < height - roof - pillarHeight && pos.x + sizeX > pillarPos && mode == 1)newRoof = true;
    if (pos.x > pillarPos + pillarWidth && mode == 1)newRoof = false;

    if (pos.y < pillarHeight + ground && pos.x + sizeX > pillarPos && pos.x < pillarPos + pillarWidth && newGround == false && mode == 0) {
      return true;
    } else if (pos.y + sizeY > height - roof - pillarHeight && pos.x + sizeX > pillarPos && pos.x < pillarPos + pillarWidth && newRoof == false && mode == 1) {
      return true;
    } else {
      return false;
    }
  }

  void ducking() {
    if (stick.x > -pos.x*4) {
      PVector stickHandle = new PVector(pos.x + sizeX/2, pos.y + sizeY/1.5);
      stick.y = height - roof - stickHandle.y + width/20;
      float angle = stick.heading();
      stickLength = stick.mag();
      pushMatrix();
      translate(stickHandle.x, stickHandle.y);
      rotate(angle);
      translate(- width/20, 0);
      fill(255);
      rect(0, 0, stickLength, stickWidth);
      popMatrix();
      pos.y -= sqrt(pow(stickLength, 2) - pow(stick.x - speed, 2)) - stick.y;
      stick.x -= speed;
    }
  }
}
