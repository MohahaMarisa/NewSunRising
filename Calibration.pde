final int pinID        = 178; //<>//
final int calibraterID = 97;

int numRows = pixelGrid.length;
int numCols = pixelGrid[0].length;

int curRow = 0;
int curCol = 0;

PVector[][] centerPoints = new PVector[numRows][numCols];


TuioObject calibrater;

PVector test = new PVector(2.3, 4.5); 

void calibrateOneSquare() {
  if (state == "cameraCalibration") {
    //save centerPoint for current square and then advance to next
    if (calibrater == null) {
      //play bad sound
      fail.play();
    } else {

      PVector calibraterCenter = new PVector(calibrater.getX(), calibrater.getY());

      centerPoints[curRow][curCol] = calibraterCenter;
      lock.play();
      println("[" + curRow + "] [" + curCol + "] is " + centerPoints[curRow][curCol]);

      if (curRow == numRows - 1 && curCol == numCols - 1) { // calibration complete 

        println("calibration done");

        //state = "start"; // change state to start

        resetTimer();
      } else {
        // move through calibrating everything
        if (curCol == numCols - 1) {
          curCol = 0;
          curRow++;
        } else {
          curCol++;
        }
      }
    }
  }
}

void saveCalibration() {
  Table table = new Table();
  table.addColumn();
  table.addColumn();
  int tableCounter = 0;
  for (int row = 0; row < centerPoints.length; row++) {
    for (int col = 0; col < centerPoints[row].length; col++) {
      //.setInt(row, column, value)
      float x = centerPoints[row][col].x;
      float y = centerPoints[row][col].y;
      table.addRow();
      table.setFloat(tableCounter, 0, x);
      table.setFloat(tableCounter, 1, y);
      //println("table got a y of "+ table.getFloat(tableCounter, 1));
      //println("the pvector from the center array had " + centerPoints[row][col].y);
      tableCounter+=1;
    }
  }
  saveTable(table, "data/centerPoints.csv");
}
PVector[][] loadCalibration() { //return a 2D array of PVectors 
  PVector[][] savedCenterPts = new PVector[pixelGrid.length][pixelGrid[0].length]; //6 rows, 9 columns

  Table savedCalibration;
  savedCalibration = loadTable("centerPoints.csv");
  println("loaded centerPoints.csv");
  println(savedCalibration.getRowCount() + " total rows in table");

  int tableCounter = 0; //helps determine which row col in the 2d array the pvector should go
  for (int i = 0; i< savedCalibration.getRowCount(); i++) {
    //set the isWaiting flag (0,1) b
    //.getInt(row, column)
    float x = savedCalibration.getFloat(i, 0);
    float y = savedCalibration.getFloat(i, 1);

    PVector centerPt = new PVector(x, y);

    int returnRow = (int)(tableCounter/pixelGrid[0].length);
    int returnCol = tableCounter % pixelGrid[0].length;
    //println(returnRow, " ", returnCol);
    savedCenterPts[returnRow][returnCol] = centerPt;

    tableCounter += 1;
  }

  //print out the saved center points
  for (int r = 0; r < savedCenterPts.length; r++) {
    //println("row " + r);
    for (int c = 0; c < savedCenterPts[0].length; c++) {
      //print( "(" + savedCenterPts[r][c].x + ", " + savedCenterPts[r][c].y + ")");
    }
  }
  return savedCenterPts;
}

void cameraCalibGrid() {

  for (int row = 0; row < centerPoints.length; row ++) {
    for (int col = 0; col < centerPoints[row].length; col++) {

      if (centerPoints[row][col] != null) {
        PVector localCen = centerPoints[row][col];
        // this won't work because a camera-space to screen-space transformation is necesarry 
        drawCircle(localCen.x, localCen.y, 25, 25, color(255, 0, 0));
      }
    }
  }
  lightUpSquare(curRow, curCol, #FFFFFF);
}
void lightUpSquare(int row, int col, color colour) {
  tableScreen.pushMatrix();
  tableScreen.rectMode(CENTER);

  float y = rowToY(row);
  float x = colToX(col);

  tableScreen.fill(colour);
  tableScreen.stroke(0);
  tableScreen.rect(x, y, cellWidth*1.2, cellWidth*1.2);
  tableScreen.popMatrix();
}

void drawCircle(float xPos, float yPos, float wid, float hei, color colour) {
  tableScreen.pushMatrix();
  tableScreen.ellipseMode(CENTER);


  tableScreen.fill(colour);
  tableScreen.stroke(0);
  tableScreen.ellipse(xPos, yPos, wid, hei);
  tableScreen.popMatrix();
}

//helper function that takes grid column number, returns the tableScreen's y coordinate for the center of that square
float colToX(int col) {//returns the center point of that cell
  float x = col*cellWidth + col*gridGutter + cellWidth/2;
  return x;
}


float rowToY(int row) {//returns the center point of that cell
  float y = row*cellWidth + row*gridGutter + cellWidth/2;
  return y;
}

int[] stringIntToIntArray (String passedString) { //from Caden Sumner <https://www.quora.com/How-do-I-convert-a-string-to-integer-array-in-Java> 
  passedString = "3,0,0,0,1,3,0,0,1,0,1,0,0,3,2,0,0,2,3,4,2,1,1,2,1,-1,3,4,-1,-1,-1,3,-1,-1,-1,-1,0,0,"; 

  // The string you want to be an integer array.
  String[] integerStrings = passedString.split(","); 

  // Splits each spaced integer into a String array.
  int[] newIntArray = new int[integerStrings.length]; 

  // Creates the integer array.
  for (int i = 0; i < integerStrings.length; i++) {
    newIntArray[i] = Integer.parseInt(integerStrings[i]); 
    //Parses the integer for each string.
  }
  return newIntArray;
} 
