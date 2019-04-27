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
    
    /* Fro m old building class
        markerId = TUIOid;
    valueCategory = regressCategory();
    dirFacing = convertRotation(rotation); 
    //int[][] pixelBox = getFloorPlan();
    //pixelBox = transformPixelBox();
    row = locRow;
    col = locCol;
    setOrgName();
    setValueToColor();        //set the NSR color

    //Center of building needs to be set first!!!!!
    //the text always starts at the center of the building
    textPos = centerOfBuilding;
    */
    
    this.NSRorgName = setOrgName();
  }
  String setOrgName(){
   for (TableRow row : table.findRows(zipcode, "Zip Code")) {
      if(row.getString("Vibrant Communities Strategy").equals(this.NSRvalue)){
         if(!repeatName(row.getString("Organization or Project Name"))){
           return(row.getString("Organization or Project Name"));
         }
      }
    }
    for (TableRow row : table.findRows(zipcode, "Zip Code")) {
      if(row.getString("Vibrant Communities Strategy").equals(this.NSRvalue)){
         if(!repeatName(row.getString("Organization or Project Name"))){
           return(row.getString("Organization or Project Name"));
         }
      }
    }
    initiatives.findRows(zipcode, "Zip Code");
    this.NSRorgName = "";
  }
  Boolean repeatName(String name){//is the name repeated before
    for(buildingBox another : listOfBuildings){
      if(name.equals(another.NSRorgName)){
        return True;
      }
    }
    return False;
  }
  String regressCategory () {
    int catEnum = markerId % 5;
    if (catEnum == 0) {
      return "Connectivity";
    } else if (catEnum == 1) {
      return "Culture";
    } else if (catEnum == 2) {
      return "Sustainability";
    } else if (catEnum == 3) {
      return "Planning";
    } else {
      return "Opportunity";
    }

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
  void display() {//this is marisa drawing to projector's canvas space
  tableScreen.pushMatrix();
  tableScreen.rectMode(CENTER);
  int halfOfFootprintLength = floor(this.footprint.length / 2);

  for (int footprintRow = -1 * halfOfFootprintLength; footprintRow < this.footprint.length - halfOfFootprintLength; footprintRow ++) { //go through the rows in the foot print
    int projectorRow = footprintRow + int(this.centerOfBuilding.x);

    if (projectorRow < projectorGridRows && projectorRow > 0) {//aka, if the footprint is even entirely on the projector screen grid space at all

      float y = rowToY(projectorRow);

      for (int footprintCol = -1 * halfOfFootprintLength; footprintCol <this.footprint.length - halfOfFootprintLength; footprintCol++) { //go through the cols in the footprint
        int projectorCol = footprintCol + int(this.centerOfBuilding.y);
        if (projectorCol < projectorGridCols && projectorCol > 0) {//aka, if the footprint is even entirely on the projector screen grid space at all
          float x = colToX(projectorCol);
          tableScreen.fill(this.NSRcolor);
          tableScreen.noStroke();
          tableScreen.rect(x, y, tableScreen.width/projectorGridCols, tableScreen.width/projectorGridCols);
          tableScreen.pushMatrix();
          tableScreen.fill(255);
          tableScreen.textAlign(CENTER);
          tableScreen.textSize(32);
          tableScreen.translate(this.textPos.x, this.textPos.y);
          tableScreen.rotate(this.radianOrientation);
          tableScreen.text(this.NSRorgName, 0, 0);
          tableScreen.popMatrix();
        }
      }
    }
    this.textPos = new PVector(this.textPos.x*0.95 + this.textTarget.x*0.05, this.textPos.y*0.95 + this.textTarget.y*0.05);
  }
  tableScreen.popMatrix();
  }
}
