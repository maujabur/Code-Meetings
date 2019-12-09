ArrayList<PVector> points = new ArrayList<PVector>();

float seg_limit = 5; // aprox pixels por segmento

float seg_limit_sq = seg_limit*seg_limit;

import processing.svg.*;
boolean record = false;

boolean show_bezier = true;
boolean show_chaikin = false;
boolean show_points = true;
boolean show_lines = true;

void setup() {
  size(800, 800);
}

void draw() {
  if (record) {
    beginRecord(SVG, "frame-####.svg");
  }

  background(0);

  stroke(180);
  strokeWeight(7);
  noFill();
  if (show_points)  pointV(points);
  strokeWeight(1);
  if (show_lines)  lineV(points);

  noFill();
  strokeWeight(3);
  stroke(255, 0, 80);
  if (show_bezier)  draw_bezier(points, 0.25);

  strokeWeight(1);
  stroke(0, 220, 80);
  if (show_chaikin)  lineV(chaikin_reduce(points, seg_limit_sq));

  fill(0);
  text(points.size(), 20, 20);

  if (record) {
    endRecord();
    record = false;
  }
}

void draw_bezier(ArrayList<PVector> points, float ratio) {
  int qt = points.size();

  if (qt <2) return;

  // precalc control vectors
  ArrayList<PVector> control = new ArrayList<PVector>();

  control.add(new PVector(0, 0));

  for (int i = 1; i< qt-1; i++) {
    PVector v1 = points.get(i-1);
    PVector v3 = points.get(i+1);
    control.add(PVector.sub(v3, v1));
  }
  control.add(new PVector(0, 0));

  beginShape();
  vertex(points.get(0).x, points.get(0).y);
  for (int i= 1; i<qt; i++) {
    PVector v1 = points.get(i-1);
    PVector c1 = control.get(i-1);

    PVector v2 = points.get(i);
    PVector c2 = control.get(i);

    c1 = PVector.add(v1, PVector.mult(c1, ratio));
    c2 = PVector.sub(v2, PVector.mult(c2, ratio));


    bezierVertex(c1.x, c1.y, c2.x, c2.y, v2.x, v2.y);
  }

  endShape();
}

void mousePressed() {
  points.add(new PVector(mouseX, mouseY));
}

void keyPressed() {
  switch(key) {
  case 'c':
  case 'C':
    points  = new ArrayList<PVector>();
    break;

  case 's':
  case 'S':
    record = true;
    break;

  case '1':
    show_bezier = !show_bezier;
    break;

  case '2':
    show_chaikin = !show_chaikin;
    break;

  case '3':
    show_lines = !show_lines;
    break;

  case '4':
    show_points = !show_points;
    break;
  }
}
