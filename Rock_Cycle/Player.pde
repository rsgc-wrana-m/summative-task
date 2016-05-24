class Player {

  RVector location;
  RVector velocity;
  RVector acceleration;
  boolean dead;

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

    velocity = new RVector(0, 0);
    acceleration = new RVector(0, 0);
  }

  boolean dead() {



    return false;
  }

  void update(ArrayList<Integer[]> lossConditions) {

    if (!dead()) {
      checkEdges();
      velocity = velocity.add(velocity, acceleration);
      RVector randomVelocity = new RVector(random(1), random(1));
      location = location.add(location, randomVelocity);
      location = location.add(location, velocity);


      fill(175);
      for (Integer[] rectangle : lossConditions) {
        rect(rectangle[0], rectangle[1], rectangle[2], rectangle[3]);
      }
      ellipse(location.x, location.y, 25, 25);
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
}