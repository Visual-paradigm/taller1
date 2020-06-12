import processing.video.*;
Movie myMovie;
PImage image;

boolean toggle;
PShader lumaShader;
boolean luma;

void setup() {
  size(1280,360, P3D);  
 // size(1280, 720, P3D);
  surface.setLocation(100, 100);
  frameRate(50);  
  myMovie = new Movie(this, "video3.mp4");  
  image = myMovie.get();
  myMovie.loop();  
 // image = loadImage("Lenna.jpg");
 lumaShader = loadShader("lumashader.glsl");
}

void draw() {
  background(100);
 // shader(lumaShader);  
 
    shader(lumaShader); 
  if (myMovie.available()) {   
    background(255);
    myMovie.read();    
    image = myMovie.get(); 
    image(image, 640, 0);
    resetShader();
  }
  image(image, 0, 0);
  //resetShader();
  print("framerate  ");
  print(frameRate);  
  print(" framecount  ");
  println(frameCount);
}
