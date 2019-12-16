import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;

// A reference to our box2d world
Box2DProcessing box2d;

// A list we'll use to track fixed objects
ArrayList<Boundary> boundaries;
// A list for all of our rectangles
ArrayList<Box> boxes;

// Paddle values
float paddlePos;
float paddleWidth = 150;

// The paddle
Paddle paddle;

// The ball
Ball ball;

void setup() {
  fullScreen();
  smooth();

  // Initialize box2d physics and create the world
  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  // We are setting a custom gravity
  box2d.setGravity(0, -10);

  // Create ArrayLists  
  boxes = new ArrayList<Box>();
  boundaries = new ArrayList<Boundary>();

  // Add a bunch of fixed boundaries
  boundaries.add(new Boundary(0, height, width*2, 10));       //bottom
  boundaries.add(new Boundary(0, 0, width*2, 10));            //top
  boundaries.add(new Boundary(0, 10, 10, height*2));          //left
  boundaries.add(new Boundary(width, 10, 10, height*2));      //right
  
  // Spawn Paddle
  paddle = new Paddle(0, height/1.1f, paddleWidth, 10);
  
  // Spawn Ball
  ball = new Ball(width/2, 800, 50);
}

void draw() {
  background(255);

  // We must always step through time!
  box2d.step();

  // Boxes fall from the top every so often
  if (random(1) < 0.2) {
    Box p = new Box(width/2,30);
    boxes.add(p);
  }

  // Display all the boundaries
  for (Boundary wall: boundaries) {
    wall.display();
  }

  // Display all the boxes
  for (Box b: boxes) {
    b.display();
  }

  // Boxes that leave the screen, we delete them
  // (note they have to be deleted from both the box2d world and our list
  for (int i = boxes.size()-1; i >= 0; i--) {
    Box b = boxes.get(i);
    if (b.done()) {
      boxes.remove(i);
    }
  }
  
  // Display paddle
  paddle.display();
  paddle.killBody();
  paddle = new Paddle(mouseX, height/1.1f, paddleWidth, 10);
  
  // Display ball
  ball.display();
}
