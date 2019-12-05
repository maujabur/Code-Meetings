float noise_init_x = 0;
float noise_init_y = 1000;
float noise_init_r = 2000;
float noise_delta_space = 1;
float noise_delta_time = 0.0001;
float noise_space = 0;
float noise_time = 0;

void setup() {
  fullScreen();
}

void draw() {
  background (230);

  noise_time += noise_delta_time;
  noise_space = 0;

  noStroke();

  translate (0, height/2);
  fill(119, 58, 239);
  draw_splash(3, 75, 150, 1, 15);

  translate (0, 75);
  fill(168, 85, 177);
  draw_splash(6, 75, 150, 1, 12);

  translate (0, 75);
  fill(255, 108, 167);
  draw_splash(9,75, 150, 2, 10);
}
