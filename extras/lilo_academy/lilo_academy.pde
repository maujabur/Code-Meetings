void setup() {
  size (800, 600); 

  background (230);

  // float x = width/2;
  for (float x = 0; x<width; x += 2) {
    // formula para a curva em x e y?
    float y= height/2;

    float r = random(1, 10);
    float dx = map(random(1), 0, 1, -75, 75);
    float dy = map(random(1), 0, 1, -75, 75);
    // como fazer uma distribuição não linear do random?

    // formula para fill?
    fill(#B88CF7);
    noStroke();

    ellipse(x+dx, y+dy, r, r);
  }
}
