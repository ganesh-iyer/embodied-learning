class ElementShape{
  PShape shapeCoordinates; // PShape element that is moving down
  float xPos, yPos; // positions
  color shapeFill;
  int shapeFillR, shapeFillG, shapeFillB; // color of fill
  color shapeStroke; // color of stroke -> set to 0 transparency throughout -> YOU MAY NOT NEED THIS
  //float strokeWeight;
  float shapeRadius; // radius of shape -> depends on where in the screen it is
  // need to be able to access shapeRadius as a property for VertexList
  
  int[] vertices; // storing vertices separately to match with Arduino Inputs
  boolean isOngoing;
  //int ySpeed; // not needed
  PShape createdShape; // PShape element that is stored.
  
  ElementShape(){
    vertices = new int[9]; // 9 vertices including the origin which will always be the 0th element and is 0
    xPos = 400;
    yPos = 0;
    //ySpeed = int(random(3, 6));
    shapeRadius = 150;
    // default shape equals 150
    
    shapeFillR = 0;
    shapeFillG = 223;
    shapeFillB = 252;
    //shapeFill = color(shapeFillR, shapeFillG, shapeFillB);
    isOngoing = true;
    
    // initial color (0, 223, 252);
    // final color (189, 21, 80);
  }
  
  /*
  To do:
  1. Get shapes to come one after another and stop after the level ends
  2. Replicate the shape that was just passed to appear near the right bottom corner above the line
  */
  
  void drawShape(int [] vertices, float shapeRadius, float xPos, float yPos){
    //moveShape(); // removing this from here is okay
    //colorShift(); // removing this from here is okay
    
    // Drawing the shape
    shapeCoordinates = createShape();
    shapeCoordinates.beginShape();
    shapeCoordinates.fill(shapeFillR, shapeFillG, shapeFillB, shapeAlpha);
    shapeCoordinates.stroke(backgroundColor);
    shapeCoordinates.strokeWeight(2);
    
    for (int i = 0; i < vertices.length; i++){
       if (vertices[i]==1) {
       shapeCoordinates.vertex(VertexReturn(i, 0, shapeRadius), VertexReturn(i, 1, shapeRadius));
       }
    }
    shapeCoordinates.endShape(CLOSE);
    shape(shapeCoordinates, xPos, yPos);
    
    // Superimposing origin
    fill(255, 204, 0, shapeAlpha);
    stroke(backgroundColor - 255);
    strokeWeight(4);
    ellipse(xPos, yPos, 50, 50);
    fill(78, 129, 194, shapeAlpha);
    stroke(0, 185, 212, shapeAlpha);
    strokeWeight(5);
    ellipse(xPos, yPos, 20, 20);
    // this works well
  
  }
  
  // a better way would be to incorporate this into the shape drawing function
  void arduinoFeedback(){
    int[] arduinoInput = drawInputsForPractice();
    
    for (int i = 1; i < arduinoInput.length; i++){
      if (arduinoInput[i] == 1){
        fill(0, 185, 212, shapeAlpha);
        stroke(backgroundColor - 255);
        strokeWeight(4);
        ellipse(xPos + VertexReturn(i, 0, shapeRadius), yPos + VertexReturn(i, 1, shapeRadius), 20, 20);
      }
    }
    
  }
  
  void moveShape(){
    if (yPos < lineLimit){
      yPos = yPos + ySpeed;
      colorShift();
    }    
    // this is okay for now. This moves the shape till it reaches the line
  }
  
  boolean conditionSatisfied(int [] vertices){
    boolean condition = false;
    // Arduino code here that satisfies shape
    // TODO
    
    return condition;
  }
  
  void colorShift(){
    shapeFillR = int(yPos*189/lineLimit);
    shapeFillG = int(223 - yPos*202/lineLimit);
    shapeFillB = int(252 - yPos*172/lineLimit);
    
    //strokeWeight = random(2, 8);
    // This pulsating effect is ugly
    // this is okay for now, may need color tweaks
    // NEED BETTER FUNCTION THAN LERPCOLOR. Also need something non-linear
  }
  
  void destroyShape(){
    // test this shit out first
    shapeCoordinates.setVisible(false);
  }
}