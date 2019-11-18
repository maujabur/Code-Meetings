// TO DO:
// configurar posicao do prego com mouse dica: http://processing.org/reference
// implementar quadrantes de detecção melhorados 
// contar giros em torno do prego para desquebrar
//
// EXTRA
// fazer para dois pregos ou mais

float origem_x = 0;
float origem_y = 0;

float prego_x = 936.0;
float prego_y = 140.0;

// "inclinação" do prego em relação à origem
float inc_prego;

// distância ao quadrado do prego à origem
float prego_d2;

float inclina_antes;

int dir_quebra = 0; 
// ??
// 1 significa de cima pra baixo
// 0 significa não quebrou
// -1 significa de baixo pra cima

void setup() {
  fullScreen(2);
  textSize(40);
  recalc();
}

void draw() {
  background(#C5C5FA); // apaga a tela anterior

  float mouse_dx = mouseX - origem_x;
  float mouse_dy = mouseY - origem_y;
  
  float mouse_d2 = mouse_dx*mouse_dx+ mouse_dy*mouse_dy;

  // calcula a inclinação, sugestão usar atan2()
  float inclina =10000000; // evita o problema com a divisao por zero
  if (mouse_dy!=0) {
    inclina = mouse_dx/mouse_dy;
  }

  // desenha o prego
  fill(255, 0, 0);
  ellipse(prego_x, prego_y, 10, 10);
  text(inc_prego, prego_x, prego_y);
  
  if (mouse_d2 > prego_d2) {
    // distancia do nouse à origem é maior que a do prego

    if ( (inclina_antes > inc_prego) && (inclina <= inc_prego) )
    {       
      // de cima para baixo
      switch (dir_quebra) {
      case 0:
        dir_quebra = 1;
        break;

      case 1:
        // faz nada
        break;

      case -1:
        dir_quebra = 0;
        break;
      } // fim do switch
    } // fim do de cima pra baixo
    else if ( (inclina_antes <= inc_prego) && (inclina > inc_prego) )
    {       
      // de baixo para cima
      switch (dir_quebra) {
      case 0:
        dir_quebra = -1;
        break;

      case 1:
        dir_quebra = 0;
        break;

      case -1:
        // faz nada
        break;
      } // fim do switch
    } // fim do de baixo pra cima
  } // fim da area de interesse

  // desenha
  if (dir_quebra == 0) {
    // sem quebra
    stroke(0, 0, 0);
    line ( origem_x, origem_y, mouseX, mouseY);
  } else {
    //quebrado
    stroke(255, 0, 0);
    line ( origem_x, origem_y, prego_x, prego_y);

    stroke(0, 255, 0);
    line( prego_x, prego_y, mouseX, mouseY);
  }

  // info na tela
  fill(0);
  text(inclina, mouseX, mouseY);

  // atualiza inclição anterior
  inclina_antes = inclina;
}

void keyPressed() {
  // para debug
  dir_quebra = 0;
}

void mouseClicked() {
  if (mouseButton == LEFT) {
  prego_x= mouseX;
  prego_y = mouseY;
  } else if (mouseButton == RIGHT) {
  origem_x= mouseX;
  origem_y = mouseY;
  }
  recalc();
}

void recalc() {
  float dx = prego_x-origem_x;
  float dy = prego_y-origem_y;
  inc_prego = dx/dy;
  prego_d2 = dx*dx+dy*dy;
}
