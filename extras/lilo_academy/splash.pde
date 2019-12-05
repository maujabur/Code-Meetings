void draw_splash(float step, float r_x, float r_y, float r_min, float r_max) {
  // float x = width/2;
  float y= 0;
  for (float x = 0; x<width; x += step) {
    pushMatrix();
    translate(x, 0);
    splash(r_x, r_y, r_min, r_max);
    popMatrix();
  }
}

void splash(float r_x, float r_y, float r_min, float r_max) {
  noise_space += noise_delta_space;
  float r = map(noise(noise_init_r+noise_time, noise_space), 0, 1, r_min, r_max);
  float dx = map(noise(noise_init_x+noise_time, noise_space), 0, 1, -r_x, r_x);
  float dy = map(noise(noise_init_y+noise_time, noise_space), 0, 1, -r_y, r_y);

  ellipse(dx, dy, r, r);
}
