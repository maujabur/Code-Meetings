void pointV(ArrayList<PVector> p) {
  if (p.size() > 0) {
    for (int i = 0; i<p.size(); i++) {
      pointV(p.get(i));
    }
  }
}
void lineV(ArrayList<PVector> p) {
  beginShape();
  if (p.size() > 1) {
    for (int i = 0; i<p.size(); i++) {
      vertex(p.get(i).x, p.get(i).y);
    }
  }
  endShape();
}

void pointV(PVector v) {
  point(v.x, v.y);
}

void lineV(PVector v1, PVector v2) {
  line(v1.x, v1.y, v2.x, v2.y);
}
