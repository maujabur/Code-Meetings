// tamanho da aresta do cubo
float lado = 25;

// valores pre calculados para inclinação das laterais
float dx = 0.5;
float dy = 0.8660;

// ponto central para o brilho
float xp, yp;

// random walker
float t = 0;
float T = 1000;

//      ______
//     /\     \
//    /  \  c2 \
//   /    \_____\
//   \ c3 /     /
//    \  /  c1 /
//     \/_____/

// cores 
//top left, top right, bottom left, bottem right, center
color c1tl, c1tr, c1bl, c1br, c1c;
color c2tl, c2tr, c2bl, c2br, c2c;
color c3tl, c3tr, c3bl, c3br, c3c;

void setup() {
  size(400, 400);

  // inicializa cores 
  c1tl = color(#21384c);
  c1tr = color(#554f99);
  c1bl = color(#274482);
  c1br = color(#24274b);
  c1c = color(#b0b2c1);

  c2tl = color(#2c4588);
  c2tr = color(#424686);
  c2bl = color(#24848f);
  c2br = color(#186c9a);
  c2c = color(#a0ba9c);

  c3tl = color(#2c8cae);
  c3tr = color(#476968);
  c3bl = color(#1b2d49);
  c3br = color(#1b1c2f);
  c3c = color(#8dadbf);
}

void draw() {

  int linha = 0;
  // linhas pares tem deslocamento diferente das impares no eixo X

  for (float y = 0; y <= height + lado * dy; y += lado * dy) {
    // "porcentagem" do eixo Y
    float y_norm = map(y, 0, height, 0, 1);

    // deslocamento nas linhas pares
    float x_desloca = (linha % 2) * lado * dx * 3;

    for (float x = x_desloca; x <= width + lado * 3; x += lado * 6 * dx) {
      // "porcentagem" do eixo X
      float x_norm = map(x, 0, width, 0, 1);

      /**/
      // "walker" aleatorio
      xp = noise(t);
      xp = map(xp, 0, 1, 0, width);
      yp = noise(T);
      yp = map(yp, 0, 1, 0, height);
      t = t + 0.0001;
      T = T + 0.0001;
      float center_x = x - xp;
      float center_y = y - yp;
      float dist = center_x * center_x + center_y * center_y;
      float espalha = 18000;
      /**/

      // OU

      /*
      // ponto central
       float center_x = x - width/2 ;
       float center_y = y - height/2 ;
       float dist = center_x * center_x + center_y * center_y;
       float espalha =  width*height/5;
      /**/

      // "porcentagem" de efeito de cor "central"
      float d_norm = map(dist, 0, espalha, 1.0, 0.0);
      d_norm = constrain(d_norm, 0.0, 1.0);

      // calcula as cores baseadas na posição X,Y e distancia do ponto central
      color c1 = get_color(c1tl, c1tr, c1bl, c1br, c1c, x_norm, y_norm, d_norm);
      color c2 = get_color(c2tl, c2tr, c2bl, c2br, c2c, x_norm, y_norm, d_norm);
      color c3 = get_color(c3tl, c3tr, c3bl, c3br, c3c, x_norm, y_norm, d_norm);

      // desenha um cubo
      cube(x, y, c1, c2, c3);
    }
    linha++;
  }
}

// calcula a cor da face considerando 
// as cores dos vertices, do centro e as posições normalizadas
color get_color(
  color ctl, 
  color ctr, 
  color cbl, 
  color cbr, 
  color cc, 
  float x_norm, 
  float y_norm, 
  float d_norm
  ) 
{
  color ct = lerpColor(ctl, ctr, x_norm);
  color cb = lerpColor(cbl, cbr, x_norm);
  color c_ = lerpColor(ct, cb, y_norm);
  return lerpColor(c_, cc, d_norm);
}

// desenha um cubo de 3 faces aparentes
void cube(float x, float y, color c1, color c2, color c3) {
  pushMatrix();  
  translate(x, y);
  noStroke();
  
  // face
  fill(c1);
  beginShape();
  vertex(0, 0);
  vertex(lado, 0);
  vertex(lado * dx, lado * dy);
  vertex(lado * -dx, lado * dy);
  endShape(CLOSE);
  
  // face
  fill(c2);
  beginShape();
  vertex(0, 0);
  vertex(lado, 0);
  vertex(lado * dx, -lado * dy);
  vertex(lado * -dx, -lado * dy);
  endShape(CLOSE);
  
  // face
  fill(c3);
  beginShape();
  vertex(0, 0);
  vertex(lado * -dx, -lado * dy);
  vertex(-lado, 0);
  vertex(lado * -dx, lado * dy);
  endShape(CLOSE);
  popMatrix();
}
