/*
void readGridToObjs(int[][] board) {
  int boardRows = board.length;
  int boardCols = board[0].length;

  for (int row = 0; row < boardRows; row++) {
    for (int col = 0; col < boardCols; col++) {
      int currentPos = board[row][col];

      if (currentPos > 0) {
        //TableRow tableRow = markerMap.getRow(currentPos);
        TableRow result = markerMap.findRow(str(currentPos), "MarkerID");
        //print(result);
        print( "[" + board[row][col]+  "] ");
        println(result.getString("Name"));
      }
    }
  }
}
*/
