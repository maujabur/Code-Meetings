// variaveis

// int definir como variável inteira o eixo Y
// float = números não inteiros
float y=250;
float x = 250;

float vtotal = 2;
float angulo = radians(135);

// variável que define a variação incremental (delta) de Y. vai ser usada para definir o movimento do rect
float yvel=vtotal*sin(angulo);
float xvel=vtotal*cos(angulo);

//setup
void setup () {
  size (500, 500);
  println("xvel = "+xvel);
  println("yvel = "+yvel);
} 

//draw

void draw () {
  background (#f6f6f6);

  // desenhar um retângulo: posição X, posição Y, largura, altura
  // número negativo: flipa o objeto
  rect (x, y, 40, 20);

  // definir o movimento no eixo Y: a posição de Y deve ser igual a posição anterior + 1, a cada frame
  //ao invés de colocar y+1 indicamos a variação yvel
  y= y+yvel;
  x= x+xvel;


  // quando for definir um IF, é necessário colocar 2x o sinal de =
  // para evitar que seja necessário limitar as variações de velocidade à numeros que sejam multiplos da altura, definir como < ou > ao invés de == 
  if (y>500-20) {
    // inverte o delta da variável Y, fazendo o retângulo subir
    yvel=-yvel;
  }

  // bloco que define o limite superior do rect
  if (y<0) {
    // inverte o delta da variável Y, fazendo o retângulo descer
    yvel=-yvel;
  }
  
  if (x>500-40) {
    // inverte o delta da variável Y, fazendo o retângulo subir
    xvel=-xvel;
  }

  // bloco que define o limite superior do rect
  if (x<0) {
    // inverte o delta da variável Y, fazendo o retângulo descer
    xvel=-xvel;
  }
}
