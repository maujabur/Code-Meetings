void cleanV(ArrayList<PVector> p) {
  for (int i = p.size()-1; i>0; i--) {
    if (p.get(i) == p.get(i-1)) {
      p.remove(i);
    }
  }
}

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

void bezierV(PVector v1, PVector c1, PVector c2, PVector v2) {
  bezier(v1.x,v1.y,c1.x,c1.y,c2.x,c2.y,v2.x,v2.y);
}
