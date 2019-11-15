// TO DO:
// configurar posicao do prego com mouse dica: http://processing.org/reference
// implementar quadrantes de detecção melhorados 
// contar giros em torno do prego para desquebrar
//
// EXTRA
// fazer para dois pregos ou mais
 
float prego_x = 936.0;
float prego_y = 140.0;
float inc_prego = prego_x/prego_y;

float inclina_antes;

int dir_quebra = 0; 
// ??
// 1 significa de cima pra baixo
// 0 significa não quebrou
// -1 significa de baixo pra cima

void setup() {
  fullScreen(2);
  textSize(40);
}

void draw() {
  background(#C5C5FA); // apaga a tela anterior

  // calcula a inclinação, sugestão usar atan2()
  float inclina =10000000; // evita o problema com a divisao por zero
  if (mouseY>0) {
    inclina = float(mouseX)/float(mouseY);
  }

  // desenha o prego
  fill(255, 0, 0);
  ellipse(prego_x, prego_y, 10, 10);
  text(inc_prego, prego_x, prego_y);

  if ( (mouseX> prego_x) && (mouseY>prego_y) ) {
    // está dentro da area de interesse

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
    line ( 0, 0, mouseX, mouseY);
  } else {
    //quebrado
    stroke(255, 0, 0);
    line ( 0, 0, prego_x, prego_y);

    stroke(0, 255, 0);
    line( prego_x, prego_y, mouseX, mouseY);
  }

// info na tela
  fill(0);
  text(dir_quebra, mouseX, mouseY);

  // atualiza inclição anterior
  inclina_antes = inclina;
}

void keyPressed() {
  // para debug
  dir_quebra = 0;
}
