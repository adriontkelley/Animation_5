//Christian Attard
//2015 @ introwerks


///Modified by Adrion T. Kelley


int count  = 0;
int numFrames = 11;  // The number of frames in the animation
int currentFrame = 0;
PImage[] images = new PImage[numFrames];
String imageName;


PImage img;
int c, n;



int wSize = 10; // wave size
int exp = 10; // number of frames to export 

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
  
  
  for (int x=0; x<img.width; x+=wSize) {
    for (int y=0; y<img.height; y+=wSize) {
      wave(x, y);
    }
  }
  

  
 //saveFrame("output/Art_####.png");
  
}

void wave(int w, int h) {
  for (int i=0; i<wSize; i++) {
    for (int j=0; j<wSize; j++) {
      color c = img.pixels[i+w+j+(h*width)];
      n = int(sin(i*count)*wSize);
      pushMatrix();
      fill(c);
      noStroke();
      rect(i+w, j+h+n, 1, 1);
      popMatrix();
    }
  }
}