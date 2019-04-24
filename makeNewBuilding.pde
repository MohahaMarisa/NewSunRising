//this is the program that reads the marker CV filled grid and determines if there's a new building
int[][] currentBoard = {
    {00, 00, 00, 00, 00, 00, 00, 00, 00}, 
    {00, 92, 00, 00, 00, 00, 00, 00, 00}, 
    {00, 00, 00, 90, 00, 00, 00, 00, 00}, 
    {00, 00, 90, 00, 00, 00, 00, 00, 00}, 
    {00, 00, 00, 00, 00, 00, 92, 00, 00}, 
    {00, 00, 00, 00, 00, 00, 00, 00, 00}
};

int[][] previousBoard = {
  {00, 00, 00, 00, 00, 00, 00, 00, 00}, 
  {00, 92, 00, 00, 00, 00, 00, 91, 00}, 
  {00, 00, 00, 92, 00, 00, 00, 00, 00}, 
  {00, 00, 90, 00, 00, 00, 00, 00, 00}, 
  {00, 92, 00, 00, 00, 00, 92, 00, 00}, 
  {00, 00, 00, 00, 00, 00, 00, 00, 00}
};

/*every frame from the cv, fills into the current board
*/


//everytime a TUIO object is created ascvcording to if the CV sees anythiong, check if that unique marker is already a building object inside the global array of building objects
//if it isn't alreadya  marker in the building array, instantiate a new building
