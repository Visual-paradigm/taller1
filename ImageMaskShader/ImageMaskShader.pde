PImage image;
PShader lumaShader;
boolean luma;

void setup() {
  size(1024, 512, P3D);  
  image = loadImage("Lenna.jpg");
  lumaShader = loadShader("convolution.glsl");
}

void draw() {
  background(100);
  image(image,0,0);
  shader(lumaShader);  
  image(image,512,0);
  resetShader();
}

void keyPressed(){
  // TODO diferent masks
  if(key == 'z'){    
  /*  float[][] newmatrix = { { 0, -1, 0 },
            { -1, 4, -1 },
            { 0, -1, 0 } };
    matrix = newmatrix;*/
  }
}
