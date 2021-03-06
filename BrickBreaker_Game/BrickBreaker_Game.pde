import shiffman.box2d.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.dynamics.contacts.*;

// A reference to our box2d world
Box2DProcessing box2d;

// A list we'll use to track fixed objects
ArrayList<Boundary> boundaries;
// A list for all of our rectangles
ArrayList<Breakable> breakables;

// Paddle values
float paddlePos;
float paddleWidth = 150;

// The paddle
Paddle paddle;

// The ball
Ball ball;

//Breakable values
float breakableSize = 100;
int xStartPos = width/1;
int yStartPos = height/1;
int blockGap = 150;
int amountOfRows = 12;
int amountPerRow = 5;

void setup() {
  fullScreen();
  smooth();

  // Initialize box2d physics and create the world
  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  box2d.listenForCollisions();
  // Create ArrayLists  
  breakables = new ArrayList<Breakable>();
  boundaries = new ArrayList<Boundary>();

  // Add a bunch of fixed boundaries
  boundaries.add(new Boundary(0, height, width*2, 10));       //bottom
  boundaries.add(new Boundary(0, 0, width*2, 10));            //top
  boundaries.add(new Boundary(0, 10, 10, height*2));          //left
  boundaries.add(new Boundary(width, 10, 10, height*2));      //right
  
  // Spawn Paddle
  paddle = new Paddle(0, height/1.1f, paddleWidth, 10);
  
  // Spawn Ball
  ball = new Ball(width/2, 800, 25);
  
  //Spawn breakables
  spawnBreakables();
}

void draw() {
  background(255);

  // We must always step through time!
  try
  {
    box2d.step();
  }
  catch (Exception e){
  }
  
  // Display all the boundaries
  for (Boundary wall: boundaries) {
    wall.display();
  }

  // Display all the boxes
  for (int i = breakables.size()-1; i >= 0; i--) {
    Breakable b = breakables.get(i);
    b.display();
    
    if(b.done())
    {
      breakables.remove(i);
    }
  }
  
  // Display paddle
  paddle.display();
  paddle.killBody();
  paddle = new Paddle(mouseX, height/1.1f, paddleWidth, 10);
  
  if(ball == null)
  {
    return;
  }
  // Display ball
  ball.display();
  ball.setVelocity();
  
  if(ball.done())
  {
    ball = null;
  }
}

void spawnBreakables()
{
  for(int x = xStartPos; x < xStartPos + amountOfRows * blockGap; x += blockGap)
  {
    for(int y = yStartPos; y < yStartPos + amountPerRow * blockGap; y += blockGap)
    {
        breakables.add(new Breakable(x, y, breakableSize, breakableSize/2)); 
    }
  }
}

// Collision event functions!
void beginContact(Contact cp) {
  // Get both fixtures
  Fixture f1 = cp.getFixtureA();
  Fixture f2 = cp.getFixtureB();
  // Get both bodies
  Body b1 = f1.getBody();
  Body b2 = f2.getBody();
  // Get our objects that reference these bodies
  Object o1 = b1.getUserData();
  Object o2 = b2.getUserData();

  if (o1==null || o2==null)
     return;

  // If object 1 is a Ball, then object 2 must be a breakable
  // Note we are ignoring particle on particle collisions
  if (o1.getClass() == Ball.class) {
    Breakable b = (Breakable) o2;
    b.change();
  } 
  // If object 2 is a Ball, then object 1 must be a Breakable
  else if (o2.getClass() == Ball.class) {
    Breakable b = (Breakable) o1;
    b.change();
  }
}


// Objects stop touching each other
void endContact(Contact cp) {
}

//use documentation http://box2d.org/manual.pdf
