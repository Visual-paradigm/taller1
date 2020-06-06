PImage image;
PShader lumaShader;
boolean luma;

void setup() {
  size(1280, 720, P3D);  
  image = loadImage("Lenna.jpg");
  lumaShader = loadShader("lumashader.glsl");
}

void draw() {
  background(100);
  image(image,0,0);
  shader(lumaShader);  
  image(image,620,0);
  resetShader();
}

void keyPressed() {
  if (key == 'l') {
    shader(lumaShader);
  }
  else if (key == 'r') {
    resetShader();
  }
}
