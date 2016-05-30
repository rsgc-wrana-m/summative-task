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

The core idea of my program is to create a game where the user interacts with the objects within their world.  I also wanted to do it in such a way where the level design can be changed with a minimal amount of additional coding.



Explain how this works.
How have you made your program easy to use?
How have you made correct use of source control?
For example, show that you have:
made frequent commits
kept commits "atomic" (i.e.: one accomplishment per commit, rather than a batch of things all committed at once)
descriptive commit messages


## Sub-goals

* extend Motion class (that we developed earlier together) to allow for the user to move and change velocity and acceleration with arrow keys
* Create "Magma" level in which the user tries to escape the convection currents, in order to become igneous rock
* Create "Igneous" level, in which the user tries to get "hit" by water droplets, in order to become sediment.
* Create "Sediment" level in which the user tries to avoid water flows, in order to be slowly cemented into sedementary rock
* Create "metamorphic" level in which the user tries to reach the magma flow, in order to turn back into magma, and start the rock cycle again.
* Figure out how to display text and information, and create a transition system between levels


