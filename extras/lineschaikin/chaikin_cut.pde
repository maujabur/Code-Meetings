void cleanV(ArrayList<PVector> p) {
  for (int i = p.size()-1; i>0; i--) {
    if (p.get(i) == p.get(i-1)) {
      p.remove(i);
    }
  }
}

///////////////////////
ArrayList<PVector> chaikin_reduce(ArrayList<PVector> points, float seg_limit_sq) {
  ArrayList<PVector> reduced = new ArrayList<PVector>();
  reduced.addAll(points);

  int np = points.size();
  int nr = reduced.size();

  if (np > 1) {
    do {
      np = nr;
      reduced = chaikin_cut(reduced, 0.3, seg_limit_sq);

      nr = reduced.size();
    } while (nr>np) ;
  }
  
  return reduced;
}
///////////////////////
ArrayList<PVector> chaikin_cut(ArrayList<PVector> p, float ratio, float limit_sq) {
  ArrayList<PVector> n = new ArrayList<PVector>();

  if (p.size() > 0) {
    n.add(p.get(0));
  }

  if (p.size() >1) {
    for (int i = 1; i<p.size(); i++) {
      PVector v1 = p.get(i-1);
      PVector v2 = p.get(i);

      ArrayList<PVector> c = chaikin_cut(v1, v2, ratio, limit_sq);

      n.addAll(c);
    }

    n.add(p.get(p.size()-1));
  }

  cleanV(n);

  return n;
}


ArrayList<PVector> chaikin_cut(PVector a, PVector b, float ratio, float limit_sq) {

  ArrayList<PVector> n = new ArrayList<PVector>();

  if (PVector.sub(a, b).magSq()<=limit_sq) {
    n.add(a);
    n.add(b);
    return n;
  };

  /*
   * If ratio is greater than 0.5 flip it so we avoid cutting across
   * the midpoint of the line.
   */
  if (ratio > 0.5) ratio = 1 - ratio;

  ///* Find point at a given ratio going from A to B */
   n.add(PVector.lerp(a,b,ratio));

  /* Find point at a given ratio going from B to A */
   n.add(PVector.lerp(b,a,ratio));

  return n;
}
