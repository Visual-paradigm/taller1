import processing.video.*;
Movie myMovie;
PImage image;

boolean toggle;

float[][] matrix = { { -1, -1, -1 },
                     { -1,  9, -1 },
                     { -1, -1, -1 } }; 

void setup() {
  size(1280,360);  
  surface.setLocation(100, 100);
  frameRate(5);  
  myMovie = new Movie(this, "video3.mp4");  
  image = myMovie.get();
  myMovie.loop();
}

void draw() {
 background(255);
  if (myMovie.available()) {   
    background(255);
    myMovie.read();
    processFrame();    
    image(image, 640, 0);
  }
  image(myMovie, 0, 0);  
   // processFrame();    
    //image(image, 640, 0);
}

void processFrame(){   
  
  int matrixsize = 3; 
  image = myMovie.get();
  
  for (int x = 0; x < image.width; x++) {
    for (int y = 0; y < image.height; y++ ) {
      color c = convolution(x, y, matrix, matrixsize, image);
      int loc = x + y*image.width;
      image.pixels[loc] = c;//image.set(x,y,c);
    //  color c2 = image.pixels[loc];
    //  image.pixels[loc] = color(0.299*red(c2)+0.587*green(c2)+0.114*blue(c2));
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
      // What pixel are we testing
  /*    int xloc = constrain(x+i-offset,0,img.width-0);
      int yloc = constrain(y+j-offset,0,img.height-0);
      rtotal += (red(img.get(xloc,yloc)) * matrix[i][j]);
      gtotal += (green(img.get(xloc,yloc)) * matrix[i][j]);
      btotal += (blue(img.get(xloc,yloc)) * matrix[i][j]);
      */
     int xloc = x+i-offset;
      int yloc = y+j-offset;
      int loc = xloc + img.width*yloc;
      // Make sure we haven't walked off our image, we could do better here
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
