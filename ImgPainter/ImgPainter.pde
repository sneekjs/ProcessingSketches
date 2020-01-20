String[] imgNames = {"VanGogh.jpg", "King.jpg", "Cos.jpg", "Cat.jpg", "Happy.png", "Obama.jpg", "PrettyLex.jpg"};
PImage img;
int imgIndex = 0;
int brushType = 0;

void nextImage() {
  //background(255);
  loop();
  frameCount = 0;
  
  img = loadImage(imgNames[imgIndex]);
  img.loadPixels();
  
  imgIndex += 1;
  if (imgIndex >= imgNames.length) {
    imgIndex = 0;
  }
}


void paintStroke(float strokeLength, color strokeColor, int strokeThickness) {
  float stepLength = strokeLength/4.0;
  
  // generate curve
  float tangent1 = 0;
  float tangent2 = 0;
  
  float odds = random(1.0);
  
  if (odds < 0.7) {
    tangent1 = random(-strokeLength, strokeLength);
    tangent2 = random(-strokeLength, strokeLength);
  } 
  
  // stroke
  noFill();
  stroke(strokeColor);
  strokeWeight(strokeThickness);
  curve(tangent1, -stepLength*2, 0, -stepLength, 0, stepLength, tangent2, stepLength*2);
  
  int z = 1;
  
  // details
  for (int num = strokeThickness; num > 0; num --) {
    float offset = random(-50, 25);
    color newColor = color(red(strokeColor)+offset, green(strokeColor)+offset, blue(strokeColor)+offset, random(100, 255));
    
    stroke(newColor);
    strokeWeight((int)random(0, 3));
    curve(tangent1, -stepLength*2, z-strokeThickness/2, -stepLength*random(0.9, 1.1), z-strokeThickness/2, stepLength*random(0.9, 1.1), tangent2, stepLength*2);
    
    z += 1;
  }
}


void setup() {
  fullScreen();
  
  nextImage();
}


void draw() {
  translate(width/2, height/2);
  
  int index = 0;
  
  for (int y = 0; y < img.height; y++) {
    for (int x = 0; x < img.width; x++) {
      int odds = (int)random(20000);
      
      if (odds < 1) {
        color pixelColor = img.pixels[index];
        pixelColor = color(red(pixelColor), green(pixelColor), blue(pixelColor), 100);
        
        pushMatrix();
        translate(x-img.width/2, y-img.height/2);
        rotate(radians(random(-90, 90)));
        
        // paint based on framecount
        if (brushType == 0) {
          // huge
          paintStroke(random(150, 250), pixelColor, (int)random(20, 40));
        } else if (brushType == 1) {
          // big
          paintStroke(random(75, 125), pixelColor, (int)random(8, 12));
        } else if (brushType == 2) {
          // small
          paintStroke(random(30, 60), pixelColor, (int)random(1, 4));
        } else if (brushType == 3) {
          // dots
          paintStroke(random(5, 20), pixelColor, (int)random(1, 3));
          paintStroke(random(5, 20), pixelColor, (int)random(1, 3));
        } else if (brushType == 4) {
          // dots
          paintStroke(random(4, 15), pixelColor, (int)random(1, 1));
          paintStroke(random(4, 15), pixelColor, (int)random(1, 1));          
          paintStroke(random(4, 15), pixelColor, (int)random(1, 1));

        }
        popMatrix();
      }
      index += 1;
    }
  }
}


void mousePressed() {
  nextImage();
}

void keyPressed()
{
  if(key == 'a') {
    brushType--;
  }else if (key == 'd') {
    brushType++;
  }
  if(brushType > 4){
    brushType = 4;
  }else if (brushType < 0) {
    brushType = 0;
  }
}
