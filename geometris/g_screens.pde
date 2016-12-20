// Fonts
PFont gamePlayFont;
PFont authorFont;
PFont menuFont;

int blink = 0;

// To display menu
float matRadius = 250;
float menuEllipseRadius = 60;
float backEllipseRadius = 30;

int [] highlighted;
// this needs to be global as almost every screen will be accessing this particular 9-element array


void homeScreen(){
  // show home screen with buttons, logo and music
  int [] highlighted = {0, 1, 1, 0, 0, 1, 0, 0, 1};
  
  // play Raghu Vamsa - composed by Sri Patnam Subramaniam Iyer
  background(backgroundColor);
  
  constructMatInterface(canvasWidth/2, canvasHeight/2 - 30, matRadius, highlighted, 2*menuEllipseRadius);
  gamePlayFont = createFont("Gameplay", 48);
  textFont(gamePlayFont);
  textAlign(CENTER, CENTER);
  if (blink == 0){
    fill(0, 185, 212);
    delay(100);
    blink = 1;
  }
  else{
    fill(78, 129, 194);
    delay(100);
    blink = 0;
  }
  text("GEOMETRIS", canvasWidth/2, canvasHeight/2 - 60);
  
  fill(255 - backgroundColor);
  authorFont = createFont("GamePlay", 18);
  textFont(authorFont);
  textAlign(CENTER, CENTER);
  text("Created with ♥ by L.E.G.", canvasWidth/2, canvasHeight/2);
  
  fill(backgroundColor);
  menuFont = createFont("GamePlay", 14);
  textFont(menuFont);
  textAlign(CENTER, CENTER);
  text("EASY", canvasWidth/2 + VertexReturn(8, 0, 250), canvasHeight/2 + VertexReturn(8, 1, 250) - 30);
  text("MEDIUM", canvasWidth/2 + VertexReturn(1, 0, 250), canvasHeight/2 + VertexReturn(1, 1, 250) - 30);
  text("DIFFICULT", canvasWidth/2 + VertexReturn(2, 0, 250), canvasHeight/2 + VertexReturn(2, 1, 250) - 30);
  text("PRACTICE", canvasWidth/2 + VertexReturn(5, 0, 250), canvasHeight/2 + VertexReturn(5, 1, 250) - 30);
  
}

void constructMatInterface(float xOrg, float yOrg, float matRadius, int[] highlighted, float ellipseDiameter){
  // this is where we just construct the mat. Nothing more
  noStroke();
  for (int i = 1; i < 9; i++){
    if (highlighted[i] == 1){
      fill(0, 185, 212);
      ellipse(xOrg + VertexReturn(i, 0, matRadius), yOrg + VertexReturn(i, 1, matRadius), ellipseDiameter, ellipseDiameter);
    }
    
    else {
      fill(240);
      ellipse(xOrg + VertexReturn(i, 0, matRadius), yOrg + VertexReturn(i, 1, matRadius), ellipseDiameter, ellipseDiameter);
    }
  }
  
}

void practiceScreen(){
  raghu_vamsa.pause();
  int[] vertices = drawInputsForPractice();
  background(backgroundColor);
  PShape currentShape = new PShape();
  float currentShapeXOrg = canvasWidth/2;
  float currentShapeYOrg = canvasHeight/2;
  currentShape = createShape();
  currentShape.beginShape();
  currentShape.fill(0, 223, 252, 255);
  currentShape.stroke(255);
  currentShape.strokeWeight(2);
  for (int i = 0; i < vertices.length; i++){
       if (vertices[i]==1) {
       currentShape.vertex(VertexReturn(i, 0, matRadius+50), VertexReturn(i, 1, matRadius+50));
       }
    }
    currentShape.endShape(CLOSE);
    shape(currentShape, currentShapeXOrg, currentShapeYOrg);
    // For the origin circle
    fill(247, 147, 30, shapeAlpha);
    ellipse(currentShapeXOrg, currentShapeYOrg, 50, 50);
    
  // Back button for practice  
  fill(255);  
  stroke(255 - backgroundColor);
  ellipse(100, 100, 50, 50);


  fill(backgroundColor);
  textFont(gamePlayFont);
  textAlign(CENTER, CENTER);
  text("‹", 100, 87.5);
}