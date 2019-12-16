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
    fill(175);
    stroke(0);
    circle(0, 0, rad);
    popMatrix();
  }

  // This function adds the ball to the box2d world
  void makeBody(PVector center, float r) {
      // Define and create the body
      BodyDef bd = new BodyDef();
      bd.type = BodyType.KINEMATIC;
      bd.position.set(box2d.coordPixelsToWorld(center));
      body = box2d.createBody(bd);
  
      // Give it some initial random velocity
      body.setLinearVelocity(new Vec2(15, 15));
  
      // Make the body's shape a circle
      CircleShape cs = new CircleShape();
      cs.m_radius = box2d.scalarPixelsToWorld(r);
      
      FixtureDef fd = new FixtureDef();
      fd.shape = cs;
    
      fd.density = 1;
      fd.friction = 0;  // Slippery when wet!
      fd.restitution = 0.5;
  
      // Attach fixture to body
      body.createFixture(fd);
  
    }
}
