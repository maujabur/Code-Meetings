int line_qt = 59;
int col_qt = 41;

float n_max = 8;
// altura em "linhas"

float w = 455;
float h = 560;

float xi, yi;
float dx, dy;

float ni = 0;

float curva[] = new float[col_qt+1];

void setup() {
  size(800, 800);

  xi = (width-w)/2;
  yi = (height-h)/2;

  dy = h/(line_qt-1);
  dx = w/col_qt;
  
  // precalcula "perfil" das linhas
  for (int col = 0; col <= col_qt; col++) {
    float c_col = (float)col_qt/2;
    float val = (col-c_col)*(col-c_col);
   val = map(val, 0, c_col*c_col, 1.1,0);
   val = constrain(val,0,1);
   val = val*val*val;
   val = val*val*val;
    curva[col] = val;
  }
}

void draw() {
  background(0);

  translate (xi, yi);

  for (int line = 0; line < line_qt; line++) {

    PShape caminho = createShape();
    caminho.beginShape();
    caminho.stroke (255);
    caminho.noFill();

    PShape fundo = createShape();
    fundo.beginShape();
    fundo.noStroke();
    fundo.fill(0);
    fundo.vertex(0, 0);
    for (int col = 0; col <= col_qt; col++) {

      float ny = noise((float)col/2.0, (float)line/2+ni)*n_max;

      float x = (float)col*dx;
      float y = -ny*dy*curva[col];
      caminho.vertex(x, y);
      fundo.vertex(x, y);
    }
    fundo.vertex(col_qt*dx, 0);

    caminho.endShape();
    fundo.endShape();

    shape(fundo,0,dy*line);
    shape(caminho,0,dy*line);
    
  }
  
  ni += 0.005;
}
