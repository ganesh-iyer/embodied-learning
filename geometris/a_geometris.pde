void settings(){
  fullScreen();
  
  minim = new Minim(this);
  // load all music files
  raghu_vamsa = minim.loadFile("raghu_vamsa.mp3");
  groove = minim.loadFile("groove.mp3");
  danger = minim.loadFile("danger1.mp3");
  tada = minim.loadFile("success.mp3");
  
  // load all Leah sounds
  leahYay = minim.loadFile("leahYayNew.mp3");
  leahWellDone = minim.loadFile("leahWellDoneNew.mp3");
  
  // Mixer
  raghu_vamsa.setGain(0);
  groove.setGain(0);
  danger.setGain(0);
  leahYay.setGain(12);
  leahWellDone.setGain(12);
  
  // Firmata stuff
  arduino = new Arduino(this, Arduino.list()[1], 57600);
  
  for (int i = 5; i < 13; i++){
    arduino.pinMode(i, Arduino.OUTPUT);
  }
}

void draw(){
  // Obtain Arduino Inputs
  
  if (currentScreen == -1){
    homeScreen();
    raghu_vamsa.play();
    if (raghu_vamsa.position() > 72000){ // 72071 is the last position of the playhead
       raghu_vamsa.rewind();
       raghu_vamsa.play();
    }
    
    if(shapeMatch(chooseEasyGame)){
      currentScreen = 1;
      gameOngoing = 2;
    }
    if(shapeMatch(chooseMediumGame)){
      currentScreen = 2;
      gameOngoing = 2;
    }
    if(shapeMatch(chooseDifficultGame)){
      currentScreen = 3;
      gameOngoing = 2;
    }
    if(shapeMatch(choosePractice)){
      currentScreen = 0;
      gameOngoing = 2;
    }
  }
  
  if (currentScreen == 0){
    practiceScreen();
  }
  
  if (currentScreen == 1){
    runGame(EasyLevelShapes);    
  }
  if (currentScreen == 2){
    runGame(MediumLevelShapes);
  }
  if (currentScreen == 3){
    runGame(DifficultLevelShapes);
  }
}

// This is the most important part of the game
void runGame(int[][] level){
  
    if (gameOngoing == 2){ // Shape forming is gameOngoing = 2
      background(backgroundColor);
      stroke(255, 0, 0);
      strokeWeight(5);
      line(0, lineLimit, canvasWidth, lineLimit);
      runSpecificLevel(level, 8);
      
      // loop through storedShapes here
      if (storedIndex > 0 && storedIndex < storedElementShapes.size() + 1){
        // using Arrays
        //for (int i = 0; i < storedIndex; i++){
        //  shape(storedShapes[i], (width - storedElementShapes[i].shapeRadius - 100), (lineLimit - storedElementShapes[i].shapeRadius - 100));
        //} 
        
        // using ArrayList
        for (int i = 0; i < storedIndex; i++){
          shape(storedShapes.get(i), (canvasWidth - storedElementShapes.get(i).shapeRadius - 100), (lineLimit - storedElementShapes.get(i).shapeRadius - 100));
        }
    }
    
    if (shapeIndex == 8){
      for (int i = 0; i < storedIndex; i++){
        storedShapes.get(i).scale(3);
        // ZOMG I LOVE YOU
      }
      gameOngoing = 3; // Result is gameOngoing = 3
    }
  }
  
  if (gameOngoing == 3){
    background(backgroundColor);
    stroke(255, 0, 0);
    strokeWeight(5);
    tada.play();
    if (tada.position() > 24000){
      tada.rewind();
      tada.play();
    }
    
    if (storedIndex > 0 && storedIndex < storedElementShapes.size() + 1){
      // Using arrays
      //for (int i = 0; i < storedIndex; i++){
      //  shape(storedShapes[i], 640, 400);
      //}
      
      // Using ArrayList
      for (int i = 0; i < storedIndex; i++){
        shape(storedShapes.get(i), canvasWidth/2, canvasHeight/2);
      }
    }
    
    // Include interface here to go back home
    int [] highlighted = {0, 1, 0, 0, 0, 0, 0, 0, 0};
    //constructMatInterface(canvasWidth - current.shapeRadius + 50, lineLimit - current.shapeRadius + 100, 50, highlighted, backEllipseRadius);
    constructMatInterface(100, 100, 50, highlighted, backEllipseRadius);
    // backEllipseRadius = 30
    // currentShapeRadius = 150
    
    if(shapeMatch(backMenuInput)){
      resetGame();
      delay(100);
    }
    
  }
}

void runSpecificLevel(int[][] level, int numberOfShapes){
  raghu_vamsa.pause();
  groove.play();
  if (shapeIndex < numberOfShapes && gameOngoing == 2){
     // These 3 lines work as desired, so now you can separate draw, move and colorShift
     current.vertices = level[shapeIndex]; // NOTE 9 elements in the array
     current.drawShape(current.vertices, current.shapeRadius, current.xPos, current.yPos); // draws with the default radius of 150
     println(current.vertices, shapeIndex);
     current.moveShape();
     current.colorShift();
     current.arduinoFeedback();

     // success condition here
     if (shapeMatch(current.vertices)){
       if (storedIndex < 16){
        //storedElementShapes[storedIndex] = current;
        //storedShapes[storedIndex] = current.shapeCoordinates;
        //storedColor[storedIndex] = color(current.shapeFillR, current.shapeFillG, current.shapeFillB);
        
        storedElementShapes.add(current);
        storedShapes.add(current.shapeCoordinates);
        storedColor.add(color(current.shapeFillR, current.shapeFillG, current.shapeFillB));
        
        storedIndex++;
        
        // Leah's sounds
        leahExclaim();
        shapeIndex++;
        danger.pause();
        danger.rewind();
        groove.pause();
        groove.rewind();
     
        current.yPos = 0;
       }
     }
     
     // danger condition
     if (current.yPos >= dangerZone && current.yPos < lineLimit){
       danger.play();
     }
     
     //failure condition
     if (current.yPos >= lineLimit){
       shapeIndex++;
       danger.pause();
       danger.rewind();
       groove.pause();
       groove.rewind();
       
       current.yPos = 0; // this is the next shape
     }
  }
}

// Retain this
float VertexReturn(int pointNumber, int coordinate, float radius){
  float[][] VertexList = {{originX, originY},
                      {originX+cos(radians(90))*radius, originY-sin(radians(90))*radius},
                      {originX+cos(radians(45))*radius, originY-sin(radians(45))*radius},
                      {originX+cos(radians(0))*radius, originY-sin(radians(0))*radius},
                      {originX+cos(radians(45))*radius, originY+sin(radians(45))*radius},
                      {originX+cos(radians(90))*radius, originY+sin(radians(90))*radius},
                      {originX-cos(radians(45))*radius, originY+sin(radians(45))*radius},
                      {originX-cos(radians(0))*radius, originY+sin(radians(0))*radius},
                      {originX-cos(radians(45))*radius, originY-sin(radians(45))*radius}
                      };
  return VertexList[pointNumber][coordinate];
}

void resetGame(){
  currentScreen = -1;
  gameOngoing = 1;
  current = new ElementShape();
  storedElementShapes = new ArrayList<ElementShape>();
  storedColor = new ArrayList ();
  storedShapes = new ArrayList<PShape>();
  storedIndex = 0;
  shapeIndex = 0;
  tada.rewind();
  tada.pause();
  raghu_vamsa.rewind();
  groove.rewind();
  danger.rewind();
}

boolean shapeMatch(int[] currentVertices){
  boolean check = true;
  print("From Arduino: "); // retain this for debugging
  for (int i = 1; i < currentVertices.length; i++){
    print(drawInputsForPractice()[i]);
    if (drawInputsForPractice()[i] != currentVertices[i]){
       check = false; 
    }
  }
  print('\n');
  print("From the program :"); // retain this for debugging
  for (int i = 1; i < currentVertices.length; i++){
    print(currentVertices[i]);
    }
  print('\n');
  return check;
}