// https://www.facebook.com/groups/acm.siggraph.digital.arts.community/permalink/2619525168084378/?sfnsn=wiwshmo&d=n&vh=i

float qt_largura = 30;
float qt_altura = 43;

float largura, altura, tela_largura, tela_altura;


void setup() {
  size(1000, 1000);
  largura = width/42;
  altura = largura*sin(radians(60));

  tela_largura = qt_largura*largura;
  tela_altura = qt_altura*altura;
}

void draw() {
  background (255);
  fill (0);
  noStroke();
  translate(width/2, height/2);

  desenha_plano();

  translate(1*largura, 0*altura);

  rotate(millis()/5000F);

  desenha_plano();
}

void desenha_plano() {
  int linha = 0;

  for (float y = -tela_altura/2; y<tela_altura/2; y += altura) {
    pushMatrix();
    translate( (largura/2) * (linha%2), y);
    linha++;
    for (float x = -tela_largura/2; x<tela_largura/2; x += largura) {
      desenha_triangulo(x, altura/2);
    }
    popMatrix();
  }
}

void desenha_triangulo(float x, float y) {
  pushMatrix();
  translate(x, y);
  triangle(-largura/2, -altura/2, 0, altura/2, largura/2, -altura/2);
  popMatrix();
}
