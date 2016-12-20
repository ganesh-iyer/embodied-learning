float EasyX, EasyY, MediumX, MediumY, DifficultX, DifficultY, PracticeX, PracticeY, distEasy, distMedium, distDifficult, distPractice, backX, backY, distBack;
void mouseReleased(){
  // run conditions based on current game screen
  
  // FOR HOME SCREEN
  if (currentScreen == -1){
    // run distance function to the highlighted
    // important interactions are {null, medium, difficult, null, null, null, null, null, easy}
    // xOrg and yOrg are width/2 and height/2 respectively
    
    float EasyX = canvasWidth/2 + VertexReturn(8, 0, matRadius);
    float EasyY = canvasHeight/2 + VertexReturn(8, 1, matRadius) - 30;
    float MediumX = canvasWidth/2 + VertexReturn(1, 0, matRadius);
    float MediumY = canvasHeight/2 + VertexReturn(1, 1, matRadius) - 30;
    float DifficultX = canvasWidth/2 + VertexReturn(2, 0, matRadius);
    float DifficultY = canvasHeight/2 + VertexReturn(2, 1, matRadius) - 30;
    float PracticeX = canvasWidth/2 + VertexReturn(5, 0, matRadius);
    float PracticeY = canvasHeight/2 + VertexReturn(5, 1, matRadius) - 30;
    
    float distEasy = sqrt((EasyX - mouseX)*(EasyX - mouseX) + (EasyY - mouseY)*(EasyY - mouseY));
    float distMedium = sqrt((MediumX - mouseX)*(MediumX - mouseX) + (MediumY - mouseY)*(MediumY - mouseY));
    float distDifficult = sqrt((DifficultX - mouseX)*(DifficultX - mouseX) + (DifficultY - mouseY)*(DifficultY - mouseY));
    float distPractice = sqrt((PracticeX - mouseX)*(PracticeX - mouseX) + (PracticeY - mouseY)*(PracticeY - mouseY));
    
    if (distEasy < menuEllipseRadius){
      //println ("Easy Screen entered");
      currentScreen = 1;
      gameOngoing = 2;
    }
    
    if (distMedium < menuEllipseRadius){
      //println ("Medium Screen entered");
      currentScreen = 2;
      gameOngoing = 2;
    }
    
    if (distDifficult < menuEllipseRadius){
      //println ("Difficult Screen entered");
      currentScreen = 3;
      gameOngoing = 2;
    }
    
    if (distPractice < menuEllipseRadius){
      currentScreen = 0;
    }
    
  }
  
  if (currentScreen == 0){
    float BackX = 100;
    float BackY = 87.5;
    
    float distBack = sqrt((BackX - mouseX)*(BackX - mouseX) + (BackY - mouseY)*(BackY - mouseY));
    
    if (distBack < 25){
      //println ("Easy Screen entered");
      resetGame();
    }
    
  }
  
  // Back menu interface
  if ((currentScreen == 1 || currentScreen == 2 || currentScreen == 3) && gameOngoing == 3){
    //backX = canvasWidth + 77 + VertexReturn(8, 0, matRadius);
    //backY = lineLimit + 77 + VertexReturn(8, 1, matRadius);
    backX = 100;
    backY = 50;
    // NOT SCALABLE
    // CLEANUP THIS FUNCTION MATHEMATICALLY
    
    distBack = sqrt((backX - mouseX)*(backX - mouseX) + 
                      (backY - mouseY)*(backY - mouseY));   
    
    if (distBack < backEllipseRadius){
      resetGame(); // go back home
    }
  }
  
}

void mousePressed(){
  // This code is to only show a HIT state
  
  // run conditions based on current game screen
  // Utilize fragments of this function when using the actual mat
  
  // FOR HOME SCREEN
  
  if (currentScreen == -1){
    // run distance function to the highlighted
    // important interactions are {null, medium, difficult, null, null, null, null, null, easy}
    // xOrg and yOrg are width/2 and height/2 respectively
    
    float EasyX = canvasWidth/2 + VertexReturn(8, 0, matRadius);
    float EasyY = canvasHeight/2 + VertexReturn(8, 1, matRadius) - 30;
    float MediumX = canvasWidth/2 + VertexReturn(1, 0, matRadius);
    float MediumY = canvasHeight/2 + VertexReturn(1, 1, matRadius) - 30;
    float DifficultX = canvasWidth/2 + VertexReturn(2, 0, matRadius);
    float DifficultY = canvasHeight/2 + VertexReturn(2, 1, matRadius) - 30;
    
    float distEasy = sqrt((EasyX - mouseX)*(EasyX - mouseX) + (EasyY - mouseY)*(EasyY - mouseY));
    float distMedium = sqrt((MediumX - mouseX)*(MediumX - mouseX) + (MediumY - mouseY)*(MediumY - mouseY));
    float distDifficult = sqrt((DifficultX - mouseX)*(DifficultX - mouseX) + (DifficultY - mouseY)*(DifficultY - mouseY));
    
    if (distEasy < menuEllipseRadius){
      fill(255, 206, 0);
      ellipse(canvasWidth/2 + VertexReturn(8, 0, matRadius), canvasHeight/2 + VertexReturn(8, 1, matRadius) - 30, 2*menuEllipseRadius, 2*menuEllipseRadius);
    }
    
    if (distMedium < menuEllipseRadius){
      fill(255, 206, 0);
      ellipse(canvasWidth/2 + VertexReturn(1, 0, matRadius), canvasHeight/2 + VertexReturn(1, 1, matRadius) - 30, 2*menuEllipseRadius, 2*menuEllipseRadius);
    }
    
    if (distDifficult < menuEllipseRadius){
      fill(255, 206, 0);
      ellipse(canvasWidth/2 + VertexReturn(2, 0, matRadius), canvasHeight/2 + VertexReturn(2, 1, matRadius) - 30, 2*menuEllipseRadius, 2*menuEllipseRadius);
    }
    
  }
  
  // Adding shapes to storedShapes
  if ((currentScreen == 1 || currentScreen == 2 || currentScreen == 3) && gameOngoing == 2){
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
    }
  }
  
  // Back menu interface
  if ((currentScreen == 1 || currentScreen == 2 || currentScreen == 3) && gameOngoing == 3){
    //float tempX = canvasWidth + 77 + VertexReturn(8, 0, matRadius);
    //float tempY = lineLimit + 77 + VertexReturn(8, 1, matRadius);
    float tempX = 100;
    float tempY = 50;
    // NOT SCALABLE
    // CLEANUP THIS FUNCTION MATHEMATICALLY
    
    float dist = sqrt((tempX - mouseX)*(tempX - mouseX) + 
                      (tempY - mouseY)*(tempY - mouseY));                   
    
    if (dist < backEllipseRadius){
      fill(255, 206, 0);
      ellipse(tempX, tempY, backEllipseRadius, backEllipseRadius);
    }
  }
  
  
}