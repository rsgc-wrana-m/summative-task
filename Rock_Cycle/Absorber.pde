//This represents the player during the second levels.  Both player and absorber had the potential to extend a broader superclass, I designed the program without this in mind
class Absorber {

  RVector location;
  RVector velocity;
  RVector acceleration;
  boolean dead;
  int totalCollected;
//The player begins at the co-ordintes 50,50 with no velocity or acceleration
  Absorber() {
    location = new RVector(50, 50);
    velocity = new RVector(0, 0);
    acceleration = new RVector(0, 0);
    totalCollected = 0;
  }

  void moveLeft() {
    velocity.x  = velocity.x-0.25;
  }

  void moveRight() {
    velocity.x  = velocity.x+0.25;
  }
  //when this method is called, move the player to their initial starting location, and set their velocity and acceleration to 0
  void restart() {
    location = new RVector(50, 50);
    velocity = new RVector(0, 0);
    acceleration = new RVector(0, 0);
  }
  
  void update(ArrayList<Integer[]> dropletLocations) {
    //If the user has not absorbed the required number of droplets, continue drawing them
    if (!completed()) {
      velocity = velocity.add(velocity, acceleration);
      location = location.add(location, velocity);
      ellipse(location.x, location.y, 25, 25);

      for (Integer[] droplet : dropletLocations) {
        ellipse(droplet[0], droplet[1], 15, 15);
      }
       //If the player has collided with a droplet, add to the droplets absorbed counter
      if (checkAbsorption(dropletLocations)) {
        totalCollected++;
      }
    }
  }
  //If the total collected counter is greater than *1*, return true
  boolean completed() {
    if (totalCollected>=1) return true;
    else return false;
  }

  boolean checkAbsorption(ArrayList<Integer[]> dropletLocations) {
    boolean result = false;
    int counter = 0;
    //In order to use the code I have already designed, I assumed the area of the droplet to be the largest square which can be inscribed in such a circle.  
    //Using pythagorean theorem, 2x^2 = d, where x is the length of the square, for 15, this value is 10.6
    for (Integer[] droplet : dropletLocations) {
      Integer[] dropletLocation = {Math.round(droplet[0]-10.6), Math.round(droplet[1]-10.6), 15, 15};
      for (int i=0; i<360; i+=36) {
        RVector point = new RVector(location.x, location.y);
        point.x = point.x + (cos(i)*12.5);
        point.y = point.y + (sin(i)*12.5);
        //Since the droplet is a "rectangle" I can use the checkCollision code which I have already wrote
        if (checkCollision(dropletLocation, point)) {
          result =  true;
          dropletAbsorbed = counter;
        }
      }
      counter++;
    }
    return result;
  }
  //if the player hits an edge, move them in the opposite direction, and reduce their movement speed by 25%
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

  //if the provided point is within the provided rectangle, return true
  boolean checkCollision(Integer[] rectangle, RVector point) {
    if (point.x>rectangle[0] && point.x<(rectangle[0]+rectangle[2]) && point.y > rectangle[1] && point.y<(rectangle[1]+rectangle[3])) {
      return true;
    } else return false;
  }
}