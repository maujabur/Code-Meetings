Pad esquerdo, direito;



// pontos iniciais do POD
float y=250;
float x = 250;

// velocidade e angulo inicial do pod
float vtotal = 5;
float angulo = radians(135);

// variável que define a variação incremental (delta) de Y e X.
//vai ser usada para definir o movimento do pod
float yvel=vtotal*sin(angulo);
float xvel=vtotal*cos(angulo);

void setup() {
  fullScreen();
  esquerdo = new Pad();
  direito = new Pad();
  direito.x = width-direito.largura; // pad direito no lado direito
}

void draw() {
  background(255); 
  //fill(0); 

  esquerdo.y = mouseY - esquerdo.altura/2;

  esquerdo.show();
  direito.show();

  // desenhar um retângulo: posição X, posição Y, largura, altura
  // número negativo: flipa o objeto
  rect (x, y, 40, 40);

  // definir o movimento no eixo Y: a posição de Y deve ser igual a posição anterior + 1, a cada frame
  //ao invés de colocar y+1 indicamos a variação yvel
  y= y+yvel;
  x= x+xvel;


  // COLISOES
  // pad da esquerda
  if (x < esquerdo.x + esquerdo.largura) {

    if (  (y >esquerdo.y - 40)   && (y< esquerdo.y+esquerdo.altura )   ) {

      xvel = -xvel; // reflexao sem mudar angulo
      x = esquerdo.x + esquerdo.largura;
    } // refletiu
    else {
      direito.placar++;
      x = width/2;
      y = height/2;
    }
  }

  // pad da direita
  if (x +40 > direito.x) {
    if (  (y >direito.y - 40)   && (y< direito.y+direito.altura )   ) {

      xvel = -xvel; // reflexao sem mudar angulo
      
      x = direito.x -40;
    } // refletiu
    else {
      esquerdo.placar++;
      x = width/2;
      y = height/2;
    }
  }


  ///// reflexao antiga

  // quando for definir um IF, é necessário colocar 2x o sinal de =
  // para evitar que seja necessário limitar as variações de velocidade à numeros que sejam multiplos da altura, definir como < ou > ao invés de == 
  if (y>height-40) {
    // inverte o delta da variável Y, fazendo o retângulo subir
    yvel=-yvel;
  }

  // bloco que define o limite superior do rect
  if (y<0) {
    // inverte o delta da variável Y, fazendo o retângulo descer
    yvel=-yvel;
  }

  if (x>width-40) {
    // inverte o delta da variável Y, fazendo o retângulo subir
    xvel=-xvel;
  }

  // bloco que define o limite superior do rect
  if (x<0) {
    // inverte o delta da variável Y, fazendo o retângulo descer
    xvel=-xvel;
  }


//placar

textSize(40);
fill(0);
text(esquerdo.placar,50,50);
text(direito.placar,width-50,50);

} // fecha draw

void keyPressed() { 
  if (key == 'w') {
    direito.y = direito.y - 10;
  } 
  if (key == 's') {
    direito.y = direito.y + 10;
  }
} // fecha keypressed
