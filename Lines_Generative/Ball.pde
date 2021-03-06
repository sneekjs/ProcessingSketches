float ballSpeed = 50;
float col = 0;
boolean colSwitch = false;
class Ball {

  // We need to keep track of a Body and a width and height
  Body body;
  float w;
  float h;
  float rad;
  
  // Constructor
  Ball(float x, float y, float r) {
    w = x;
    h = y;
    rad = r*2;
    makeBody(new PVector(x, y), r);
  }

  // This function removes the particle from the box2d world
  void killBody() {
    box2d.destroyBody(body);
  }

  // Is the particle ready for deletion?
  boolean done() {
    // Let's find the screen position of the particle
    Vec2 pos = box2d.getBodyPixelCoord(body);
    // Is it off the bottom of the screen?
    if (pos.y > height+w*h) {
      killBody();
      return true;
    }
    return false;
  }

  // Drawing the box
  void display() {
    // We look at each body and get its screen position
    Vec2 pos = box2d.getBodyPixelCoord(body);
    // Get its angle of rotation
    float a = body.getAngle();
       
    rectMode(CENTER);
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(-a);
    stroke(col, 255, 255, 100);
    noFill();
    circle(0, 0, rad);
    popMatrix();
    morphColor();
  }

  // This function adds the ball to the box2d world
  void makeBody(PVector center, float r) {
      // Define and create the body
      BodyDef bd = new BodyDef();
      bd.type = BodyType.DYNAMIC;
      bd.position.set(box2d.coordPixelsToWorld(center));
      bd.gravityScale = 0.0f;
      body = box2d.createBody(bd);
  
      // Give it some initial random velocity
      body.setLinearVelocity(new Vec2(ballSpeed, ballSpeed));
  
      // Make the body's shape a circle
      CircleShape cs = new CircleShape();
      cs.m_radius = box2d.scalarPixelsToWorld(r);
      
      FixtureDef fd = new FixtureDef();
      fd.shape = cs;
    
      fd.density = 1.5f;
      fd.friction = 0;  // Slippery when wet!
      fd.restitution = 0.5f;
  
      // Attach fixture to body
      body.createFixture(fd);
  
    }
    
    void setVelocity(){
      float x = ballSpeed;
      float y = ballSpeed;
      if(body.getLinearVelocity().x < 0)
      {
        x = -ballSpeed;
      }
      if(body.getLinearVelocity().y < 0)
      {
        y = -ballSpeed;
      }
      
      body.setLinearVelocity(new Vec2(x, y));
    }
}

void morphColor(){
  if(colSwitch){
      col -= 1;
    } else {
      col += 1;
    }
    if(col > 100){
      colSwitch = !colSwitch;
    }else if (col < 0){
      colSwitch = !colSwitch;
    }
}
