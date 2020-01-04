// The Nature of Code
// <http://www.shiffman.net/teaching/nature>
// Spring 2010
// Box2DProcessing example

// A circular particle

class Breakable {

  // We need to keep track of a Body and a radius
  Body body;
  float wdth;
  float hght;

  color col;
  
  boolean shouldDie = false;


  Breakable(float x, float y, float w, float h) {
    wdth = w;
    hght = h;
    // This function puts the particle in the Box2d world
    makeBody(x, y, w, h);
    body.setUserData(this);
    col = color(175, 0, 255);
  }

  // This function removes the particle from the box2d world
  void killBody() {
    box2d.destroyBody(body);
  }

  // Change color when hit
  void change() {
    shouldDie = true;
  }

  // 
  void display() {
    // We look at each body and get its screen position
    Vec2 pos = box2d.getBodyPixelCoord(body);
    // Get its angle of rotation
    float a = body.getAngle();
    
    rectMode(CENTER);
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(a);
    fill(col);
    stroke(255);
    strokeWeight(1);
    rect(0, 0, wdth, hght);
    popMatrix();
    
    if(!box2d.world.isLocked() && shouldDie)
    {
      box2d.destroyBody(body);
    }
  }
  
    boolean done() {
    if (shouldDie) {
      killBody();
      return true;
    }
    return false;
  }

  // Here's our function that adds the particle to the Box2D world
  void makeBody(float x, float y, float w, float h) {
    //Define the body
    PolygonShape sd = new PolygonShape();
    float box2dW = box2d.scalarPixelsToWorld(w/2);
    float box2dH = box2d.scalarPixelsToWorld(h/2);
    sd.setAsBox(box2dW, box2dH);
    
    // Define a fixture
    FixtureDef fd = new FixtureDef();
    fd.shape = sd;
    // Parameters that affect physics
    fd.density = 1;
    fd.friction = 0;
    fd.restitution = 1;
    
    // Define the body and make it from the shape
    BodyDef bd = new BodyDef();
    bd.type = BodyType.DYNAMIC;
    bd.position.set(box2d.coordPixelsToWorld(new Vec2(x, y)));
    bd.gravityScale = 0.0f;

    body = box2d.createBody(bd);
    body.createFixture(fd);
  }
}
