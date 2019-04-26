Table markerMap;
import java.util.*;


buildingBox pin; 


int markerStartingPoint = 90;

int[] markerFloorPlanMap = stringIntToIntArray("3,0,0,0,1,3,0,0,1,0,1,0,0,3,2,0,0,2,3,4,2,1,1,2,1,5,3,4,5,5,5,3,5,5,5,5,0,0,");

//ArrayList<TuioObject> listOfMarkers   = new ArrayList<TuioObject>();
ArrayList<buildingBox>   listOfBuildings = new ArrayList<buildingBox>();

void maintainInstitutes() {
  //for (TuioObject tuioObj : listOfMarkers) {

  //  // extract from TUIO Obj
  //  int   objID   = tuioObj.getSymbolID();
  //  int   objRow   = (int)whereIsThisObj(tuioObj).x;
  //  int   objCol   = (int)whereIsThisObj(tuioObj).y;
  //  float objRot = tuioObj.getAngle();

  //  // build pixelBox obj
  //  buildingBox pxBox = new buildingBox(objID, objRow, objCol, objRot);
  //  listOfBuildings.add(pxBox);
  //}
}

void highlightInstitutes() {
  testingGrid(#AAAAAA);
  for (buildingBox pxBox : listOfBuildings) {
    println(pxBox.radianOrientation);
    if (pxBox.getValue() == "Connectivity") {
      lightUpSquare(pxBox.getRow(), pxBox.getCol(), #FF7200);
    } else if (pxBox.getValue() == "Culture") {
      lightUpSquare(pxBox.getRow(), pxBox.getCol(), #EA1717);
    } else if (pxBox.getValue() == "Sustainability") {
      lightUpSquare(pxBox.getRow(), pxBox.getCol(), #99C24D);
    } else if (pxBox.getValue() == "Planning") {
      lightUpSquare(pxBox.getRow(), pxBox.getCol(), #4272F7);
    } else { // "Opportunity";
      lightUpSquare(pxBox.getRow(), pxBox.getCol(), #FCE837);
    }
  }
}

void lightUpMarkers() {

  //if (listOfMarkers.size() >= 1) {
  //  PVector markerPos  = whereIsThisObj(listOfMarkers.get(0));
  //  //println("current marker is at ", markerPos);

  //  lightUpSquare((int) markerPos.x, (int) markerPos.y, #ff4500);
  //}
}


//given marker, get pixel xy from camera and compare it to center points, whichever closest is 
//center point tells us what the row col of the marker is
PVector whereIsThisObj(TuioObject singleMark) {
  if (safeToCV != null) {
    float lX = singleMark.getX();
    float lY = singleMark.getY();

    float minDist = dist(lX, lY, centerPoints[0][0].x, centerPoints[0][0].y);
    int locCol = 0;
    int locRow = 0;

    for (int row = 0; row < centerPoints.length; row ++) {
      for (int col = 0; col < centerPoints[row].length; col++) {

        if (centerPoints[row][col] != null) { 

          float cX = centerPoints[row][col].x;
          float cY = centerPoints[row][col].y;

          float newMinDist = dist(lX, lY, cX, cY);

          if ( newMinDist < minDist ) {
            minDist = newMinDist;
            locCol = col;
            locRow = row;
          }
        }
      }
    }
    return new PVector(locRow, locCol, 0);
  }
  return new PVector(-10, -10, 0);
}
