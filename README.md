# Rock Cycle Game

## Overall goal

My summative task will use processing and vectors to simulate the rock cycle.

I will create different stages of a game in which the user is a rock going through the rock cycle.  

When a user completes the rock cycle, the game will be completed, however they can repeat the levels, since the rock cycle is infinte.

The different stages of the game will represent the different major stages in the rock cycle, interluded by short descriptions of what will happen in the next stage.
* Magma <------------
* Igneous Rock      |
* Sediment          |
* Sedimentary Rock  |
* Metamorphic Rock  |
* Magma ------------>

**What (if anything – although there is probably at least something) does the user need to know about what your program does?**

The user needs to understand that my program is a game, and their goal is to progress through the levels.

**What (if anything) does the user need to know to operate your program (keystrokes, et cetera)?**

None, all controls are given within the program.

**How does your program show evidence of your understanding of object-oriented programming concepts like encapsulation and inheritance?**
**What evidence can you provide that your program is human-readable?**
**For example, where have you used:**

**descriptive function names:** The check edges function checks to see if the player has reached the edge of the canvas...

```
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
```

**meaningful variable names:** The regions in which the user 'wins' and 'loses' the level are defined by 'winCondition' and 'lossConditions'...

```
  Integer[] winCondition = {width-70, 20, 50, 50};
  ArrayList<Integer[]> lossConditions = new ArrayList<Integer[]>();
```

**comments that describe the intention of a block of code:** This comment describes what the code does, and explains why I did it the way I did...

```
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
        }
      }
      counter++;
    }
```

**What is the most important algorithm, or algorithm(s), in your program?
That is, where is the "core idea" of your program?**

The core idea of my program is to create a game where the user interacts with the objects within their world.  I also wanted to do it in such a way where the level design can be changed with a minimal amount of additional coding.  Based on this, the most important sections of code are the ```update``` methods in ```Player``` and ```Absorber```

```
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
```
**Explain how this works.**

This method works by altering the player's velocity and position and acceleration functions, as well as drawing the rectangles which it has been passed, and checking to see if the player has collided with a rectangle.  Additionally, it resets the player when they collide with a rectangle.

**How have you made your program easy to use?**

From the perspective of the user, everything that needs to be done (i.e. pushing buttons) is told to the user before they start a level.

**How have you made correct use of source control?**
**For example, show that you have**
**made frequent commits:**

Commits made on May 13th are relatively frequent

**kept commits "atomic" (i.e.: one accomplishment per commit, rather than a batch of things all committed at once):**

d103dc63c22942c9ddf06a0c80ec826480127216  This commit only focuses on commenting what has already been written, and deleting one or two unnecessary lines.

**descriptive commit messages:**

3c6d4e4fad5ba427f624977d8a3b33a4672ee876  This commit provides a simple overall description of what was done, but also provides a more specfic description as to what exactly was done.



## Sub-goals

* extend Motion class (that we developed earlier together) to allow for the user to move and change velocity and acceleration with arrow keys
* Create "Magma" level in which the user tries to escape the convection currents, in order to become igneous rock
* Create "Igneous" level, in which the user tries to get "hit" by water droplets, in order to become sediment.
* Create "Sediment" level in which the user tries to avoid water flows, in order to be slowly cemented into sedementary rock
* Figure out how to display text and information, and create a transition system between levels


