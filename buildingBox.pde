class buildingBox {

  TuioObject originObj;       // TUIO Marker Obj

  int      markerId;          // Fiducial ID
  float    radianRot;         // let's us know how to rotate the foot print float rotationInTwoPI

  TableRow currentRow;        // Fiducial ID

  // FOOTPRINT
  int[][] footprint;          //building foot print in the form of a 3 x 3 arrray
  int[][] correctedFootprint;

  // ???
  PVector centerOfBuilding;   //the marker will walways be in the middle of the footprint array, and is given as a rol and col from the overall screen's grid

  // CV
  PVector  CVPosition;        // the position of that marker in the pixel space of the camera (HOPEFUlly WON't NEED)
  char     dirFacing;

  // NSR INFO
  String   NSRvalue;          //is it blue, orange, or green, aka, opportubnity, culture, or sustainability? 
  String   NSRorgName;        //name of organization attached to this building
  String   NSRcolorName;
  color    NSRcolor;
  String   buildingName;      //aka, what 'type' of building is it (PROBABLY WON'T usE)

  // PROJECTOR SPACE VARS
  PVector  textTarget;        //the 'ideal' projector spacecenter point for where the text label of the org name should 
  PVector  textPos;           //current position of the text label

  // ANIMATION
  int      startFrame;             // the frameCount at the moment of the building's creation, this is useful for animation
  int      stopFrame;              // the frameCount at the moment of the building disappearing, will check for time elapsed to see if sinply repositioned, or totally taken off

  int row;
  int col;

  buildingBox(TuioObject objToConstructFrom) {

    // Store TUIO Marker Object In Case It is needed later
    originObj    = objToConstructFrom;

    // ID of Fiducial
    markerId     = originObj.getSymbolID();
    radianRot    = originObj.getAngle();

    // Retrieve the Row with information using the Marker
    currentRow   = markerMap.findRow(str(markerId), "MarkerID");

    buildingName = getName();
    NSRcolorName = getColour();
    NSRvalue     = getValue();

    footprint    = loadFootprint();

    dirFacing    = radianToDirection(); 

    correctedFootprint    = rotateGrid(footprint, dirFacing);

    row = (int)whereIsThisObj(originObj).x;
    col  = (int)whereIsThisObj(originObj).y;

    /*
    THINGS TO WRITE
     
     // FIND ORG   "NSRorgName"
     
     // NSR color  setValueToColor();
     
     //Center of building needs to be set first!!!!!
     
     //the text always starts at the center of the building
     ? textPos = centerOfBuilding;
     
     */
  }

  String getName() {
    println(currentRow);
    return currentRow.getString("Name");
  }

  int[][] loadFootprint() {
    return floorTypes[currentRow.getInt("FootprintRef")];
  }

  char radianToDirection() {
    float r = radianRot;
    if      (r < PI     / 4   &&   r > (7*PI) / 4) { 
      return 'n';
    } else if (r > PI     / 4   &&   r < (3*PI) / 4) { 
      return 'w';
    } else if (r > (3*PI) / 4   &&   r < (5*PI) / 4) { 
      return 's';
    } else { 
      return 'e';
    }
  }

  int[][] rotateGrid(int[][] gridArray, char rotation) {
    int [][] newGrid = {{0, 0, 0}, {0, 0, 0}, {0, 0, 0}};
    int gridLen = gridArray[0].length;

    switch(rotation) {
    case 'n': 
      println("// Flip Upside Down");
      for (int row = gridLen-1; row >= 00; row--) {
        for (int col = gridLen-1; col >= 0; col--) {
          int tempRow = gridLen - 1 - row;
          int tempCol = gridLen - 1 - col;
          newGrid[tempRow][tempCol] = gridArray[row][col];
        }
      }     
      break;
    case 'e':
      println("// Rotate 90° right");

      for (int col = 0; col < gridLen; col++) {
        for (int row = gridLen-1; row >= 0; row--) {
          int tempRow = gridLen - 1 - row;
          newGrid[col][tempRow] = gridArray[row][col];
        }
      }
      break;
    case 'w':
      println("// Rotate 90° left");
      for (int row = gridLen-1; row >= 0; row--) {
        for (int col = 0; col < gridLen; col++) {
          int tempRow = gridLen - 1 - row;

          newGrid[tempRow][col] = gridArray[col][row];
        }
      }
      break;
    default:
      println("// Do Not Rotate");
      break;
    }
    return newGrid;
  }

  int getID() {
    return markerId;
  }

  int getRow() {
    return row;
  }

  int getCol() {
    return col;
  }

  float getX() {
    return originObj.getX();
  }

  float getY() {
    return originObj.getY();
  }
  float  getRotation() {
    return radianRot;
  }

  int getDir() {
    return dirFacing;
  }

  int[][] getFootprint() {
    return footprint;
  }

  String getValue() {
    return currentRow.getString("Category");
  }

  String getColour() {
    return currentRow.getString("Colour");
  }

  void setValueToColor() {
    //COLOR CHANGES
    switch(this.NSRvalue) {
    case "culture":
      this.NSRcolor = color(255, 225, 200);//orange
      break;
    case "sustainability":
      this.NSRcolor = color(200, 255, 200); //green
      break;
    case "blue":
      this.NSRcolor = color(200, 200, 255); //blue for opportunity
      break;
    default:
      break;
    }
  }
}
