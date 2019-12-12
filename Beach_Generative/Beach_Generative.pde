float yoff = 0.0;              // 2nd dimension of perlin noise
float beachLength = 500;       //the default length of the beach, without waves
float strokeThickness = 3;

//Wave intensity variables
float waveOffset;
float angle1;
float scalar = 120;
float beachHeight = 0;
float waveThicknessX = 0.04f;
float waveThicknessY = 0.01f;
float upDownSpeed = 0.0025f;

//SunShade variables
int maxSunShades = 15;
int sunShadeAmount;
ArrayList<PVector> sunShadePos = new ArrayList<PVector>();
ArrayList<Float> sunShadeRot = new ArrayList<Float>();

void setup() {
  fullScreen();
  background(255, 219, 77);
  sunShadeAmount = round(random(1, maxSunShades));
  for(int i = 0; i < maxSunShades; i++)
  {
    sunShadePos.add(new PVector(random(width), random(beachLength)));
    sunShadeRot.add(random(45));
  }
}

void draw() {
  //background(255, 219, 77);
  noStroke();
  fill(255, 219, 77, 10);
  rect(0, 0, width, height);
  drawSea();
  drawSunShade();
}

void drawSea(){
    fill(0, 204, 255);
    stroke(230, 184, 0);
    strokeWeight(strokeThickness);
    // We are going to draw a polygon out of the wave points
    beginShape(); 
    
    float xoff = 0;       // Option #1: 2D Noise
    //float xoff = yoff; // Option #2: 1D Noise
    
    // Iterate over horizontal pixels
    for (float x = -strokeThickness; x <= width+strokeThickness; x += 10) 
    {
      float y = map(noise(xoff, yoff), 0, 1, 200,300);
      
      vertex(x, y + calcWaveHeight());       // Set the vertex
      xoff += waveThicknessX;
    }
    // increment y dimension for noise
    yoff += waveThicknessY;
    vertex(width + strokeThickness, height + strokeThickness);    //corner down right
    vertex(-strokeThickness, height + strokeThickness);        //corner down left
    endShape(CLOSE);
}

void drawSunShade(){
    strokeWeight(0);

    boolean isWhite = true;
    for(int x = 0; x < sunShadeAmount; x++)
    {
      float lastAngle = sunShadeRot.get(x);
      strokeWeight(0);
      for (int i = 0; i < 8; i++) {
        if(isWhite){
          fill(255);
        }else{
          fill(255, 0, 0);
        }
        arc(sunShadePos.get(x).x, sunShadePos.get(x).y, 70, 70, lastAngle, lastAngle+radians(45));
        lastAngle += radians(45);
        isWhite = !isWhite;
      }
    strokeWeight(10);
    stroke(255, 0, 0);
    point(sunShadePos.get(x).x, sunShadePos.get(x).y);
    }
  }

float calcWaveHeight(){
  float angle = radians(angle1);
  
  waveOffset = height/2 + (scalar * sin(angle) + beachHeight);
  angle1 += upDownSpeed;
  return waveOffset; 
}
