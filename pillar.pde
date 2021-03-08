class pillar {
  PVector pos;
  float pillarHeight;
  float pillarWidth;
  int mode;
  pillar() {
    mode = round(random(0, 1));
    pillarHeight = random(ground/3, width/1.5);
    switch(mode) {
    case 0:
      pos = new PVector(width, ground);
      break;
    case 1:
      pos = new PVector(width, height - roof - pillarHeight);
      break;
    }
    pillarWidth = random(ground/3, ground*2);
  }
  void move() {
    pos.x -= speed;
  }

  void show() {
    fill(50);
    rect(pos.x, pos.y, pillarWidth, pillarHeight);
  }
}

class topPillar {
  PVector pos;
  float pillarHeight;
  float pillarWidth;

  topPillar() {
    pos = new PVector(width, height-roof);
    pillarHeight = -random(ground/3, width/1.5);
    pillarWidth = random(ground/3, ground*2);
  }
  void move() {
    pos.x -= speed;
  }

  void show() {
    fill(50);
    rect(pos.x, pos.y, pillarWidth, pillarHeight);
  }
}
