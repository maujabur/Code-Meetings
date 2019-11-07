class Pad {
  int x = 0;
  int y = 0;
  int largura = width/30;
  int altura = height/5;
  color preenche = color(255, 0, 255);

  void show() {
    
    y = constrain(y, 0, height-altura);

    pushStyle();
    fill(preenche);
    noStroke();
    rect(x, y, largura, altura);
    popStyle();
  }
}
