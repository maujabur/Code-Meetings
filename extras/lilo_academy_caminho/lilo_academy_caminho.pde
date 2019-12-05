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

int qt_points = 9;
float first_points[][] = {
  {-0.206, 0.652}, 
  {0.112, 0.753}, 
  {0.263, 0.534}, 
  {0.207, 0.290}, 
  {0.472, 0.560}, 
  {0.779, 0.422}, 
  {0.846, 0.812}, 
  {0.999, 0.530}, 
  {0.893, 0.000}, 
};

float seg_limit_sq = seg_limit*seg_limit;


ArrayList<PVector> points = new ArrayList<PVector>();

void setup() {
  fullScreen();
  init_points();
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
  draw_splash(reduced, 60, 120, 1, 8);

  noise_space = 200;
  translate (-20, 60);
  fill(255, 108, 167);
  draw_splash(reduced, 60, 120, 2, 6);

  popMatrix();
}

void mousePressed() {
  points.add(new PVector(mouseX, mouseY));

  println("{"+nfc(float(mouseX)/float(width), 3)+", "+nfc(float(mouseY)/float(height), 3)+"},");
}

void keyPressed() {
  points  = new ArrayList<PVector>();
}

void mouseDragged() {
  PVector mouse = new PVector(mouseX, mouseY);
  float dist = PVector.sub(mouse, points.get(points.size()-1)).magSq();

  if (dist > seg_limit_sq*9) {
    points.add(mouse);
  }
}

void init_points() {
  for (int i = 0; i< qt_points; i++) {
    points.add(new PVector(first_points[i][0]*width,first_points[i][1]*height));
  }
  
  println(points.size());
  
}
