Pad esquerdo, direito;

void setup() {
  fullScreen();
  esquerdo = new Pad();
  direito = new Pad();
  direito.x = width-direito.largura; // pad direito no lado direito
}

void draw() {
  background(255); fill(0); 

  esquerdo.y = mouseY - esquerdo.altura/2;

  esquerdo.show();
  direito.show();

  text(frameRate, 50, 20);
} // fecha draw

void keyPressed() { 
  if (key == 'w') {
    direito.y = direito.y - 10;
  } 
  if (key == 's') {
    direito.y = direito.y + 10;
  }
} // fecha keypressed
