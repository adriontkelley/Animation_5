//Christian Attard
//2015 @ introwerks 


///Modified by Adrion T. Kelley


int count  = 0;
int numFrames = 11;  // The number of frames in the animation
int currentFrame = 0;
PImage[] images = new PImage[numFrames];
String imageName;


PImage img;


color c;
int val;
int threshold;
final static int LEFT = 0;
final static int TOP = 1;

int mode = TOP; // glitch mode: LEFT, TOP.
float amt = 20.0; // threshold amount.

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

  
  size(568, 320);
  //println("christian attard, 2015 @ introwerks");
  
}

void draw() {
  
  count++;
       if(count == images.length) count = 1;
    img.copy(images[count], 0, 0, images[count].width, images[count].height, 
        0, 0, img.width, img.height);

  img.loadPixels();
  for (int i = 0; i < img.width-1; i++) {
    for (int j = 0; j < img.height-1; j++) {
      val = img.pixels[i+(j*img.width)];
      threshold = img.pixels[i+(j+1)*img.width];
      if (brightness(val) > brightness(threshold) + amt) { 
        switch(mode) {
        case LEFT:
          c = val;
          img.pixels[(i+1)+(j*img.width)] = c;
          break;
        case TOP:
          c = val;
          img.pixels[i+((j+1)*img.width)] = c;
          break;
        }
      }
    }
  }
  img.updatePixels();
  image(img, 0, 0); 
  
  
  //saveFrame("output/Art_####.png");
}