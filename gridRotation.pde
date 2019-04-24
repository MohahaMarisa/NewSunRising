void readGridToObjs(int[][] board) {
  int boardRows = board.length;
  int boardCols = board[0].length;

  for (int row = 0; row < boardRows; row++) {
    for (int col = 0; col < boardCols; col++) {
      int currentPos = board[row][col];

      if (currentPos > 0) {
        //TableRow tableRow = markerMap.getRow(currentPos);
        TableRow result = markerMap.findRow(str(currentPos), "Marker IDs");
        //print(result);
        print( "!~!" + board[row][col]+  "!~!");
        println(result.getString("Name"));
        
      }
    }
  }
}








int[][] rotateGrid(int[][] gridArray, char rotation) {
  int [][] newGrid = {{0, 0, 0}, {0, 0, 0}, {0, 0, 0}};
  int gridLen = gridArray[0].length;

  switch(rotation) {
  case 'U': 
    println("// Flip Upside Down");
    for (int row = gridLen-1; row >= 00; row--) {
      for (int col = gridLen-1; col >= 0; col--) {
        int tempRow = gridLen - 1 - row;
        int tempCol = gridLen - 1 - col;
        newGrid[tempRow][tempCol] = gridArray[row][col];
      }
    }     
    break;
  case 'R':
    println("// Rotate 90° right");

    for (int col = 0; col < gridLen; col++) {
      for (int row = gridLen-1; row >= 0; row--) {
        int tempRow = gridLen - 1 - row;
        newGrid[col][tempRow] = gridArray[row][col];
      }
    }
    break;
  case 'L':
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
