boolean offset = true;
float widthPos = -100;
float heightPos = -100;
float shapeSize;

void setup() {
  fullScreen();
  stroke(255); 
  fill(0);
  shapeSize = width/30.0;
  
  background(255, 255, 0);
  for(int x = 0; x < width/shapeSize + 100; x++)
    {    
      for(int y = 0; y < height/shapeSize +100; y++)
      {
        triangle(widthPos + y%2 * shapeSize/2, heightPos, widthPos + shapeSize/2 + y%2 * shapeSize/2, heightPos + shapeSize, widthPos + shapeSize + (y%2 * shapeSize/2), heightPos);
        
        heightPos += shapeSize;
      }
      widthPos +=shapeSize;
      heightPos = 0;
    }
    
  widthPos = -100;
  heightPos = -100;
}

void draw() { 

}
