class Absorber {

  RVector location;
  RVector velocity;
  RVector acceleration;
  boolean dead;
  int totalCollected;
  int dropletAbsorbed;

  Absorber() {
    location = new RVector(50, height-50);
    velocity = new RVector(0, 0);
    acceleration = new RVector(0, 0);
    totalCollected = 0;
    dropletAbsorbed = 3;
  }

  void moveLeft() {
    velocity.x  = velocity.x-0.25;
  }

  void moveRight() {
    velocity.x  = velocity.x+0.25;
  }

  void restart() {
    location = new RVector(50, 50);
    velocity = new RVector(0, 0);
    acceleration = new RVector(0, 0);
  }
  //Check to see if the user is dead
  void update(ArrayList<Integer[]> dropletLocations) {

    if (!completed()) {
      velocity = velocity.add(velocity, acceleration);
      location = location.add(location, velocity);
      ellipse(location.x, location.y, 25, 25);

      for (Integer[] droplet : dropletLocations) {
        ellipse(droplet[0], droplet[1], 15, 15);
      }

      if (checkAbsorption(dropletLocations)) {
        totalCollected++;
      }
    }
  }

  boolean completed() {
    if (totalCollected>=3) return true;
    else return false;
  }

  boolean checkAbsorption(ArrayList<Integer[]> dropletLocations) {
    boolean result = false;
    int counter = 0;
    for (Integer[] droplet : dropletLocations) {
      Integer[] dropletLocation = {Math.round(droplet[0]-10.6), Math.round(droplet[1]-10.6), 15, 15};
      for (int i=0; i<360; i+=36) {
        RVector point = new RVector(location.x, location.y);
        point.x = point.x + (cos(i)*12.5);
        point.y = point.y + (sin(i)*12.5);
        if (checkCollision(dropletLocation, point)) {
          result =  true;
          dropletAbsorbed = counter;
        }
      }
      counter++;
    }
    return result;
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