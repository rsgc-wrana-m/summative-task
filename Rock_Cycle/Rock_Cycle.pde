int level;
boolean complete;
PFont font;
void setup() {
  size(900, 600);
  background(255,255,255);
  level = 0;
  complete = false;
  font = loadFont("Serif-12.vlw");
}
void draw() {
  if(level==0){
  startMessage();
  } else if(level==1 && complete){
  level=2;
  complete = false;
  }
  
  
}

void startMessage(){
  textAlign(CENTER, CENTER);
  textSize(15);
  fill(0, 0, 80);
  textFont(font);
  text("Press F to begin your journey as a piece of magma.  Your goal is to try and escape the convection current, in order to become igneous rock, and continue your journey through the rock cycle.  Controls: arrow keys", width/2, height/2);

}

void keyPressed(){

}