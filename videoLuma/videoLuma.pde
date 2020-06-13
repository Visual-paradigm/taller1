import processing.video.*;
Movie myMovie;
PImage image2;

void setup() {
  size(325, 245);
  //frameRate(200);
  myMovie = new Movie(this, "video1.mp4");
  image2 = myMovie.get();
  myMovie.loop();
  //myMovie.frameRate(200);
}

void draw() {
  if (myMovie.available()) {
    myMovie.read();
    processFrame();
  }
  image(image2, 0, 0);
  print("framerate  ");
  print(myMovie.frameRate);  
  print(" framecount  ");
  println(frameCount);
}

void processFrame(){
  image2 = myMovie.get();
  for (int i = 0; i < image2.width * image2.height; i++) {
    color c = image2.pixels[i];
    image2.pixels[i] = color((red(c)+green(c)+blue(c))/3);
  }
}
/*
void setup() {
  size(330, 250);
  myMovie = new Movie(this, "video1.mp4");
  image2 = myMovie.get();
  myMovie.play();
}

void draw() {
  //image(myMovie,10,10);
  image(image2,10,10);
}

void movieEvent(Movie m) {
  m.read();
  processFrame();
}

void processFrame(){
  for (int i = 0; i < myMovie.width * myMovie.height; i++) {
    color c = myMovie.pixels[i];
    image2.pixels[i] = color((red(c)+green(c)+blue(c))/3);
  }
}
*/
