Pad esquerdo;
Pad direito;

  // Pad tem os atributos x, y, largura, altura, preenche
  // e a função show()

void setup() {
  fullScreen();
  //size(600, 400);
  esquerdo = new Pad();
  direito = new Pad();
  direito.x = width-direito.largura; // pad direito no lado direito
}

void draw() {
  background(255);

  esquerdo.y = mouseY - esquerdo.altura/2;

  esquerdo.show();
  direito.show();

  fill(0); text(frameRate, 50, 20);
} // fecha draw

void keyPressed() { 
  if (key == 'w') {
    direito.y = direito.y -10;
  }
  
  if (key == 's') {
    direito.y = direito.y +10;
  }
}
