int level;
PFont font;
boolean nextLevel;
boolean upPressed;
boolean leftPressed;
boolean rightPressed;
boolean downPressed;
Player player;
void setup() {
  //window size, background color, first level is level '0' , using the font 'sans serif' with size 30
  size(900, 600);
  background(255, 255, 255);
  level = 0;
  font = loadFont("SansSerif-30.vlw");
  nextLevel = false;
  player = new Player();
}
void draw() { 
  //background color
  background(255, 255, 255);
  
  //determine which level the user is at, and run the appropriate method
  if (level==0) {
    startMessage();
  } else if (level==1) {
    magmaLevel();
  }
  
  upPressed = false;
  leftPressed = false;
  rightPressed = false;
  downPressed = true;
}

void startMessage() {
  //center text, and display.
  textAlign(CENTER, CENTER);
  textSize(30);
  fill(0, 0, 80);
  textFont(font);
  text("Press 'shift' to begin your journey as a piece of magma. \n Your goal is to try and escape the convection current. \n in order to become igneous rock, and continue your journey. \n Controls: arrow keys", width/2, height/2);
  
  //If the user has pressed 'shift' increase the level value by 1
  if (nextLevel) {
    level = 1;
    nextLevel = false;
  }
}

void magmaLevel() {
  
  //Set the background to a 'magma' theme and create the player.
  background(161, 40, 48);
  rect(width-70,20,50,50);
  
  ArrayList<Integer[]> lossConditions = new ArrayList<Integer[]>();
  Integer[] firstRect = {width-200,0,10,500};
  
  lossConditions.add(firstRect);
  //test words
  
  player.update(lossConditions);
  if(player.dead()){
  player.restart();
  }
}

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
    }
    if (keyCode == RIGHT) {
      player.moveRight();
    }
    if (keyCode == DOWN) {
      player.moveDown();
    }
  }
} 