//Christian Attard
//2015 @ introwerks 


///Modified by Adrion T. Kelley


int count  = 0;
int numFrames = 11;  // The number of frames in the animation
int currentFrame = 0;
PImage[] images = new PImage[numFrames];
String imageName;


PImage img;

color col;
int c;


int space =5; // space between lines
float weight = 1; // line weight
float depth = 0.9; // z depth
int zoom = 100; // zoom image

void setup() {
  
  frameRate(1);
  
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
  
  count++;
       if(count == images.length) count = 1;
    img.copy(images[count], 0, 0, images[count].width, images[count].height, 
        0, 0, img.width, img.height);
  

  for (int i = 0; i < img.width; i+=space) {
    beginShape();
    for (int j = 0; j < img.height; j+=space) {
      c = i+(j*img.width);
      col = img.pixels[c];
      stroke(red(col), green(col), blue(col), 255);
      strokeWeight(weight);
      noFill();
      vertex (i, j, (depth * brightness(col))-zoom);
    }
    endShape();
  }
  
  
  saveFrame("output/Art_####.png");
  
}