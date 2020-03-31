//Doble lienzo escala grises//

PImage image;
PImage image2;
boolean toggle;

void setup() {
  size(1024, 512);
  image = loadImage("Lenna.png");
  image2 = loadImage("Lenna.png");
}

void draw() {
  background(50);
  image(image, 0, 0);  
  textSize(30);
  text("click on the image", 128, 500);
  fill(255, 255,255);
  if(toggle)
    image(image2, 512, 0);
}

void complementary() {
  //image2.loadPixels();
  for (int i = 0; i < image.width * image.height; i++) {
    color c = image.pixels[i];
    image2.pixels[i] = color((red(c)+green(c)+blue(c))/3);
  }
  //image2.updatePixels();
}


void mouseClicked() {
  complementary();
  toggle = !toggle;
}
