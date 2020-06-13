/*
Mascara de convolución
Parte de este codigo fue extraido de https://processing.org/examples/convolution.html
*/

PImage img;
PGraphics withmask;

int w = 512;
int maskop = 0;
int center = 8;

boolean toggle;
float[][] matrix = {{ -1, -1, -1 },
            { -1, 9, -1 },
            { -1, -1, -1 }  };



void setup() {
  size(1024, 512);
  img = loadImage("Lenna.png"); 
  withmask = createGraphics(512, 512);
}

void draw() {
  image(img,0,0);
  withmask.beginDraw();
  withmask.image(img,0,0);
  drawFilter();     
  image(withmask, 512, 0); 
}

void drawFilter(){
  int xstart = 0;
  int ystart = 0;
  int matrixsize = 3;
  withmask.loadPixels();
  // Begin our loop for every pixel in the smaller image
  for (int x = xstart; x < withmask.width; x++) {
    for (int y = ystart; y < withmask.height  ; y++ ) {
      color c = convolution(x, y, matrix,matrixsize, withmask);
      int loc = x + y*withmask.width;
      withmask.pixels[loc] = c;
    }
  }
  withmask.updatePixels();
  withmask.endDraw();
  //image(nomask, 0, 0);
}

color convolution(int x, int y, float[][] matrix, int matrixsize, PImage img)
{
  float rtotal = 0.0;
  float gtotal = 0.0;
  float btotal = 0.0;
  //int offset = matrixsize / 2;
  for (int i = 0; i < matrixsize; i++){
    for (int j= 0; j < matrixsize; j++){
      // What pixel are we testing
      int xloc = x+i;//-offset;
      int yloc = y+j;//-offset;
      int loc = xloc + img.width*yloc;
      // Make sure we haven't walked off our image, we could do better here
      loc = constrain(loc,0,img.pixels.length-1);
      // Calculate the convolution
      rtotal += (red(img.pixels[loc]) * matrix[i][j]);
      gtotal += (green(img.pixels[loc]) * matrix[i][j]);
      btotal += (blue(img.pixels[loc]) * matrix[i][j]);
    }
  }
  // Make sure RGB is within range
  rtotal = constrain(rtotal, 0, 255);
  gtotal = constrain(gtotal, 0, 255);
  btotal = constrain(btotal, 0, 255);
  // Return the resulting color
  return color(rtotal, gtotal, btotal);
}

void keyPressed(){
  // Edge detection
  if(key == 'z'){    
    float[][] newmatrix = { { 0, -1, 0 },
            { -1, 4, -1 },
            { 0, -1, 0 } };
    matrix = newmatrix;
  }else if(key == 'x'){
    float[][] newmatrix = { { -5, 0, 0},
            { 0, 10, 0 },
            { 0, 0, -5 }};     
    matrix = newmatrix;
  }if(key == 'c'){    
    float[][] newmatrix = {{ -1, -1, -1 },
            { -1, 9, -1 },
            { -1, -1, -1 }};
    matrix = newmatrix;
  }else if(key == 'v'){
    float[][] newmatrix = { { 0.15, 0.15, 0.15 },
               { 0.15, 0.15, 0.15 },
               { 0.15, 0.15, 0.15 } };     
    matrix = newmatrix;
  }else if (key == 'e') {
    float[][] newmatrix = { { -2, -1,  0 },
               { -1,  1,  1 },
               {  0,  1,  2 } }; 
    matrix = newmatrix;
  }
  // Sobel operators
  else if (key == 'g') {
   float[][] newmatrix = { { -1, -2, -1 },
              { 0, 0, 0 },
              { 1, 2, 1 } }; 
    matrix = newmatrix;
  }
}
