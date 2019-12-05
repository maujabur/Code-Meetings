// https://www.facebook.com/groups/acm.siggraph.digital.arts.community/permalink/2619525168084378/?sfnsn=wiwshmo&d=n&vh=i

float largura = 12;
float altura = largura*sin(radians(60));

float tela_largura = 357;
float tela_altura = 447;
void setup() {
  size(500, 500);
}

void draw() {
  background (255);
  fill (0);
  noStroke();
  translate(width/2, height/2);
  
  desenha_plano();
  
   translate(0.5*largura, 1.0*altura);
 
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

void desenha_triangulo(float x,float y) {
  pushMatrix();
  translate(x,y);
  triangle(-largura/2, -altura/2, 0, altura/2, largura/2, -altura/2);
  popMatrix();
}
