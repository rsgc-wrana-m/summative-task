//This represents the player during the first and *third* levels.  Both player and absorber had the potential to extend a broader superclass, I designed the program without this in mind
class Player {

  RVector location;
  RVector velocity;
  RVector acceleration;
  boolean dead;
  int totalCollected;

  //The player begins at the co-ordintes 30,30 with no velocity or acceleration
  Player() {
    location = new RVector(30, 30);
    velocity = new RVector(0, 0);
    acceleration = new RVector(0, 0);
  }

  void moveUp() {
    velocity.y  = velocity.y-0.25;
  }

  void moveLeft() {
    velocity.x  = velocity.x-0.25;
  }

  void moveRight() {
    velocity.x  = velocity.x+0.25;
  }

  void moveDown() {
    velocity.y  = velocity.y+0.25;
  }
  //when this method is called, move the player to their initial starting location, and set their velocity and acceleration to 0
  void restart() {
    location = new RVector(30, 30);
    velocity = new RVector(0, 0);
    acceleration = new RVector(0, 0);
  }
  //Check to see if the user is dead
  boolean dead(ArrayList<Integer[]> lossConditions) {
    boolean dead = false;
    //For each of the rectangles provided in the main method, check to see if the player has collided with them, if the player has, return true
    for (Integer[] rectangle : lossConditions) {
      for (int i=0; i<360; i+=36) {
        RVector point = new RVector(location.x, location.y);
        point.x = point.x + (cos(i)*12.5);
        point.y = point.y + (sin(i)*12.5);
        if (checkCollision(rectangle, point)) {
          dead = true;
        }
      }
    }

    if (dead) return true;
    else return false;
  }
  //If the player has collided with the victory zone, return true
  boolean level1Victory(Integer[] winZone) {
    if (checkCollision(winZone, location)) {
      return true;
    } else return false;
  }
  void update(ArrayList<Integer[]> lossConditions) {
    //If the player is not dead(based on the conditions provided in the main method), move them according to what they pressed
    if (!dead(lossConditions)) {
      checkEdges();
      velocity = velocity.add(velocity, acceleration);
      RVector randomVelocity = new RVector(random(-1, 1), random(-1, 1));
      location = location.add(location, randomVelocity);
      location = location.add(location, velocity);


      fill(175);
      //draw each rectangle in the canvas, based on the parameters provided in the main method
      for (Integer[] rectangle : lossConditions) {
        rect(rectangle[0], rectangle[1], rectangle[2], rectangle[3]);
      }
      //draw the player
      ellipse(location.x, location.y, 25, 25);
    } else {
      //if the player is dead, restart
      restart();
    }
  }

  void checkEdges() {
    //if the player hits an edge, move them in the opposite direction, and reduce their movement speed by 25%
    if (location.x >= width) {
      velocity.x = velocity.x*-0.75;
      location.x = width-5;
    } else if (location.x <= 0) {
      velocity.x = velocity.x*-0.75;
      location.x = 5;
    }
    if (location.y >= height) {
      velocity.y = velocity.y*-0.75;
      location.y = height-5;
    } else if (location.y <= 0) {
      velocity.y = velocity.y*-0.75;
      location.y = 5;
    }
  }
  //if the provided point is within the provided rectangle, return true
  boolean checkCollision(Integer[] rectangle, RVector point) {
    if (point.x>rectangle[0] && point.x<(rectangle[0]+rectangle[2]) && point.y > rectangle[1] && point.y<(rectangle[1]+rectangle[3])) {
      return true;
    } else return false;
  }
}