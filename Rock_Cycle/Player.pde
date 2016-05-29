class Player {

  RVector location;
  RVector velocity;
  RVector acceleration;
  boolean dead;
  int totalCollected;

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

  void restart() {
    location = new RVector(50,50);
    velocity = new RVector(0, 0);
    acceleration = new RVector(0, 0);
  }
  //Check to see if the user is dead
  boolean dead(ArrayList<Integer[]> lossConditions) {
    boolean dead = false;
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
  boolean level1Victory(Integer[] winZone) {
    if (checkCollision(winZone, location)) {
      return true;
    } else return false;
  }
  void update(ArrayList<Integer[]> lossConditions) {

    if (!dead(lossConditions)) {
      checkEdges();
      velocity = velocity.add(velocity, acceleration);
      RVector randomVelocity = new RVector(random(-1, 1), random(-1, 1));
      location = location.add(location, randomVelocity);
      location = location.add(location, velocity);


      fill(175);
      for (Integer[] rectangle : lossConditions) {
        rect(rectangle[0], rectangle[1], rectangle[2], rectangle[3]);
      }
      ellipse(location.x, location.y, 25, 25);
    } else {
      restart();
    }
  }

  void checkEdges() {
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

  boolean checkCollision(Integer[] rectangle, RVector point) {
    if (point.x>rectangle[0] && point.x<(rectangle[0]+rectangle[2]) && point.y > rectangle[1] && point.y<(rectangle[1]+rectangle[3])) {
      return true;
    } else return false;
  }
}