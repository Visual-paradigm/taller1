import processing.video.*;
Movie myMovie;
PImage image;

boolean toggle;
PShader lumaShader;
boolean luma;

void setup() {
  size(1920,540, P3D);  
 //chavo size(1840,720, P3D);  
  //surface.setLocation(100, 100);
  //frameRate(50);  
  myMovie = new Movie(this, "chaves.mp4");  
  image = myMovie.get();
  myMovie.loop();  
  lumaShader = loadShader("convolution.glsl");
}

void draw() {
  background(100); 
 
  shader(lumaShader); 
  if (myMovie.available()) {   
    background(255);
    myMovie.read();    
    image = myMovie.get(); 
    image(image,960, 0, 960,540);
    resetShader();
  }
  image(image, 0, 0,960,540);
  print("framecount  ");
  print(frameCount);
  print("  framerate  ");
  println(frameRate);  
}
