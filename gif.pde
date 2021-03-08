class gif {
  float frame = 0;
  int run_anim_length;
  PImage [] animation;
  

  gif (int len) {

    run_anim_length = len;
    animation = new PImage[run_anim_length];
  }


  void loadAnim() {
    for (int i = 1; i <= run_anim_length; i++) {
      String name = str(i) + ".png";
      animation [i - 1] = loadImage(name);
    }
  }

  void playAnim(float x, float y, float w, float h) {
    fill(255);
    scale(1, -1);
    //rect(x, -y, h, -h);
    image(animation[int(frame) % run_anim_length], x, -y, h, -h);
    frame += 0.2;
    scale(1, -1);
  }
}
