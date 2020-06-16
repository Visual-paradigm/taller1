import processing.video.*;

Movie myMovie;
PShader lumaShader,mask,ascii;
PImage image;

boolean toggle;
boolean luma;

int filterState = 2;
float masknum = 8.0;

void setup() {
  size(1920,540, P3D);   
  myMovie = new Movie(this, "chaves.mp4");  
  image = myMovie.get();
  myMovie.loop();  
  lumaShader = loadShader("lumashader.glsl");
  mask = loadShader("convolution.glsl");
  ascii = loadShader("asciifilter.glsl");
  
  ascii.set("iResolution", float(width), float(height));
  mask.set("imask", masknum);
}

void draw() {
  background(100); 
 
  if (myMovie.available()) { 
    background(255); 
    shaderLayer();
    myMovie.read();    
    image = myMovie.get(); 
    image(image,960, 0, 960,540);
    resetShader();
  }
  filterLayer();
  image(image, 0, 0,960,540);
  print("framecount  ");
  print(frameCount);
  print("  framerate  ");
  println(frameRate);  
}

void shaderLayer() {
  switch(filterState) {
  case 0:
    shader(lumaShader);
    break;
  case 1:
    shader(mask);
    break;
  }
}

void filterLayer() {
  switch(filterState) {
  case 2:
    filter(ascii);
    break;
  }
}
void keyPressed(){
  if(key=='n'){    
    filterState=1;
    masknum = constrain((masknum-1),5,12) ;
    mask.set("imask", masknum);
  } else if(key=='m'){    
    filterState=1;
    masknum = constrain((masknum+1),5,12) ;
    mask.set("imask", masknum);
  }
  if(key == 'z'){   
    filterState=0;
  }else if(key == 'x'){
    filterState=1;
  }else if(key == 'c'){
    filterState=2;
  }
}
