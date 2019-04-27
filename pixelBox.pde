class pixelBox {

  int markerId;
  String instituteName;
  String valueCategory;
  char dirFacing;
  int[][] pixelBox =  {
    {0, 0, 0}, 
    {0, 0, 0}, 
    {0, 0, 0}
  };
  int row;
  int col;

  pixelBox(int TUIOid, int locRow, int locCol, float rotation) {
    //instituteName = getName(markerID);

    markerId = TUIOid;
    valueCategory = regressCategory();
    dirFacing = convertRotation(rotation); 
    //int[][] pixelBox = getFloorPlan();
    //pixelBox = transformPixelBox();
    row = locRow;
    col = locCol;
  }

  int[][] getFloorPlan() {
    println(markerId);
    println(markerStartingPoint);



    int floorPlanMapIndex = markerId - markerStartingPoint - 1; // for example (118) - 90 = 28, so look for corresponding floorplan, ie "markerFloorPlanMap[28]"
    println("floorPlanMapIndex", floorPlanMapIndex, "indexing into markerFloorPlanMap, of length ", markerFloorPlanMap.length);
    int floorTypeIndex = markerFloorPlanMap[floorPlanMapIndex]; // floorTypeIndex between [0, 4] meaning used to lookup int[][] in 3D floorTypes array
    println("floorTypeIndex: ", floorTypeIndex);
    return floorTypes[floorTypeIndex];
  }

  char convertRotation(float rotationInTwoPI) {
    float r = rotationInTwoPI;
    if            (r < PI    /4   &&   r > (7*PI)/4) { 
      return 'n';
    } else if     (r > PI    /4   &&   r < (3*PI)/4) { 
      return 'w';
    } else if     (r > (3*PI)/4   &&   r < (5*PI)/4) { 
      return 's';
    } else { 
      return 'e';
    }
  }


  int[][] transformPixelBox() {
    //  using inititalPixelBox & dirFacing
    // if (dir == n) do nothing
    // if (dir == w) rotate  90 counter clockwise
    // if (dir == e) rotate  90         clockwise
    // if (dir == s) rotate 180
    return null;
  }

  int getRow() {
    return row;
  }

  int getCol() {
    return col;
  }

  int getDir() {
    return dirFacing;
  }

  int[][] getBox() {
    return pixelBox;
  }

  String getValue() {
    return valueCategory;
  }

  // // later
  //     String getName(int TUIOId) {
  //   // write this later 
  // }
}
