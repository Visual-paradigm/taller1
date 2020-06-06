PImage image;
PShader lumaShader;
PShape picture;
boolean luma;
float angle;

void setup() {
  size(1280, 720, P3D);  
  image = loadImage("Lenna.jpg");
  picture = createPicture(160,500,24,image);
  lumaShader = loadShader("convolution.glsl");
}

void draw() {
  background(100);
  translate(width/2, height/2);
  rotateY(angle);  
  shape(picture);
  angle += 0.01;
  
}

PShape createPicture(float r, float h,int detail, PImage tex) {
  /*textureMode(NORMAL);
  PShape sh = createShape();
  sh.beginShape(QUAD_STRIP);
  sh.noStroke();
  sh.texture(tex);
  sh.vertex(30, 30);
  sh.vertex(30+w, 30);
  sh.vertex(30, 30+h);
  sh.vertex(30+w, 30+h);
  sh.endShape();
  return sh;*/
  
  textureMode(NORMAL);
  PShape sh = createShape();
  sh.beginShape(QUAD_STRIP);
  sh.noStroke();
  sh.texture(tex);
  for (int i = 0; i <= detail; i++) {
    float angle = TWO_PI / detail;
    float x = sin(i * angle);
    float z = cos(i * angle);
    float u = float(i) / detail;
    sh.normal(x, 0, z);
    sh.vertex(x * r, -h/2, z * r, u, 0);
    sh.vertex(x * r, +h/2, z * r, u, 1);    
  }
  sh.endShape(); 
  return sh;
}


void keyPressed() {
  //luma = !luma;
  
  if (key == 'l') {
    shader(lumaShader);
  }
  else if (key == 'r') {
    resetShader();
  }
}
