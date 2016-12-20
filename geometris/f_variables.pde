/*
Using arrays:
ElementShape current = new ElementShape();
ElementShape[] storedElementShapes = new ElementShape[16];
color[] storedColor = new color[16];
PShape[] storedShapes = new PShape[16]; 
*/

/*
Using arraylists:
ArrayList <ElementShape> allShapes = new ArrayList<ElementShape>();
*/

ElementShape current = new ElementShape();
ArrayList <ElementShape> storedElementShapes = new ArrayList<ElementShape>();
ArrayList storedColor = new ArrayList (); // somehow stating <color> does not work
ArrayList <PShape> storedShapes = new ArrayList<PShape>();

int ySpeed = 1; // debugging speed = 4, actual game = 1 or 2

int[][] EasyLevelShapes = {{1,0,1,0,0,0,0,0,1},
                           {1,0,0,0,0,0,1,0,1},
                           {1,0,1,0,1,0,0,0,0},
                           {1,0,0,0,1,0,1,0,0},
                           {1,1,0,0,0,0,0,1,0},
                           {1,0,0,1,0,1,0,0,0},
                           {1,1,0,1,0,0,0,0,0},
                           {1,0,0,0,0,1,0,1,0},
                          }; //8 shapes - each a 9 element array
                        
int[][] MediumLevelShapes = {{0,0,1,0,1,0,1,0,0},
                             {0,0,1,0,0,0,1,0,1},
                             {1,1,0,1,0,0,0,0,0},
                             {0,1,0,0,1,0,0,0,1},
                             {1,0,0,0,0,1,0,1,0},
                             {0,0,0,0,1,1,0,0,1},
                             {0,0,1,0,1,0,0,1,0},
                             {0,0,0,1,0,0,1,0,1},
                            }; //8 shapes - each a 9 element array
                            // 246, 268, 013, 148, 057, 458, 247, 368    
                            
int[][] DifficultLevelShapes = {{0,1,1,0,1,1,1,0,1},
                               {1,0,1,0,0,1,1,0,1},
                               {0,1,0,1,1,0,1,1,0},
                               {0,0,1,0,0,1,0,0,1},
                               {1,0,1,0,1,1,0,0,1},
                               {0,0,0,1,0,0,1,0,1},
                               {1,0,1,1,0,1,0,1,1},
                               {0,0,1,0,1,0,0,1,0}
                              }; //8 shapes - each a 9 element array                           
                        
// Indexing                      
int shapeIndex = 0;
int storedIndex = 0;

// shapeIndex is for the series of shapes being passed to the player
// storedIndex is for the series of shapes successfully formed
// initializing both to 0

// GameState
int gameOngoing = 1; // rest state
int currentScreen = -1;

// gameOngoing (int) has three states - default(1), shape(2) and result(3)
// Current Screen states:
// -1: home screen
// 0: trial screen
// 1: easy screen
// 2: medium screen
// 3: difficult screen

// Scaled as per projector
int canvasWidth = 1280;
int canvasHeight = 1024;

// Color calibration based on room lighting
int backgroundColor = 33;
int shapeAlpha = 190;

float originX = 0;
float originY = 0;
//float radius = 100;

float yPos;
float xPos;

int lineLimit = canvasHeight - 150;
 
float dangerZone = lineLimit - 300;
                        
float[][] VertexList = new float[9][2]; // Number of points and number of dimensions (x and y)
                      
Serial myPort;    // The serial port
//PFont myFont;     // The display font
String inString;  // Input string from serial port
//int lf = 10;      // ASCII linefeed 

int[] matInputs = {0,0,0,0,0,0,0,0};
int[] backMenuInput = {1, 1, 0, 0, 0, 0, 0, 0, 0};
int[] chooseEasyGame = {1, 0, 0, 0, 0, 0, 0, 0, 1};
int[] chooseMediumGame = {1, 1, 0, 0, 0, 0, 0, 0, 0};
int[] chooseDifficultGame = {1, 0, 1, 0, 0, 0, 0, 0, 0};
int[] choosePractice = {1, 0, 0, 0, 0, 1, 0, 0, 0};
// Initializing so that you don't get a null value when it appears