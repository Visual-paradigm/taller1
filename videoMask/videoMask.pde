import processing.video.*;
Movie myMovie;
PImage image;

boolean toggle;

float [][][] matrix = { 
                    { { -2, -2, -2},
                      { -2, 10, -2 },
                      { -2, -2, -2 } },
                    { { -6, 0, 0 },
                      { 0, 6, 0 },
                      { 0, 0, -6 } }
                 }; 

void setup() {
  size(1920,540);  
  //surface.setLocation(100, 100);
  //frameRate(5);  
  myMovie = new Movie(this, "chaves.mp4");  
  image = myMovie.get();
  myMovie.loop();
}

void draw() {
 background(255);
  if (myMovie.available()) {   
    background(255);
    myMovie.read();
    processFrame();    
    image(image, 960, 0, 960,540);
  }
  image(myMovie, 0, 0, 960,540);  
   // processFrame();    
    //image(image, 640, 0);
  print("framecount  ");
  print(frameCount);
  print("  framerate  ");
  println(frameRate);  
}

void processFrame(){   
  
  int matrixsize = 3; 
  image = myMovie.get();
  
  for (int x = 0; x < image.width; x++) {
    for (int y = 0; y < image.height; y++ ) {
      color c = convolution(x, y, matrix[0], matrixsize, image);
      int loc = x + y*image.width;
      if (toggle){   
        image.pixels[loc] = c;//image.set(x,y,c);
      }else {
        c = convolution(x, y, matrix[1], matrixsize, image);
        loc = x + y*image.width;
        image.pixels[loc] = c;        
      }
    }
  }
}

color convolution(int x, int y, float[][] matrix, int matrixsize, PImage img)
{
  float rtotal = 0.0;
  float gtotal = 0.0;
  float btotal = 0.0;
  int offset = matrixsize / 2;
  for (int i = 0; i < matrixsize; i++){
    for (int j= 0; j < matrixsize; j++){
     int xloc = x+i-offset;
      int yloc = y+j-offset;
      int loc = xloc + img.width*yloc;
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

void mouseClicked() {
  toggle = !toggle;
}

//TODO: Revisar metodo de selección de matriz
