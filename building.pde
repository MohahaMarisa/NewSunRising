void setTextTarget() {
  //look for an empty spot in the front of the building
}
void setOrgName() {  //grabs the global pinPos which is rol and col
  for (int i = 0; i < initiatives.getRowCount(); i++) {

    TableRow currentRow = initiatives.getRow(i);
    String firstNameMatch = currentRow.getString("Organization or Project Name");
    if (!this.alreadyDisplayed(firstNameMatch)) {
      NSRorgName = firstNameMatch;
    }
  }
}
Boolean alreadyDisplayed(String nameMatch) {//is this initiative not already displayed? 
  for (int i = 0; i < initiativesDisplayed.size(); i++) {
    String alreadyThere = initiativesDisplayed.get(i);
    if (nameMatch.equals(alreadyThere)) {
      return true;
    }
  }
  return false;
}
//helper functions for displaying footprint to the projectyor space
//takes grid column number, returns the tableScreen's y coordinate for the center of that square
float colToX(int col) {//returns the center point of that cell
  float x = col*cellWidth + col*gridGutter + cellWidth/2;
  return x;
}

float rowToY(int row) {//returns the center point of that cell
  float y = row*cellWidth + row*gridGutter + cellWidth/2;
  return y;
}

void setValueToColor() {
  //COLOR CHANGES
  switch(this.NSRvalue) {
  case "Culture":
    this.NSRcolor = color(255, 225, 200);//orange
    break;
  case "Sustainability":
    this.NSRcolor = color(200, 255, 200); //green
    break;
  case "Opportunity":
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
          tableScreen.text(this.NSRorgName, this.textPos.x, this.textPos.y);
          tableScreen.popMatrix();
        }
      }
    }
    this.textPos = this.textPos*0.95 + this.textTarget*0.05;//!!idk if vectors can be multiplied like this
  }
  tableScreen.popMatrix();
}



void updateFootprint() {//given orientation, rotate the footprint
}

void findMyTextTarget() {
  this.textTarget = new PVector(0, 0);//REPLACE MEEEEE
} 
}

void printGrid(int[][] gridArray) {

  // get the size of the grid
  int gridLen = gridArray[0].length;

  // iterate & print 
  for (int i = 0; i < gridLen; i++) {
    for (int k = 0; k < gridLen; k++) {
      print(gridArray[i][k]);
    }
    println();
  }
}

void debugPrint(int curNum, int row, int col) {
  print(" (" + curNum + ")" + " row:", str(row) + " col:", str(col));
}
//this is the program that reads the marker CV filled grid and determines if there's a new building


/*every frame from the cv, fills into the current board
 */


//everytime a TUIO object is created ascvcording to if the CV sees anythiong, check if that unique marker is already a building object inside the global array of building objects
//if it isn't alreadya  marker in the building array, instantiate a new building
