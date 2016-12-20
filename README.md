# Geometris - Processing

DEVELOPMENT NOTES

**Update: The game can be operated without the hardware as similar functionalities have been written using mouse. Simply use a mouse-click to mimic the creation of a successful shape.**

We labeled each pressure-sensitive touchpad with an index (1-8 for 8 touchpads) - #1 in the 12 o’clock position proceeding clockwise to #8. We also labeled the origin/central point of reference as index-0 in a 9-element binary array to store which vertices are being activated and also to decide how shape are made. We used the Firmata library to pass the digital inputs to Processing.

The logic to draw shapes defines (x, y) coordinates for each vertex and uses the PShape class to draw the shape given these coordinates. We also wrote supporting functions that allow the program to take in an array of 1s and 0s and return another array of (x, y) coordinate pairs through trigonometric manipulations. Each shape is then constructed as a custom shape object that contains an array of 9 elements (either 1 or 0). For example, the array {0,1,0,1,0,0,0,1,0} would correspond to a right triangle with vertices at positions 1, 3, and 7. Similarly, a triangle that involves the origin (index-0) and vertices 2 and 8 contains the array {1,0,1,0,0,0,0,0,1} (see figure alongside). The custom shape object also stores the color that changes linearly with the y-coordinate of the shape’s origin.

By definition, users will have “successfully created” a shape when the required vertices - and only the required vertices - are switched on through their corresponding touchpad. Logically, Processing evaluates if the 9-element array that it is reading is identical to the 9-element array stored for the current shape. The moment this condition is satisfied, the shape object, which also includes its color at the time, is appended to an ArrayList of the custom shape objects. This new array is used to present a record of shapes completed by the user thus far and also used to present the final composite shape at the end of the level.  

Digital inputs from the touchpads are also used to allow navigation across screens. The home screen menu maps pads 8, 1, 2, and 5 to the easy, medium, difficult, and practice levels, respectively. One shortcoming of our current design is that the touchpads could not be used to navigate away from screens when they are already being used to create shapes.

Since a bulk of the software was written while the hardware was being fabricated, we wrote additional mouse functions to debug the code in the absence of the mat and touchpads. Mouse clicks mimic successful shape creation. The practice screen is also used to debug the hardware and software.

