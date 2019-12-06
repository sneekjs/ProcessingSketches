float yoff = 0.0;              // 2nd dimension of perlin noise
float beachLength = 500;       //the default length of the beach, without waves
float strokeThickness = 15;

//Wave intensity variables
float waveOffset;
float angle1;
float scalar = 120;
float beachHeight = 0;

void setup() {
  fullScreen();
}

void draw() {
  background(255, 219, 77);

  drawSea();
}

void drawSea(){
    fill(0, 204, 255);
    stroke(128, 229, 255);
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
      xoff += 0.05;
    }
    // increment y dimension for noise
    yoff += 0.01;
    vertex(width + strokeThickness, height + strokeThickness);    //corner down right
    vertex(-strokeThickness, height + strokeThickness);        //corner down left
    endShape(CLOSE);
}

void drawSunShade(){/*
    strokeWeight(0);

    float lastAngle = 0;
    boolean isWhite = true;
    for (int i = 0; i < 8; i++) {
      if(isWhite){
        fill(255);
      }else{
        fill(255, 0, 0);
      }
      arc(width/2, height/2, 70, 70, lastAngle, lastAngle+radians(45));
      lastAngle += radians(45);
      isWhite = !isWhite;
    }
    strokeWeight(10);
    stroke(255, 0, 0);
    point(width/2, height/2);
  }*/
}

float calcWaveHeight(){
  float angle = radians(angle1);
  
  waveOffset = height/2 + (scalar * sin(angle) + beachHeight);
  angle1 += 0.005f;
  return waveOffset; 
}
