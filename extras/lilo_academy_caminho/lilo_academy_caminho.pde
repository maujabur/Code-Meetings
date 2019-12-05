float noise_init_x = 0;
float noise_init_y = 1000;
float noise_init_r = 2000;
float noise_delta_space = 1;
float noise_delta_time = 0.0003;
float noise_space = 0;
float noise_time = 0;

float seg_limit = 3;

color linhas_ini = color(164, 232, 207);
color linhas_fim = color (210, 163, 169);

int qt_linhas = 17;

float seg_limit_sq = seg_limit*seg_limit;


ArrayList<PVector> points = new ArrayList<PVector>();

void setup() {
  fullScreen();
}

void draw() {
  background (230);

  noise_time += noise_delta_time;

  ArrayList<PVector> reduced = chaikin_reduce(points, seg_limit_sq);

  pushMatrix();
  for (int i = 0; i< qt_linhas; i++) {
    stroke(lerpColor(linhas_ini, linhas_fim, map(i, 0, qt_linhas-1, 0, 1)));
    lineV(reduced);
    translate(18.0, 2.0*sin(millis()/5000.0));
  }
  popMatrix();


  pushMatrix();
  scale(1.5);
  translate(0, -height/8);
  noStroke();

  noise_space = 0;
  fill(119, 58, 239);
  draw_splash(reduced, 60, 120, 1, 10);

  noise_space =   100;
  translate (-20, 60);
  fill(168, 85, 177);
  draw_splash(reduced, 60,120, 1, 8);

  noise_space = 200;
  translate (-20, 60);
  fill(255, 108, 167);
  draw_splash(reduced, 60, 120, 2, 6);

  popMatrix();
}

void mousePressed() {
  points.add(new PVector(mouseX, mouseY));
}

void keyPressed() {
  points  = new ArrayList<PVector>();
}

void mouseDragged() {
  points.add(new PVector(mouseX, mouseY));
}
