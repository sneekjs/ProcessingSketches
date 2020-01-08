boolean offset = true;
float widthPos = -100;
float heightPos = -100;
float shapeSize;

void setup() {
  fullScreen();
  shapeSize = width/50;
  colorMode(HSB);  
  noStroke();
  fill(0);
}

void draw() { 
  background(255);

  for(int x = 0; x < width/shapeSize + 100; x++)
    {    
      for(int y = 0; y < height/shapeSize + 100; y++)
      {
          float val = cos(frameCount/10.0 + x +y) * (shapeSize/5.0);
          //circle(widthPos + shapeSize, heightPos + shapeSize, shapeSize + val);
          triangle(widthPos + y%2 * shapeSize/2 + val, heightPos, widthPos + shapeSize/2 + y%2 * shapeSize/2+ val, heightPos + shapeSize, widthPos + shapeSize + (y%2 * shapeSize/2)+ val, heightPos);
        
        heightPos += shapeSize;
      }
      widthPos +=shapeSize;
      heightPos = 0 - shapeSize/2;
    }
    
  widthPos = -100;
  heightPos = -100;
}
