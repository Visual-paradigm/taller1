import processing.video.*;
Movie myMovie;
PImage image2;
boolean toggle;
PFont f;
//String asciichar = "$$$@B%8&WM#*oahkbdpqwmZO0QLCJUYXzcvunxrjft/\\|()1{}[]?-_+~<>i!lI;:,^`'.   .";
String asciichar = "$$$$@@BB%%88&&WWMM##**ooaahhkkbbddppqqwwmmZZOO00QQLLCCJJUUYYXXzzccvvuunnxxrrjjfftt/\\||(())11{{}}[[]]??--__++~<<>>ii!!llII;;::,,^`'...   .";
int textSize=4;

void setup() {
  size(1904,720);  
  //surface.setLocation(100, 100);
  frameRate(30);
  myMovie = new Movie(this, "chaves.mp4");
  image2 = myMovie.get();
  myMovie.loop();
}

void draw() {
 f = createFont("Arial",textSize,true);
 background(255);
 fill(0);
 textFont(f);
  if (myMovie.available()) {   
    background(255);
    myMovie.read();
    processFrame();
  }
  image(myMovie, 952, 0);
}

void processFrame(){   
  image2 = myMovie.get();
  for (int i = 0; i < image2.width; i=i+textSize) {    
    for (int j = 0; j < image2.height; j=j+textSize) {
      color c = image2.get(i,j);
      int bright = (int) (red(c)+green(c)+blue(c))/3;
      int asciiEscale = asciichar.length();
      int charPosition = (bright*asciiEscale)/256;
      // println(bright*asciiEscale);
      text(asciichar.charAt(charPosition),i,j);
    }
  }
}
