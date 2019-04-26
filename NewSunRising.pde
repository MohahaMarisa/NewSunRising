import processing.pdf.*;//for exporting pdf //<>// //<>//
import processing.serial.*; //also for serial communication, possibly for button
import processing.sound.*;

import deadpixel.keystone.*; 
Keystone ks;
CornerPinSurface surface;

import processing.video.*;
Movie myMovie;

//Sounds
SoundFile file;
SoundFile lock;
SoundFile fail;

PVector tableMouse;
PGraphics tableScreen; //seperate canvas for what's being projected to top
PGraphics printScene; //seperate canvas that sometimes also draws to table screen
/*
pixel grid is recieved from the CV analyzing the abstracte community
 and finding the different colors
 1. orange - connectivity
 2. Yellow - Opportunity
 3. Green- Sustainability
 4. blue - planning
 5. purple - Culture
 
 we're going to have calibration marker toooooo
 
 RED IS THE PIIIINNNNN
 */

float gridWidth;
int gridX = 0;
int gridY = 0;
float gridGutter;
float cellWidth; //individual square size

//OSWALD is our font, make sure to have it installed on your computer as a system font
PFont light;
PFont regular;
PFont bold;

String displayText = "hello world copy goes here";
PShape map;
PVector pinPos;// for where the pin is used to be called pinPos
int zipcode = 15213;//updates according to pin pos

// ZIP CODE ARRAY
int[][] zipcodeGrid = 
{{15202, 15212, 15212, 15214, 15209, 15223, 15201, 15206, 15206},
{15136, 15212, 15212, 15214, 15212, 15201, 15201, 15206, 15206},
{15204, 15204, 15233, 15212, 15212, 15201, 15224, 15232, 15208},
{15205, 15220, 15220, 15222, 15219, 15213, 15213, 15217, 15217},
{15205, 15205, 15220, 15211, 15203, 15203, 15207, 15207, 15221},
{15205, 15205, 15216, 15226, 15210, 15210, 15207, 15207, 15120}};

// NEARBY ZIP CODES (5 Mile Radius)
int[][] nearbyZipcodes5 = {
{15209, 15214, 15202, 15223}, {15212, 15214, 15222}, {15212, 15214, 15222}, {15212, 15214, 15202}, {15209, 15202, 15223}, {15209, 15202, 15223}, {15201, 15224}, {15208, 15206}, {15208, 15206}, 
{15136}, {15212, 15214, 15222}, {15212, 15214, 15222}, {15212, 15214, 15202}, {15212, 15214, 15222}, {15201, 15224}, {15201, 15224}, {15208, 15206}, {15208, 15206}, {15233, 15233, 15204, 15205}, 
{15233, 15233, 15204, 15205}, {15233, 15233, 15204, 15205, 15220}, {15212, 15214, 15222}, {15212, 15214, 15222}, {15201, 15224}, {15232, 15201, 15224, 15213}, {15232, 15207, 15224, 15213, 15217}, 
{15208, 15206, 15217}, {15233, 15233, 15204, 15205}, {15216, 15233, 15233, 15220, 15211}, {15216, 15233, 15233, 15220, 15211}, {15212, 15222}, {15221, 15219}, {15232, 15224, 15213, 15203}, 
{15232, 15224, 15213, 15203}, {15232, 15208, 15207, 15217}, {15232, 15208, 15207, 15217}, {15233, 15233, 15204, 15205}, {15233, 15233, 15204, 15205}, {15216, 15233, 15233, 15220, 15211}, 
{15216, 15220, 15211, 15226}, {15210, 15213, 15203}, {15210, 15213, 15203}, {15232, 15207, 15120, 15217}, {15232, 15207, 15120, 15217}, {15221, 15219}, {15233, 15233, 15204, 15205}, 
{15233, 15233, 15204, 15205}, {15216, 15220, 15211, 15226}, {15216, 15211, 15226}, {15210, 15203}, {15210, 15203}, {15232, 15207, 15120, 15217}, {15232, 15207, 15120, 15217}, {15207, 15120, 15218}};

// NEARBY ZIP CODES (10 Mile Radius)
int[][] nearbyZipcodes10 = 
{{15209, 15214, 15202, 15223}, {15212, 15214, 15222}, {15212, 15214, 15222}, {15212, 15214, 15202}, {15209, 15202, 15223}, {15209, 15202, 15223}, {15201, 15224}, {15208, 15206}, {15208, 15206}, {15136}, 
{15212, 15214, 15222}, {15212, 15214, 15222}, {15212, 15214, 15202}, {15212, 15214, 15222}, {15201, 15224}, {15201, 15224}, {15208, 15206}, {15208, 15206}, {15233, 15233, 15204, 15205}, {15233, 15233, 15204, 15205}, 
{15233, 15233, 15204, 15205, 15220}, {15212, 15214, 15222}, {15212, 15214, 15222}, {15201, 15224}, {15232, 15201, 15224, 15213}, {15232, 15207, 15224, 15213, 15217}, {15208, 15206, 15217}, {15233, 15233, 15204, 15205}, {15216, 15233, 15233, 15220, 15211}, {15216, 15233, 15233, 15220, 15211}, {15212, 15222}, {15221, 15219}, {15232, 15224, 15213, 15203}, {15232, 15224, 15213, 15203}, {15232, 15208, 15207, 15217}, {15232, 15208, 15207, 15217}, {15233, 15233, 15204, 15205}, {15233, 15233, 15204, 15205}, {15216, 15233, 15233, 15220, 15211}, {15216, 15220, 15211, 15226}, {15210, 15213, 15203}, {15210, 15213, 15203}, {15232, 15207, 15120, 15217}, {15232, 15207, 15120, 15217}, {15221, 15219}, {15233, 15233, 15204, 15205}, {15233, 15233, 15204, 15205}, {15216, 15220, 15211, 15226}, {15216, 15211, 15226}, {15210, 15203}, {15210, 15203}, {15232, 15207, 15120, 15217}, {15232, 15207, 15120, 15217}, {15207, 15120, 15218}, {15209, 15201, 15212, 15224, 15214, 15222, 15202, 15229, 15223}, {15209, 15201, 15212, 15224, 15214, 15222, 15213, 15202, 15229, 15223, 15233, 15233, 15203, 15220, 15211}, {15209, 15201, 15212, 15224, 15214, 15222, 15213, 15202, 15229, 15223, 15233, 15233, 15203, 15220, 15211}, {15209, 15201, 15212, 15224, 15214, 15222, 15213, 15202, 15229, 15223, 15233, 15233}, {15209, 15201, 15212, 15224, 15214, 15202, 15229, 15223}, {15209, 15201, 15212, 15206, 15224, 15214, 15213, 15215, 15202, 15223}, {15232, 15208, 15209, 15201, 15212, 15206, 15224, 15214, 15222, 15213, 15215, 15202, 15217, 15223, 15203}, {15232, 15208, 15221, 15207, 15201, 15206, 15224, 15219, 15213, 15215, 15217, 15223, 15218}, {15232, 15208, 15221, 15207, 15201, 15206, 15224, 15219, 15213, 15215, 15217, 15223, 15218}, {15136, 15229, 15228, 15233, 15233, 15204, 15205}, {15209, 15201, 15212, 15224, 15214, 15222, 15213, 15202, 15229, 15223, 15233, 15233, 15203, 15220, 15211}, {15209, 15201, 15212, 15224, 15214, 15222, 15213, 15202, 15229, 15223, 15233, 15233, 15203, 15220, 15211}, {15209, 15201, 15212, 15224, 15214, 15222, 15213, 15202, 15229, 15223, 15233, 15233}, {15209, 15201, 15212, 15224, 15214, 15222, 15213, 15202, 15229, 15223, 15233, 15233, 15203, 15220, 15211}, {15232, 15208, 15209, 15201, 15212, 15206, 15224, 15214, 15222, 15213, 15215, 15202, 15217, 15223, 15203}, {15232, 15208, 15209, 15201, 15212, 15206, 15224, 15214, 15222, 15213, 15215, 15202, 15217, 15223, 15203}, {15232, 15208, 15221, 15207, 15201, 15206, 15224, 15219, 15213, 15215, 15217, 15223, 15218}, {15232, 15208, 15221, 15207, 15201, 15206, 15224, 15219, 15213, 15215, 15217, 15223, 15218}, {15136, 15216, 15233, 15233, 15204, 15205, 15220, 15211, 15226}, {15136, 15216, 15233, 15233, 15204, 15205, 15220, 15211, 15226}, {15212, 15136, 15214, 15222, 15216, 15229, 15233, 15233, 15204, 15205, 15220, 15211, 15226}, {15209, 15201, 15212, 15224, 15214, 15222, 15213, 15202, 15229, 15223, 15233, 15233, 15203, 15220, 15211}, {15209, 15201, 15212, 15224, 15214, 15222, 15213, 15202, 15229, 15223, 15233, 15233, 15203, 15220, 15211}, {15232, 15208, 15209, 15201, 15212, 15206, 15224, 15214, 15222, 15213, 15215, 15202, 15217, 15223, 15203}, {15210, 15232, 15208, 15207, 15209, 15201, 15212, 15206, 15224, 15214, 15222, 15213, 15202, 15217, 15223, 15203}, {15210, 15232, 15208, 15207, 15201, 15120, 15206, 15224, 15222, 15213, 15217, 15218, 15203}, {15232, 15208, 15221, 15207, 15201, 15120, 15206, 15224, 15219, 15213, 15215, 15217, 15218}, {15136, 15216, 15233, 15233, 15204, 15205, 15220, 15211}, {15212, 15222, 15216, 15233, 15233, 15203, 15204, 15205, 15220, 15211, 15226}, {15212, 15222, 15216, 15233, 15233, 15203, 15204, 15205, 15220, 15211, 15226}, {15210, 15232, 15201, 15212, 15224, 15214, 15222, 15213, 15216, 15202, 15233, 15233, 15203, 15220, 15211, 15226}, {15208, 15221, 15104, 15206, 15219, 15217, 15218}, {15210, 15232, 15208, 15207, 15201, 15212, 15206, 15224, 15214, 15222, 15213, 15217, 15223, 15203, 15211}, {15210, 15232, 15208, 15207, 15201, 15212, 15206, 15224, 15214, 15222, 15213, 15217, 15223, 15203, 15211}, {15210, 15232, 15208, 15207, 15201, 15120, 15206, 15224, 15219, 15213, 15217, 15218, 15203}, {15210, 15232, 15208, 15207, 15201, 15120, 15206, 15224, 15219, 15213, 15217, 15218, 15203}, {15136, 15216, 15233, 15233, 15204, 15205, 15220, 15211}, {15136, 15216, 15233, 15233, 15204, 15205, 15220, 15211}, {15212, 15222, 15216, 15233, 15233, 15203, 15204, 15205, 15220, 15211, 15226}, {15210, 15212, 15222, 15213, 15216, 15233, 15233, 15203, 15204, 15205, 15220, 15211, 15226}, {15210, 15232, 15207, 15201, 15212, 15224, 15222, 15213, 15216, 15217, 15203, 15220, 15211, 15226}, {15210, 15232, 15207, 15201, 15212, 15224, 15222, 15213, 15216, 15217, 15203, 15220, 15211, 15226}, {15210, 15232, 15208, 15207, 15120, 15206, 15224, 15213, 15217, 15218, 15203}, {15210, 15232, 15208, 15207, 15120, 15206, 15224, 15213, 15217, 15218, 15203}, {15208, 15221, 15104, 15206, 15219, 15218}, {15136, 15216, 15233, 15233, 15204, 15205, 15220, 15211}, {15136, 15216, 15233, 15233, 15204, 15205, 15220, 15211}, {15222, 15216, 15233, 15233, 15203, 15204, 15205, 15220, 15211, 15226}, {15210, 15222, 15216, 15233, 15233, 15203, 15204, 15220, 15211, 15226}, {15210, 15232, 15207, 15120, 15224, 15222, 15213, 15217, 15203, 15211, 15226}, {15210, 15232, 15207, 15120, 15224, 15222, 15213, 15217, 15203, 15211, 15226}, {15210, 15232, 15208, 15207, 15120, 15206, 15224, 15213, 15217, 15218, 15203}, {15210, 15232, 15208, 15207, 15120, 15206, 15224, 15213, 15217, 15218, 15203}, {15210, 15232, 15208, 15207, 15104, 15120, 15217, 15218}};


// LAT LONGS
//{15232: {40.461947, -79.915167}, 15104: {40.416888, -79.83783509999999}, 15235: {40.5502739, -79.776787}, 15237: {40.5946901, -79.986975}, 15233: {40.478524, -80.01341289999999}, 15120: {40.417056, -79.8777719}, 15001: {40.6658329, -80.22868}, 15132: {40.364992, -79.8082791}, 15136: {40.5169811, -80.0468411}, 15201: {40.49156989999999, -79.93112310000001}, 15202: {40.521929, -79.951013}, 15203: {40.437697, -79.951683}, 15204: {40.4656758, -80.0375679}, 15205: {40.470715, -80.043431}, 15206: {40.4927379, -79.883772}, 15207: {40.4362111, -79.89945}, 15208: {40.4646109, -79.883239}, 15209: {40.5287469, -79.951054}, 15210: {40.425946, -79.9381559}, 15019: {40.477568, -80.285159}, 15212: {40.494734, -79.9724021}, 15213: {40.46063700000001, -79.93719}, 15214: {40.507202, -79.9737799}, 15215: {40.526597, -79.8834789}, 15216: {40.430076, -80.010481}, 15217: {40.4499356, -79.8986718}, 15218: {40.436855, -79.86769}, 15219: {40.472077, -79.840588}, 15220: {40.4525859, -80.007819}, 15221: {40.463628, -79.8346261}, 15222: {40.46445689999999, -79.9731011}, 15223: {40.5220399, -79.9380121}, 15224: {40.478645, -79.93278699999999}, 15226: {40.4221701, -79.9981669}, 15229: {40.535651, -80.00370889999999}, 15228: {40.5532377, -80.0184329}, 15146: {40.462069, -79.6985371}, 15211: {40.444485, -79.9972109}}

boolean shifted; //is the shift key pressed?
float globalScale = 0.9; //out of the full screen of what's projecting...

int framesSinceChangeInState = 0; //a timer for animations that happen on changing phases

int[][] pixelGrid = {
  {0, 0, 0, 0, 0, 0, 0, 0, 0}, 
  {0, 0, 0, 0, 0, 0, 0, 0, 0}, 
  {0, 0, 0, 0, 0, 0, 0, 0, 0}, 
  {0, 0, 0, 0, 0, 0, 0, 0, 0}, 
  {0, 0, 0, 0, 0, 0, 0, 0, 0}, 
  {0, 0, 0, 0, 0, 0, 0, 0, 0}
};
int projectorGridRows = 6;
int projectorGridCols = 9;

IntDict markerBuildings;//idk if we use

PImage pittsburghImage; //used for the map   
PImage skyBackground; //used for the poster
PImage coloringTutorial;

String state = "projectorCalibration"; //what step in the experience?

String buttonState = "button number";// global button state to compare against 
Serial buttonPort;
// On the Raspberry Pi GPIO 4 is physical pin 7 on the header
// see setup.png in the sketch folder for wiring details

Table initiatives; //csv of the efforts they support
StringList initiativesDisplayed = new StringList(); //store the rol col and names of rlevant initatives







void setup() {
  /// TTUUIIOO ///
  lock = new SoundFile(this, "tick.wav");
  file = new SoundFile(this, "sSound.mp3");
  fail = new SoundFile(this, "error.wav");

  scale_factor = height/table_size;

  // finally we create an instance of the TuioProcessing client
  // since we add "this" class as an argument the TuioProcessing class expects
  // an implementation of the TUIO callback methods in this class (see below)
  tuioClient  = new TuioProcessing(this);

  /// MAIN /// 
  fullScreen(P3D);
  //size(1440,900, P3D);
  smooth(2); //for antialiasing
  colorMode(HSB); //idk nmeed to check

  frameRate(24);

  ks = new Keystone(this);
  surface = ks.createCornerPinSurface(width, width*3/4, 20);

  /*We need an tableScreen buffer to draw the surface we want projected
   Pls note we matching the resolution of the CornerPinSurface.
   (The tableScreen buffer can be P2D or P3D)*/
  tableScreen = createGraphics(width, width*3/4, P2D);
  myMovie = new Movie(this, "explanation.mov");
  regular = createFont("Oswald", 64); // The font must be located in the sketch's 'data' folder
  bold = createFont("Oswald-Bold", 64); 
  //INPUT_PULLUP enables the built-in pull-up resistor for this pin
  //left alone, the pin will read as HIGH
  // connected to ground (via e.g. a button or switch) it will read LOW
  //GPIO.pinMode(4, GPIO.INPUT_PULLUP);

  pinPos = new PVector(-10, -10); //for now until it's put down, it';s negative
  
  coloringTutorial = loadImage("coloring.png");
  pittsburghImage = loadImage("pittsburgh.jpg");
  skyBackground = loadImage("background.png"); //
  printScene = createGraphics(1100, 850, P3D);//start a seperate buffer for the poster stuff
  gridWidth = width;
  gridGutter = 0.02325*gridWidth; //proportion based of 1.5 inch squares
  cellWidth = (gridWidth - (pixelGrid[0].length-1)*(gridGutter))/ pixelGrid[0].length;

  //mapXY = new PVector(width/2,height/2);
  //targetXY = new PVector(width/2, height/2);
  mapXY = new PVector(0, 0);
  targetXY = new PVector(0, 0);

  initiatives = loadTable("initiatives.csv", "header");//the values are col 0, name 1, description 2
  markerMap = loadTable("markerMap.csv", "header");

  tableScreen.colorMode(HSB);
  tableScreen.noStroke();

  //myMovie.play();
}
void keyPressed() {
  switch(key) {
  case 'p': //starts in this mode 
    state = "projectorCalibration";

  case 'c':
    //calibration moddeeee
    ks.toggleCalibration();
    break;

  case 'v':
    // start camera calibration
    state = "cameraCalibration";
    break;

  case '=': // calibrate camera one square
    calibrateOneSquare();
    break;

  case 'l':
    //loads the saved layout
    ks.load();
    break;

  case 'k': // load camera calibration
    centerPoints = loadCalibration();
    println("load camera calibration");
    break;

  case 'm': // calibration testing mode
    state = "calibrationSynthesis";
    break;

  case 's' : // save projector calibration
    //saves the layout
    ks.save();
    break;
  case '1': // save camera calibration
    listOfInstitues.clear();
    break;
  case 'a': // save camera calibration
    saveCalibration();
    println("saved camera calibration");
    break;

  case 'd': // clear camera calibration
    centerPoints = new PVector[numRows][numCols];
    curRow = 0;
    curCol = 0;
    break;

  case '8':
    state = "start";
    resetTimer();
    break;

  case '0': 
    state = "coloring2";
    break;
  case 't':
    state = "tutorial";
    myMovie.play();
    break;

  case 'x':
    state = "printing";
    generatePrintScene();
    printScene.save("posterx.jpg");
    break;
  }
}

void setupButton() {
  //String myPortName = "tty.usbmodem143301";//change the 0 to a 1 or 2 etc. to match your port
  for (int i=0; i<Serial.list().length; i++)
  {
    println(Serial.list()[i]);
    //String usbArduino = "tty.usbmodem143301";
    //if(usbArduino.equals(Serial.list()[i])){
    //  myPortName = Serial.list()[4];
    //}
  }
  String myPortName = Serial.list()[4];
  buttonPort = new Serial(this, myPortName, 9600);
  println("buttonPort = " + buttonPort);
}
void checkButton() {
  if ( buttonPort.available() > 0) {  // If data is available,
    String val = buttonPort.readStringUntil('\n');//read it and store
    println("val = " + val);
    if (val != null) {
      if (buttonState.equals(val)) {
        println("ignore button signals");
      } else if (val.equals("button 2 released") && buttonState.equals("button 2 pressed") && state.equals("coloring")) {
        transitionAnimationToPrint();
        buttonState = val;
        state = "printing";
        println(val);
      } else if (val.equals("button 2 pressed") && state.equals("coloring")) {
        generatePrintScene();
        buttonState = val;
        println(val);
      } else if (val.equals("button 1 released") && buttonState.equals("button 1 pressed")) {
        buttonState = val;
        println(val);
      } else if (val.equals("button 1 pressed")) {
        buttonState = val;
      } else {
        println("not getting button right: " + val);
      }
    }
  }
}
void mousePressed() {
  int col = xToCol(int(tableMouse.x));
  int row = yToRow(int(tableMouse.y));
  if (state.equals("coloring")) {
    //pixelGrid
    //pixelGrid[row][col] = int(random(1, 5));
  } else if (state.equals("start")) {
    resetTimer();
    pinPos = new PVector(tableMouse.x, tableMouse.y);
  } else if (state.equals("tutorial")) {
    state = "coloring";
    displayText = "Build up your community with your corresponding values";
  } else if (state.equals("printing")) {
    state = "start";
  }
}
int xToCol(int x) {
  int column = x / int(cellWidth);
  return column;
}
int yToRow(int y) {
  int row = y / int(cellWidth);
  return row;
}
void draw() {
  
  background(0); // we need to make the areas between lines bright 
  // Convert the mouse coordinate into surface pinPos
  // this will allow you to use mouse events inside the 
  // surface from your screen. 
  tableMouse = surface.getTransformedMouse();

  //tuioDraw();

  //checkButton();
  framesSinceChangeInState+=1;

  tableScreen.beginDraw();
  tableScreen.background(0);
  tableScreen.colorMode(HSB);
  tableScreen.noStroke();
  switch(state) {
    // 3 calibration modes 
  case "projectorCalibration": // ~~ Markerless Mode ~~
    testingGrid(#FFFFFF);
    break;

  case "cameraCalibration":   // ~~ Calibrater Marker Only ~~
    testingGrid(#0000BC);
    cameraCalibGrid();
    break;

  case "calibrationSynthesis": // ~~ Value Markers Only ~~
    testingGrid(#FF00AA);
    lightUpMarkers();
    break;
  case "start"://shows the map of pittsburgh, waits for pin to activate animation
    mapIt();
    displayText = "Locate your community by placing the pin [   ] on the map";
    break;
  case "tutorial":
    tableScreen.image(myMovie, 0,0, tableScreen.width, tableScreen.width*1080/1920);
    //tableScreen.image(coloringTutorial, 0,0,width, width*coloringTutorial.height/coloringTutorial.width);
    //tutorial();
    displayText = "Build up your community with value blocks";
    break;
  case "coloring2": // main play mode from Cameron
    maintainInstitutes();
    highlightInstitutes();
    break;
  case "coloring":
    displayText = "What do you value for your community?";
    coloring();
    break;
  case "marker":
    testingGrid(color(255, 0, 0));
    lightUpMarkers();
    break;
  case "printing"://animation sequence while poster is printing (shadows casting?)
    background(0);
    displayText = "Let's get you connected!";
    break;
  default:
  }
  textDisplay(displayText);

  tableScreen.endDraw();

  surface.render(tableScreen);
  
}

void textDisplay(String words) { //this is the bottom area underneath the grid
  //display this underneath all the squares of the grid                                                     
  tableScreen.textFont(regular, 64);
  float sizeOfText = cellWidth*0.6;
  float y = tableScreen.height - sizeOfText;
  tableScreen.pushMatrix();
  tableScreen.fill(255);
  tableScreen.textSize(sizeOfText);
  tableScreen.text(words, 0, y);
  tableScreen.popMatrix();
}

void restart() {
  state = "start";
}
void resetTimer() {
  framesSinceChangeInState = 0;
}


// Photo (map of pgh) zooming variables 
PVector mapXY;
PVector targetXY;//where the map should move to and scale up towards hahaha....
float mapScale = 1.0;
float targetScale = 4;

void mapIt() {//for the first stage of experinece //cameron needs to be able to update the pinPos position vecotr!!!
  tableScreen.pushMatrix();
  tableScreen.imageMode(CORNERS);
  if ( pinPos.x > 0 ) { //aka, if pin is there, then run ripples
    //CONVERT PINPOS TO ZIPCODE
    zipcode = zipcodeGrid[int(pinPos.x)][int(pinPos.y)];
    if (framesSinceChangeInState <= 50) {
      tableScreen.image(pittsburghImage, 0, 0, width*mapScale, height*mapScale);
      ripplesEffect(pinPos.x, pinPos.y);
    } else if (framesSinceChangeInState > 50) {
      mapScale = 0.97*mapScale + 0.03*targetScale;
      float x0 = pinPos.x - mapScale*pinPos.x;
      float y0 = pinPos.y - mapScale*pinPos.y;
      float cornerX = pinPos.x + mapScale*(width - pinPos.x);
      float cornerY = pinPos.y + mapScale*(height - pinPos.y);
      tableScreen.image(pittsburghImage, x0, y0, cornerX, cornerY);
      if (framesSinceChangeInState <= 70) {
        ripplesEffect(pinPos.x, pinPos.y);
      }
      if (abs(mapScale - targetScale) <0.1) {
        state = "tutorial";
        myMovie.play();
        displayText = "Place building blocks of the values you want to grow in your community";
      }
    }
  } else {
    tableScreen.image(pittsburghImage, 0, 0, tableScreen.width, tableScreen.width*pittsburghImage.height/pittsburghImage.width);
  }
  tableScreen.popMatrix();
}
void defaultScreen() {//
  //float brightness = 255 * abs(sin(frameCount/25)); //to make it gradual

  for (int row = 0; row < projectorGridRows; row ++) {
    float y = rowToY(row);
    for (int col = 0; col < projectorGridCols; col ++) {
      float someNoise = noise((frameCount + row*1000)/200, col);
      if (someNoise < 0.4) {
        float x = colToX(col);
        float hue = 10 + 40 * abs(sin(frameCount/30 + col/4));
        //float hue = 10 + 100*someNoise;
        tableScreen.fill(hue, 255, 200);
        tableScreen.rect(x, y, tableScreen.width/projectorGridCols + 10, tableScreen.width/projectorGridCols + 10);
      }
    }
  }
  //tableScreen.textAlign(CENTER);
  tableScreen.fill(255);
  tableScreen.textSize(60);
  tableScreen.textAlign(CENTER);
  tableScreen.text("BUILDING VIBRANT COMMUNITIES", tableScreen.width/2, tableScreen.height*0.4);
  tableScreen.textSize(80);
  tableScreen.text("TOGETHER", tableScreen.width/2, tableScreen.height*0.5);
}
void movieEvent(Movie m) {
  m.read();
}
void tutorial() {//flash random color squares onto the grid
  //image(myMovie, 0, 0);
  //tableScreen.image(myMovie, 0,0, tableScreen.width, tableScreen.width * 1080/1920);
  //tableScreen.image(myMovie, 0,0);
  /*
float brightness = 255 * sin(frameCount/25); //to make it gradual
   for(int row = 0; row < projectorGridRows; row ++){
   float y = rowToY(row);
   for(int col = 0; col < projectorGridCols; col ++){
   float someNoise = noise((frameCount + row*1000)/300, col);
   if(someNoise < 0.4){
   float x = colToX(col);
   float hue = 10 + 100*someNoise;
   tableScreen.fill(hue, 255, brightness);
   tableScreen.rect(x, y,tableScreen.width/projectorGridCols + 10, tableScreen.width/projectorGridCols + 10);
   }
   }
   }
   //tableScreen.textAlign(CENTER);
   tableScreen.fill(255);
   tableScreen.textSize(33);
   tableScreen.text("NSR supports local initiatives that", tableScreen.width * 0.22 ,tableScreen.height*0.4);
   tableScreen.fill(20,255,255);
   tableScreen.text("enrich culture,", tableScreen.width * 0.51,tableScreen.height*0.4);
   tableScreen.fill(38,255,255);
   tableScreen.text("create opportunity,", tableScreen.width * 0.51,tableScreen.height*0.45);
   tableScreen.fill(50,255,255);
   tableScreen.text("and elevate sustainability", tableScreen.width * 0.51,tableScreen.height*0.5);
   
   */
}
//HELPER FUNCTION
//takes in the CV updated array and a string item, returns the xy pinPos on the grid according to row and c ol
PVector buildingNameToTableXY(int[][] grid, String dictKey) {
  int dictValue = markerBuildings.get(dictKey);

  for ( int row = 0; row < grid.length; row++ ) {
    for ( int col = 0; col < grid[row].length; col ++) {
      if (grid[row][col] == dictValue) {
        PVector xy = new PVector(colToX(col), rowToY(row));
        return xy;
      }
    }
  }
  PVector nothing = new PVector(-10, -10);
  return nothing;
}
//PVector searchForEmptySpots(int row, int col){ //looks around this marker for empty spots, returns a Pvector of that row/col
//  PVector answer;
//  //first look to the right
//  if (withinGrid(row, col +1) && pixelGrid[row][col+1] == 0){
//    answer = new PVector(row,col + 1);
//  //then look to the left
//  }else if(withinGrid(row, col - 1)&& pixelGrid[row][col-1] == 0){
//    answer = new PVector(row,col - 1);
//  //then look below
//  }else if(withinGrid(row +1, col) && pixelGrid[row + 1][col] == 0){
//    answer = new PVector(row + 1,col);
//  //then look diagonally down to the right
//  }else if (withinGrid(row + 1, col + 1) && pixelGrid[row + 1][col+1] == 0){
//    answer = new PVector(row,col + 1);
//  //then to the left
//  }else if (withinGrid(row + 1, col - 1) && pixelGrid[row + 1][col-1] == 0){
//    answer = new PVector(row + 1,col - 1);
//  //then up right
//  }else if (withinGrid(row - 1, col + 1) && pixelGrid[row - 1][col+1] == 0){
//    answer = new PVector(row -1,col - 1);
//  }else {
//    answer = new PVector(row, col); 
//  }
//  return answer;

//}
//Boolean withinGrid(int row, int col){//given a row and col, is it within the bounds of the array?
//  int rowLimit = pixelGrid.length;
//  int colLimit = pixelGrid[0].length;
//  if (row < rowLimit && row >= 0 && col < colLimit && col >=0){
//    return true;
//  }
//  return false;
//}

//FOR THE COLORING STATE analyzing csv
//String getRelevantInitiative(int whichValue, int expectedIndex){//given one of the values, return a name
//  for(int i = 0; i < initiatives.getRowCount(); i++){
//    if(whichValue == initiatives.getInt(i,0)){//get an int value given row col, and if the value matches

//      TableRow currentRow = initiatives.getRow(i);
//      String firstNameMatch = currentRow.getString("Organization or Project Name");
//      if(!alreadyDisplayed(firstNameMatch)){
//         return (initiatives.getString(i,1));//return the name
//      }
//    }
//  }
//  return " ";
//}
//Boolean alreadyDisplayed(String nameMatch, int expected){//is this initiative not already displayed? 
//  for(int i = 0; i < initiativesDisplayed.size(); i++){
//    String alreadyThere = initiativesDisplayed.get(i);
//    if(nameMatch.equals(alreadyThere) && i != expected){
//          return true;
//    }
//  }
//  return false;
//}
void coloring() {
  //tableScreen.background(0);
  ////grid
  //tableScreen.pushMatrix();
  //tableScreen.rectMode(CENTER);
  //int countHowManyColoredSpots = 0;
  //for (int row = 0; row < pixelGrid.length; row ++) {
  //  float y = rowToY(row);
  //  for (int col = 0; col < pixelGrid[row].length; col++) {
  //    float x = colToX(col);
  //    int value = pixelGrid[row][col];
  //    if(value > 0){//if there's something there

  //      color cc = color(255,255,255);
  //      tableScreen.fill(cc);//FOR MAPPING VALUE NUM TO COLOR, BUT FOR NOW EVERYTHING IS WHITE?
  //      //tableScreen.fill(255);
  //      //tableScreen.stroke(0);
  //      tableScreen.strokeWeight(1);
  //      tableScreen.rect(x, y, tableScreen.width/pixelGrid[row].length, tableScreen.width/pixelGrid[row].length);

  //      PVector displaySpot = searchForEmptySpots(row, col);//gets a rol col back of available space!
  //      float xText = colToX(int(displaySpot.y));
  //      float yText = rowToY(int(displaySpot.x));
  //      //initiativesDisplayed.setInt(countHowManyColoredSpots,1,int(displaySpot.y));
  //      //String name = getRelevantInitiative(value, countHowManyColoredSpots);
  //      //initiativesDisplayed.set(countHowManyColoredSpots,name);
  //      tableScreen.pushMatrix();
  //      tableScreen.fill(255);
  //      tableScreen.textAlign(CENTER);
  //      tableScreen.textSize(24);
  //      //tableScreen.text(name,xText,yText);
  //      tableScreen.popMatrix();

  //      countHowManyColoredSpots += 1;
  //    }
  //  }
  //}

  //tableScreen.popMatrix();
}
void generatePoster() {
  color from = color(94, 155, 255);
  color to = color(247, 177, 165);
  linearGradient(0, 0, width, height, from, to);
  //basicGrid(pixelGrid, 0.9, 0.95, 0.03);
  save("anIteration.jpg");
}
void linearGradient(int x, int y, int w, int h, color from, color to) {
  pushMatrix();
  translate(x, y);
  for (int i = 0; i < h; i++ ) {
    float amt = float(i)/float(h);
    color interpolated = lerpColor(from, to, amt);
    stroke(interpolated);
    line(0, i, w, i);
  }
  popMatrix();
}

//sets up squares and tests the projector for placement
void testingGrid(color colour) {
  tableScreen.pushMatrix();
  tableScreen.rectMode(CENTER);
  for (int row = 0; row < pixelGrid.length; row ++) {
    float y = rowToY(row);
    for (int col = 0; col < pixelGrid[row].length; col++) {
      float x = colToX(col);
      tableScreen.fill(colour);
      tableScreen.stroke(0);
      tableScreen.rect(x, y, cellWidth, cellWidth);
    }
  }
  tableScreen.popMatrix();
}


///////////////////////////////VISUAL/SOUND EFFECTS/////////////////////////////////////////////////////////////////////
ArrayList<Ripple> ripplings = new ArrayList<Ripple>();
void ripplesEffect(float x, float y) {
  //RIPPLE 
  if (frameCount%15 == 0 && framesSinceChangeInState < 60) {
    Ripple anotherone = new Ripple(x, y);
    ripplings.add(anotherone);
  }
  for (int i = 0; i < ripplings.size(); i++) {
    if (ripplings.get(i).keep) {//if the ripple is still viable to grow, continue drawing it out
      ripplings.get(i).draw();
      ripplings.get(i).update();
    } else {
      ripplings.remove(i);
    }
  }
}
class Ripple {
  float x;
  float y;
  int size = 1;
  float increase = width/100; 
  int strokeC=255;
  boolean keep = true;
  Ripple(float xx, float yy) {
    x=xx;
    y=yy;
  }
  void update() {
    increase -= width/5222;
    size+=increase;
    strokeC -= 5;
    if (strokeC < 0) {
      keep = false;
    }
  }
  void draw() {
    tableScreen.pushMatrix();
    tableScreen.stroke(30, 200, 100, strokeC);
    tableScreen.strokeWeight(10);
    tableScreen.noFill();
    tableScreen.ellipse(x, y, size, size);
    tableScreen.popMatrix();
  }
}

/*———————————————————————————————————————————————————————————————————————————————————————————————————————————//
 POSTER SCENE FOR PRINT
 ——————————————————————————————————————————————————————————————————————————————————————————————————*/
public void generatePrintScene() {//called once TO generate 3D 
  printScene.beginDraw();
  printScene.smooth(2);
  printScene.camera(900, 900, 600, 0, 0, 0, 0, 0, -1); 
  printScene.ortho();
  printScene.colorMode(HSB, 255);
  printScene.noStroke();
  printScene.background(255, 0, 255);
  printScene.pushMatrix();
  printScene.imageMode(CENTER);
  printScene.rotateX(-PI/2);
  printScene.rotateY(PI/4);
  printScene.translate(0, 50, -60);
  printScene.image(skyBackground, 0, 0, printScene.width, printScene.height * 1.15);
  printScene.popMatrix();

  printScene.pushMatrix();
  printScene.translate(100, 0, 140);
  printScene.directionalLight(150, 120, 90, 0, 0, -1);//black light

  printScene.pointLight(25, 150, 205, 300, 4000, 100);
  printScene.pointLight(154, 110, 120, 0, 4000, -1500);//bluer bottom

  printScene.directionalLight(150, 80, 50, -1, 0, 0); //side shadow

  printScene.pointLight(250, 170, 70, 600, 0, 200);//pink top
  printScene.pointLight(154, 110, 210, 800, 200, 0);//bluer bottom

  threeDGrid(pixelGrid, 750);
  printScene.popMatrix();
  printScene.endDraw();
  printScene.save("poster.jpg");
  state = "start";
}
void isItNorthCornerBlock(int row, int col, int buildingValue) {//given row col of a building block, we need to know if it the 
  //check to see if there's any neighbor to the left, right
}

//color valueToColor(int value){
//  //COLOR CHANGES
//  color cc = color(255, 0, 0); //black return default is no value attached
//   switch(value) {
//          case 1:
//            cc = color(51, 255, 220);//green for sustainability
//           break;
//          case 2:
//            cc = color(18,135, 255); //orange for culture
//            break;
//          case 3:
//            cc = color(39,205, 255); //blue for opportunity
//            break;
//          default:
//            break;
//    }
//   return cc;
//}
void threeDGrid(int[][] grid, int totalSize) {//helper function
  int w = int(totalSize/ grid[0].length);
  int h = w;

  for (int z = 2; z<1000; z+=4) {
    noiseGrid(grid.length, grid[0].length, totalSize, z);
  }

  for (int row = 0; row < grid.length; row ++) {
    int y = int(row*h);
    for (int col = 0; col < grid[row].length; col++) {
      int x = int(col*w);
      if (grid[row][col] > 0) {//IF it's filled
        printScene.pushMatrix();
        int howTallBuilding = 50;
        printScene.translate(x, y, howTallBuilding*0.5);

        //COLOR CHANGES
        //color cc = valueToColor(grid[row][col]);
        color cc = color(255, 0, 0);
        printScene.fill(cc);
        printScene.box(w, h, howTallBuilding); // maybe we can have box come from ground downward?
        printScene.pushMatrix();
        printScene.rotateX(-PI/2);
        printScene.rect(0, 0, 2, -180);//the line to go up from square
        printScene.textFont(regular, 18);
        printScene.rotateY(PI/4);
        printScene.text("HelloWorld", 0, -180);
        printScene.popMatrix();
        printScene.popMatrix();

        printScene.pushMatrix();
        printScene.strokeWeight(1);
        float tallness = 150*noise(x/100, y/100) + 50;
        printScene.translate(x, y, tallness/-2);
        printScene.fill(255, 0, 255);
        printScene.box(w, h, tallness);
        printScene.popMatrix();
      }
    }
  }
}
void noiseGrid(int rows, int columns, int totalSize, int z) {
  int w = int(totalSize/ columns);
  int h = w;

  for (int row = 0; row < rows; row ++) {
    int y = int(row*h);
    for (int col = 0; col < columns; col++) {
      int x = int(col*w);
      int zStep = int(100*noise(x/100 + 1000, y/40 + 100));
      if (noise(x/100, y/300, z/90) > 0.63) {
        printScene.pushMatrix();
        printScene.translate(x, y, -z);
        printScene.fill(255, 0, 255);
        printScene.box(w, h, 4);
        printScene.popMatrix();
      }
    }
  }
}
void transitionAnimationToPrint() {//after the poster world is generated and the desired true state already set, this displays to the projection
  int transitionTime = 80;
  float tableY = 0;
  if (framesSinceChangeInState < transitionTime) {//arbitrary for now frame number changing the light
    //desired light to go towards - 150,120,90
    float proportion = framesSinceChangeInState / transitionTime;
    printScene.directionalLight(255 - proportion*105, 120*proportion, 255 - 165*proportion, 0, 0, -1);//black light starts off white
  } else if (framesSinceChangeInState < transitionTime*2) {//transition to camera angle
    float proportion = (framesSinceChangeInState % transitionTime) / transitionTime;
    printScene.camera();
  } else if (framesSinceChangeInState < transitionTime * 3) {
    float proportion = (framesSinceChangeInState % (2*transitionTime)) / transitionTime;
    tableY = height * proportion;
  }
  tableScreen.image(printScene, width/2, height/2, width, height);
}
