ArrayList<PVector> points = new ArrayList<PVector>();

float seg_limit = 10; // aprox pixels por segmento

float seg_limit_sq = seg_limit*seg_limit;

void setup() {
  size(800, 800);
}

void draw() {
  background(222);

  stroke(80);
  strokeWeight(15);
  pointV(points);

  ArrayList<PVector> reduced = chaikin_reduce(points, seg_limit_sq);

  stroke(255, 0, 80);  
  strokeWeight(1);
  lineV(reduced);

  strokeWeight(5);
  pointV(reduced);

  fill(0);
  text(reduced.size(), 20, 20);
}

void mousePressed() {
  points.add(new PVector(mouseX, mouseY));
}

void keyPressed() {
  points  = new ArrayList<PVector>();
}
