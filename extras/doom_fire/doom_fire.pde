// comandos de teclado: //<>//
// +, -, 0, 9, D

int fireWidthNormal = 60;
int fireHeightNormal = 40;

int fireWidthDebug = 24;
int fireHeightDebug = 16;

boolean debug = false;

int fireWidth = fireWidthNormal;
int fireHeight = fireHeightNormal;


int numberOfPixels = fireWidthNormal * fireHeightNormal;
int[] firePixelsArray = new int[numberOfPixels];

float side;

color fireColorsPalette[] = {
  color(7, 7, 7 ), 
  color(31, 7, 7 ), 
  color(47, 15, 7 ), 
  color(71, 15, 7 ), 
  color(87, 23, 7 ), 
  color(103, 31, 7 ), 
  color(119, 31, 7), 
  color(143, 39, 7 ), 
  color(159, 47, 7 ), 
  color(175, 63, 7 ), 
  color(191, 71, 7 ), 
  color(199, 71, 7 ), 
  color(223, 79, 7 ), 
  color(223, 87, 7 ), 
  color(223, 87, 7 ), 
  color(215, 95, 7 ), 
  color(215, 95, 7 ), 
  color(215, 103, 15 ), 
  color(207, 111, 15 ), 
  color(207, 119, 15 ), 
  color(207, 127, 15 ), 
  color(207, 135, 23 ), 
  color(199, 135, 23 ), 
  color(199, 143, 23 ), 
  color(199, 151, 31 ), 
  color(191, 159, 31 ), 
  color(191, 159, 31 ), 
  color(191, 167, 39 ), 
  color(191, 167, 39 ), 
  color(191, 175, 47 ), 
  color(183, 175, 47 ), 
  color(183, 183, 47 ), 
  color(183, 183, 55 ), 
  color(207, 207, 111 ), 
  color(223, 223, 159 ), 
  color(239, 239, 199 ), 
  color(255, 255, 255), 
};


void setup() {
  size (1200, 800);

  fire_start();
}

void draw() {
  background(#63431c);
  calculateFirePropagation();
}

void fire_start() {
  createFireDataStructure();
  createFireSource();

  //setInterval(calculateFirePropagation, 50)
  frameRate(20);
}

void createFireDataStructure() {
  numberOfPixels = fireWidth * fireHeight;
  numberOfPixels = fireWidth * fireHeight;
  firePixelsArray = new int[numberOfPixels];

  side = min((float)width/(float)fireWidth, (float)height/(float)fireHeight);


  for (int i = 0; i < numberOfPixels; i++) {
    firePixelsArray[i] = 0;
  }
}

void createFireSource() {
  for (int column = 0; column < fireWidth; column++) {
    int overflowPixelIndex = fireWidth * fireHeight;
    int  pixelIndex = (overflowPixelIndex - fireWidth) + column;

    firePixelsArray[pixelIndex] = 36;
  }
}

void calculateFirePropagation() {
  for (int column = 0; column < fireWidth; column++) {
    for (int row = 0; row < fireHeight; row++) {
      int pixelIndex = column + ( fireWidth * row );

      updateFireIntensityPerPixel(pixelIndex);
    }
  }

  renderFire();
}


void updateFireIntensityPerPixel(int currentPixelIndex) {
  int belowPixelIndex = currentPixelIndex + fireWidth;

  // below pixel index overflows canvas
  if (belowPixelIndex >= fireWidth * fireHeight) {
    return;
  }

  int decay = int(random(3));
  int belowPixelFireIntensity = firePixelsArray[belowPixelIndex];
  int newFireIntensity =
    belowPixelFireIntensity - decay >= 0 ? belowPixelFireIntensity - decay : 0;

  if (currentPixelIndex - decay >= 0 && currentPixelIndex - decay < numberOfPixels) {
    firePixelsArray[currentPixelIndex - decay] = newFireIntensity;
  }
}

void renderFire() {
  noStroke();
  for (int row = 0; row < fireHeight; row++) {
    for (int column = 0; column < fireWidth; column++) {
      int pixelIndex = column + ( fireWidth * row );
      int  fireIntensity = firePixelsArray[pixelIndex];
      //int  color = fireColorsPalette[fireIntensity]
      fill (fireColorsPalette[fireIntensity]);

      if (debug != true) {
        rect (column*side, row*side, side, side);
      } else
      {
        textAlign(CENTER, CENTER);
        textSize (side*0.4);
        text(fireIntensity+"", column*side, (row+0.2)*side, side, side*0.8);
        stroke(0);
        noFill();
        rect (column*side, row*side, side, side);
        fill(#927450);
        textAlign(RIGHT, TOP);
        textSize (side*0.2);
        text(pixelIndex+"", column*side, row*side, side*0.95, side);
      }
    }
  }
}

void keyPressed() {
  switch (key) {
  case 'd':
  case 'D':
    toggleDebugMode();
    break;

  case '+':
  case '=':
    increaseFireSource();
    break;

  case '-':
  case '_':
    decreaseFireSource();
    break;

  case '9':
  case '(':
    createFireSource();
    break;

  case '0':
  case ')':
    destroyFireSource();
    break;
  }
}

void toggleDebugMode() {
  if (debug == false) {
    fireWidth = fireWidthDebug;
    fireHeight = fireHeightDebug;
    debug = true;
  } else {
    fireWidth = fireWidthNormal;
    fireHeight = fireHeightNormal;
    debug = false;
  }

  createFireDataStructure();
  createFireSource();
}


void destroyFireSource() {
  for (int column = 0; column < fireWidth; column++) {
    int overflowPixelIndex = fireWidth * fireHeight;
    int pixelIndex = (overflowPixelIndex - fireWidth) + column;

    firePixelsArray[pixelIndex] = 0;
  }
}


void increaseFireSource() {
  for (int column = 0; column < fireWidth; column++) {
    int overflowPixelIndex = fireWidth * fireHeight;
    int pixelIndex = (overflowPixelIndex - fireWidth) + column;
    int currentFireIntensity = firePixelsArray[pixelIndex];

    if (currentFireIntensity < 36) {
      int increase = int(random(14));
      int newFireIntensity =
        currentFireIntensity + increase >= 36 ? 36 : currentFireIntensity + increase;

      firePixelsArray[pixelIndex] = newFireIntensity;
    }
  }
}

void decreaseFireSource() {
  for (int column = 0; column < fireWidth; column++) {
    int overflowPixelIndex = fireWidth * fireHeight;
    int pixelIndex = (overflowPixelIndex - fireWidth) + column;
    int currentFireIntensity = firePixelsArray[pixelIndex];

    if (currentFireIntensity > 0) {
      int decay = int(random(14));
      int newFireIntensity =
        currentFireIntensity - decay >= 0 ? currentFireIntensity - decay : 0;

      firePixelsArray[pixelIndex] = newFireIntensity;
    }
  }
}
