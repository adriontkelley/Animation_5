//Christian Attard
//2015 @ introwerks 
//Press 's' to export

//Modified by Adrion T. Kelley


final static int BLACK = 0;
final static int IMAGE = 1;
final static int NONE = 2;


final static int RED = 0;
final static int GREEN = 1;
final static int BLUE = 2;
final static int HUE = 3;
final static int SATURATION = 4;
final static int BRIGHTNESS = 5;
final static int NRED = 6;
final static int NGREEN = 7;
final static int NBLUE = 8;
final static int NHUE = 9;
final static int NSATURATION = 10;
final static int NBRIGHTNESS = 11;


final static int BLOCKS = 0;
final static int PYRAMIDS = 1;


int count  = 0;
int numFrames = 11;  // The number of frames in the animation
int currentFrame = 0;
PImage[] images = new PImage[numFrames];
String imageName;

PImage img;


float depth;


// modes: BLOCKS, PYRAMIDS. 
int mode = BLOCKS; 

// shape size.
int vSize = 10; 


// fill & stroke types: BLACK, IMAGE, NONE.
int fill_type = IMAGE;
int stroke_type = BLACK;


// channels for depth: RED, GREEN, BLUE, HUE, SATURATION, BRIGHTNESS, NRED, NGREEN, NBLUE, NHUE, NSATURATION, NBRIGHTNESS. 
int channel = BRIGHTNESS;
// depth ammount.
float channel_weight = 0.5;


float getChannel(color c) {
  int ch = channel>5?channel-6:channel;
  float cc;

  switch(ch) {
  case RED: 
    cc = red(c); 
    break;
  case GREEN: 
    cc = green(c); 
    break;
  case BLUE: 
    cc = blue(c); 
    break;
  case HUE: 
    cc = hue(c); 
    break;
  case SATURATION: 
    cc = saturation(c); 
    break;
  default: 
    cc= brightness(c); 
    break;
  }

  return channel_weight * (channel>5?255-cc:cc);
}


void setup() {
  
  frameRate(6);
  
  //img = loadImage(name + "." + type);
  for (int i = 1; i < numFrames; i++) {
        imageName = "Art_" + nf(i, 4) + ".png";
        images[i] = loadImage(imageName);

          println(imageName);
        //delay(1000);
       }
  
  
 
  
  img = new PImage(568,320);
  
  
  size(568, 320, P3D);
  //println("christian attard, 2015 @ introwerks");
}

void draw() {
  background(0);
  lights();
  
  count++;
       if(count == images.length) count = 1;
    img.copy(images[count], 0, 0, images[count].width, images[count].height, 
        0, 0, img.width, img.height);
  
  for (int i =0; i<img.width; i+=vSize) {
    for (int j =0; j<img.height; j+=vSize) {
      switch(mode) {
      case 0:
        blocks(i, j);
        break;
      case 1:
        pyramids(i, j);
        break;
      }
    }
  }
  
   //saveFrame("output/Art_####.png");
}

// blocks
void blocks(int x, int y) {  
  color c = img.pixels[x+(y*width)];
  depth = getChannel(c);
  pushMatrix();
  switch(fill_type) {
  case BLACK:
    fill(0);
    break;
  case IMAGE:
    fill(c);
    break;
  case NONE:
    noFill();
    break;
  }
  switch(stroke_type) {
  case BLACK:
    stroke(0);
    break;
  case IMAGE:
    stroke(c);
    break;
  case NONE:
    noStroke();
  }
  translate(x+(vSize/2), y+(vSize/2), -20);
  box(vSize, vSize, depth);
  popMatrix();
}


// pyramids
void pyramids(int x, int y) {
  color c = img.pixels[x+(y*width)];
  depth = getChannel(c);
  pushMatrix();
  switch(fill_type) {
  case BLACK:
    fill(0);
    break;
  case IMAGE:
    fill(c);
    break;
  case NONE:
    noFill();
    break;
  }
  switch(stroke_type) {
  case BLACK:
    stroke(0);
    break;
  case IMAGE:
    stroke(c);
    break;
  case NONE:
    noStroke();
  }
  translate(x, y);
  beginShape(TRIANGLE);
  vertex(0, 0, 0);
  vertex(0, vSize, 0);
  vertex(vSize/2, vSize/2, depth);

  vertex(0, vSize, 0);
  vertex(vSize, vSize, 0);
  vertex(vSize/2, vSize/2, depth);

  vertex(vSize, vSize, 0);
  vertex(vSize, 0, 0);
  vertex(vSize/2, vSize/2, depth);

  vertex(vSize, 0, 0);
  vertex(0, 0, 0);
  vertex(vSize/2, vSize/2, depth);
  endShape(CLOSE);
  popMatrix();
}