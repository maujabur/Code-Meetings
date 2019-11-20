float dx = 15;
float dy = 15;
float dw = 0;
float dh = -5;
float da = 0.0;
float dda = 0.001;
int direction = 1;

color[] cor =  {
  color(240), 
  color(255), 
};

float w, h;
float cx, cy;

void setup() {
  size(400, 400);
  
  surface.setTitle("Paper 1");
  surface.setResizable(true);
  surface.setLocation(100, 100);

  frameRate(15);

  noStroke();
  rectMode(CENTER);
}

void draw() {
  background(cor[0]);

  w = width;
  h = height;

  cx = width / 2;
  cy = height / 2;

  translate(cx, cy);
  while (w>2*dx && h > 2*dy) {

    rotate(da);
    fill(cor[0]);
    rect(0, 0, w, h);
    dec_wh();
    fill(cor[1]);
    rect(dw, dh, w, h);

    dec_wh();
  }
  da += direction*dda;
}

void dec_wh() {
  w -= dx;
  h -= dy;
}
