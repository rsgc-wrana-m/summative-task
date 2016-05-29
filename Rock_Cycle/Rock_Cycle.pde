int level;
PFont font;
boolean nextLevel;
Player player;
Absorber absorber;
Integer[] dropletPositions;
Integer yPosition;
Integer[] currentXPositions;
Integer[] currentYPositions;
Integer[] currentHeights;
Integer[] currentWidths;
void setup() {
  //window size, background color, first level is level '0' , using the font 'sans serif' with size 30
  size(900, 600);
  background(255, 255, 255);
  level = 0;
  font = loadFont("SansSerif-30.vlw");
  nextLevel = false;
  player = new Player();
  absorber = new Absorber();
  
  //  This creates 3 random numbers for the x position, the y position, heights and widths of three different "water flows", done in an extremely terrible manner
  Integer[] randomPositions = {Math.round(random(50, width-50)), Math.round(random(50, width-50)), Math.round(random(50, width-50))};
  this.dropletPositions = randomPositions;
  Integer[] currentXPositions = {Math.round(random(50, width-50)), Math.round(random(50, width-50)), Math.round(random(50, width-50))};
  Integer[] currentYPositions = {Math.round(random(50, height-50)), Math.round(random(50, height-50)), Math.round(random(50, height-50))};
  Integer[] currentHeights = {Math.round(random(50, 150)), Math.round(random(50, 150)), Math.round(random(50, 150))};
  Integer[] currentWidths = {Math.round(random(50, 150)), Math.round(random(50, 150)), Math.round(random(50, 150))};
  yPosition = 0;
  this.currentXPositions = currentXPositions;
  this.currentYPositions = currentYPositions;
  this.currentHeights = currentHeights;
  this.currentWidths = currentWidths;
}

//Check to see which 'level' the user is currently on, and run the associated method
void draw() { 
  //background color
  background(255, 255, 255);

  //determine which level the user is at, and run the appropriate method
  if (level==0) {
    startMessage();
  } else if (level==1) {
    magmaLevel();
  } else if (level == 2) {
    level2Message();
  } else if (level == 3) {
    igneousLevel();
  } else if (level == 4) {
    level3Message();
  } else if (level == 5){
    metamorphicLevel();
  }
}
//My most recent attempt at a metamorphic rock level, in which the player is a piece of sediment trying to avoid water flows.
void metamorphicLevel(){
  background(161, 40, 48);
  
  //Based on the same system as the magma level, only the regions which the player can hit move constantly... unfinished work
  ArrayList<Integer[]> lossConditions = new ArrayList<Integer[]>();
  Integer[] firstRect = {currentXPositions[0], currentYPositions[0], currentHeights[0], currentWidths[0]};
  Integer[] secondRect = {currentXPositions[1], currentYPositions[1], currentHeights[1], currentWidths[1]};
  Integer[] thirdRect = {currentXPositions[2], currentYPositions[2], currentHeights[2], currentWidths[2]};
  lossConditions.add(firstRect);
  lossConditions.add(secondRect);
  lossConditions.add(thirdRect);
  //test words

  player.update(lossConditions);
  
  for(int i = 0;i<currentXPositions.length;i++){
    currentXPositions[i] = currentXPositions[i]+Math.round(random(-20,10));
    currentYPositions[i] = currentYPositions[i]+Math.round(random(-20,10));
  }

}
//simple text level, which can simply be 'completed' by pressing shift
void level3Message() {
  //center text, and display.
  textAlign(CENTER, CENTER);
  textSize(30);
  fill(0, 0, 80);
  textFont(font);
  text("Your goal is to avoid being hit by water \n currents, which will cause you to wash away \n and become sediment again \n\n Press 'shift' to begin your journey \nas a piece of metamorphic rock \n\n Controls: arrow keys", width/2, height/2);
  if (nextLevel) {
    level = 5;
    nextLevel = false;
    player.restart();
  }
}
//The player is a rock, however this time, they are trying to absorb droplets of water
void igneousLevel() {
  //generate three 'droplets' which move down every time this functions is called at the end, with the y-position changing by 5
  background(174, 234, 255);
  ArrayList<Integer[]> lossConditions = new ArrayList<Integer[]>();
  Integer[] first = {dropletPositions[0], yPosition};
  Integer[] second = {dropletPositions[1], yPosition};
  Integer[] third = {dropletPositions[2], yPosition};
  //if the droplets reach the bottom, loop them back to the top
  if (yPosition >= height) yPosition = 0;
  lossConditions.add(first);
  lossConditions.add(second);
  lossConditions.add(third);


  //update the absorber or 'player', and if they have completed the mission (by absorbing a water droplet) move them to the next level
  absorber.update(lossConditions);
  if (absorber.completed()) {
    level=4;
  }
  yPosition +=5;
}
//simple text level, which can simply be 'completed' by pressing shift
void level2Message() {
  //center text, and display.
  textAlign(CENTER, CENTER);
  textSize(30);
  fill(0, 0, 80);
  textFont(font);
  text("Your goal is to try and get hit by raindrops \n which will cause you to slowly erode and become sediment. \n\n Press 'shift' to begin your journey as a piece of igneous rock \n\n Controls: arrow keys", width/2, height/2);
  if (nextLevel) {
    level = 3;
    nextLevel = false;
    player.restart();
    absorber.restart();
  }
}
//simple text level, which can simply be 'completed' by pressing shift
void startMessage() {
  //center text, and display.
  textAlign(CENTER, CENTER);
  textSize(30);
  fill(0, 0, 80);
  textFont(font);
  text("Your goal is to try and escape the convection current \n in order to become igneous rock, and continue your journey. \n By reaching the end, you will have entered a volcano \n and will eventually erupt into the outside world. \n \nPress 'shift' to begin your journey as a piece of magma. \n\n Controls: arrow keys", width/2, height/2);

  //If the user has pressed 'shift' increase the level value by 1
  if (nextLevel) {
    level = 1;
    nextLevel = false;
  }
}

void magmaLevel() {

  //Set the background to a 'magma' theme and create the player.
  background(161, 40, 48);
  
  // Create a rectangle, which represents the zone in which the player can complete the level
  rect(width-70, 20, 50, 50);
  Integer[] winCondition = {width-70, 20, 50, 50};
  //Create rectangles, which represent the zone in which the player will have to restart the level
  ArrayList<Integer[]> lossConditions = new ArrayList<Integer[]>();
  //Integer[] firstRect = {width-200, 0, 10, 500};
  Integer[] secondRect = {width-300, 200, 10, 400};
  //lossConditions.add(firstRect);
  lossConditions.add(secondRect);
  //update the player's location, and if they are within the zone defined by the win condition, set the level to the next one
  player.update(lossConditions);
  if (player.level1Victory(winCondition)) {
    level = 2;
  }
}
//Simply key press code, however up and down controls do not work for the absorber object
void keyPressed() { // This function is called everytime a key is pressed.

  if (key == CODED)
  {
    if (keyCode == SHIFT)
    {
      nextLevel = true;
    }
    if (keyCode == UP) {
      player.moveUp();
    }
    if (keyCode == LEFT) {
      player.moveLeft();
      absorber.moveLeft();
    }
    if (keyCode == RIGHT) {
      player.moveRight();
      absorber.moveRight();
    }
    if (keyCode == DOWN) {
      player.moveDown();
    }
  }
} 