PImage image;
boolean toggle;
PFont f;
String asciichar = "$@B%8&WM#*oahkbdpqwmZO0QLCJUYXzcvunxrjft/|()1{}[]?-_+~<>i!lI;:,^`'. ";
int textSize=5;
void setup() {
  size(1260, 650);
  image = loadImage("lenna.jpg");
   f = createFont("Arial",textSize,true);
}

void draw() {
   f = createFont("Arial",textSize,true);
 background(255);
 fill(0);
 textFont(f);   
 asciiFunc();
 //noLoop();
 image(image, 630, 0);
}

void asciiFunc() {   
  for (int i = 0; i < image.width; i=i+textSize) {    
    for (int j = 0; j < image.height; j=j+textSize) {
      color c = image.get(i,j);
      int bright = (int) (red(c)+green(c)+blue(c))/3;
      int asciiEscale = asciichar.length();
      int charPosition = (bright*asciiEscale)/255;
      text(asciichar.charAt(charPosition),i,j);
    }
  }
  /*
  for (int i = 0; i < image.width * image.height; i=i+textSize) {
    color c = image.pixels[i];
    int bright = (int) (red(c)+green(c)+blue(c))/3;
    int asciiEscale = asciichar.length();
    int charPosition = (bright*asciiEscale)/255;
    text(asciichar.charAt(charPosition),i%image.width,y);
    if(i%image.width==0){
      y=y+textSize;
    }
  }*/
}

void keyPressed() {
  if(key=='c' && textSize<=20){
    textSize++;
  }
  if(key=='x' && textSize>1){
    textSize--;
  }
}
