float i = 0;
float x, y;
boolean goUp = false;
void setup()
{
  fullScreen();
  background(0);
  
  colorMode(HSB);
  x = width/2 + cos(i/100.0) * (width/2 - noise(i/100.0)*100.0);
  y = height/2 + sin(i/100.0) * (height/2 - noise(i/100.0)*100.0);
}

void draw()
{
  //background(255);
  
  translate(width/2, height/2);
  //orb();
  
  for(int j=0; j<100; j++)
  {
    rotate(1.24563);
    //step();
    orb();
  }
}

void orb(){
  stroke((frameCount/2)%255, 123, (frameCount)%255, 1);
  float v = cos(frameCount/94.242) * 500.0;
  float w = sin(frameCount/145.213) * 500.0;
  line(v, w, w, v);
}

void step(){
  strokeWeight(1);
  stroke(0, 23, 200,100);
  float r = sin(i/120.1235)*500 + noise(i/124.14) * 20.0;
  float x2 = sin(i/73.235) * (width/5.0 - noise(i/167.0)*100.0 + r);
  float y2 = sin(i/92.124) * (height/5.0 - noise(i/30.0)*100.0 + r);
  line(x,y, x2, y2);
  x = x2;
  y = y2;
  i+=1;
}
