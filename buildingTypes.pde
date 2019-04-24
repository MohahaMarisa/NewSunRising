
int[][][] floorTypes = {

  // [ 0 ] oneXone
  {
    {0, 0, 0}, 
    {0, 1, 0}, 
    {0, 0, 0}

  }, 

  // [ 1 ] oneXtwo
  {
    {0, 0, 0}, 
    {1, 1, 0}, 
    {0, 0, 0}

  }, 

  // [ 2 ] oneXthree
  {
    {0, 0, 0}, 
    {1, 1, 1}, 
    {0, 0, 0}

  }, 

  // [ 3 ] twoXtwo
  {
    {1, 1, 0}, 
    {1, 1, 0}, 
    {0, 0, 0}

  }, 

  // [ 4 ] twoXthree
  {
    {1, 1, 1}, 
    {1, 1, 1}, 
    {0, 0, 0}

  }

};

int[][][] testBoards = {

  {
    {00, 00, 00, 00, 00, 00, 00, 00, 00}, 
    {00, 92, 00, 00, 00, 00, 00, 00, 00}, 
    {00, 00, 00, 90, 00, 00, 00, 00, 00}, 
    {00, 00, 90, 00, 00, 00, 00, 00, 00}, 
    {00, 00, 00, 00, 00, 00, 92, 00, 00}, 
    {00, 00, 00, 00, 00, 00, 00, 00, 00}
  },


  {
    {00, 00, 00, 00, 00, 00, 00, 00, 00}, 
    {00, 92, 00, 00, 00, 00, 00, 91, 00}, 
    {00, 00, 00, 92, 00, 00, 00, 00, 00}, 
    {00, 00, 90, 00, 00, 00, 00, 00, 00}, 
    {00, 92, 00, 00, 00, 00, 92, 00, 00}, 
    {00, 00, 00, 00, 00, 00, 00, 00, 00}
  }
};

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
