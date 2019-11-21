int line_qt = 59;
int col_qt = 41;

float n_max = 93;

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
    val = map(val, 0, c_col*c_col, 1.1, 0);
    val = constrain(val, 0, 1);
    val = val*val*val;
    val = val*val*val;
    curva[col] = val;
  }

  colorMode(HSB, 100);
}

void draw() {
  background(0);

  translate (xi, yi);

  for (int line = 0; line < line_qt; line++) {

    float dados[] = calc_data((float)line / 2.0 + ni);

    pushMatrix();
    translate(0, dy*line);

    noStroke();
    fill(0);
    draw_fill(dados);

    int hue = (int)map((float)line/2.0 + ni, 0, (float)line_qt/2.0, 0, 100)%100;
    stroke (hue, 100, 100);
    noFill();
    strokeWeight(1.5+ 2*float(line)/float(line_qt));
    draw_lines(dados);
    popMatrix();
  }

  ni += 0.005;
}

float[] calc_data(float noise_y) {

  float[] y_array = new float[col_qt+1];

  for (int col = 0; col <= col_qt; col++) {

    float ny = noise(col / 2.0, noise_y) * n_max;
    y_array[col] = -ny  * (0.1 + curva[col]);
  } 
  return y_array;
}

void draw_lines(float[] y_array) {

  //for (int col = 0; col < y_array.length - 1; col++) {

  //  float x1 = dx * col;
  //  float x2 = dx * (col + 1);
  //  line(x1, y_array[col], x2, y_array[col + 1]);
  //}
  // linhas têm problema com strokeWeight(2.5), p.ex.
  // e apresentam pontos nas extremidades

  beginShape();

  for (int col = 0; col < y_array.length; col++) {

    float x = dx * col;
    vertex(x, y_array[col]);
  }

  endShape();
}

void draw_fill(float[] y_array) {

  beginShape();

  vertex(0, 0);
  for (int col = 0; col < y_array.length; col++) {

    float x = dx * col;
    vertex(x, y_array[col]);
  }

  vertex(col_qt * dx, 0);
  endShape();
}
