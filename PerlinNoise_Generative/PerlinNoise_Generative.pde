float noisePer;
float with = 5;

void setup() 
{
  fullScreen();
  strokeWeight(with);
  strokeCap(PROJECT);
  background(0, random(255),random(255));

}

void makeNoise ()
{
   for(int x = 0; x < width+1; x += with)
   {
     for(int y = 0; y < height+1; y+= with)
     {
        noisePer = noise(x/(with * frameCount),y/(with * frameCount));
        stroke(255, 0, 0, 255*noisePer);
        noFill();
        point(x, y);
     }
   }
}

void draw() 
{
  background(0);
  makeNoise();
}
