PShader luma,mask,ascii;
PImage image;

int filterState = 2;
float masknum = 8.0;

void setup() {
  size(1260, 630, P3D);
 
  //LOAD IN SHADERS
  luma = loadShader("lumashader.glsl");
  mask = loadShader("convolution.glsl");
  ascii = loadShader("asciifilter.glsl");
  
  ascii.set("iResolution", float(width), float(height));
  
  mask.set("imask", masknum);
    
  image = loadImage("lenna.jpg");  
}

//**********************************************************************

void draw() {  
  image(image,0,0);
  filterLayer();
  image(image, 630, 0);
}

void filterLayer() {
  switch(filterState) {
  case 0:
    filter(luma);
    break;
  case 1:
    filter(mask);
    break;
  case 2:
    filter(ascii);
    break;
  }
}

void keyPressed(){
  if(key=='n'){    
    filterState=1;
    masknum = constrain((masknum-1),5,13) ;
    mask.set("imask", masknum);
  } else if(key=='m'){    
    filterState=1;
    masknum = constrain((masknum+1),5,13) ;
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
