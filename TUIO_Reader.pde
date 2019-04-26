import TUIO.*;

TuioProcessing tuioClient; // declare a TuioProcessing client

// these are some helper variables which are used
// to create scalable graphical feedback
float cursor_size = 15;
float object_size = 60;
float table_size = 760;
float scale_factor = 1;
//PFont font;

boolean verbose = false; // print console debug messages
boolean callback = true; // updates only after callbacks

// --------------------------------------------------------------

// OBJECT ADDED
void addTuioObject(TuioObject tobj) {
  // sound for playing

  file.play();
  // Get Angle
  //println(tobj.getAngle());

  int newId = tobj.getSymbolID();

  if (newId == calibraterID) { //marker
    calibrater = tobj;
    println("calibrater down");
  } else if (newId == pinID) {
    println("pin down");
    TUIOPin = tobj;

    int pinRow = (int)whereIsThisObj(TUIOPin).x;
    int pinCol = (int)whereIsThisObj(TUIOPin).y;

    pin = new Building(pinID, pinRow, pinCol, TUIOPin.getAngle());
  } else {
    listOfMarkers.add(tobj);
    //println(listOfMarkers);
  }

  if (verbose) println("add obj "+tobj.getSymbolID()+" ("+tobj.getSessionID()+") "+tobj.getX()+" "+tobj.getY()+" "+tobj.getAngle());
}

// OBJETCT UPDATED 
void updateTuioObject (TuioObject tobj) {
  //println(tobj.getAngle());

  int newId = tobj.getSymbolID();

  if (newId == calibraterID) { //marker
    calibrater = tobj;
  } 

  if (verbose) println("set obj "+tobj.getSymbolID()+" ("+tobj.getSessionID()+") "+tobj.getX()+" "+tobj.getY()+" "+tobj.getAngle()
    +" "+tobj.getMotionSpeed()+" "+tobj.getRotationSpeed()+" "+tobj.getMotionAccel()+" "+tobj.getRotationAccel());
}

// OBJECT REMOVED
void removeTuioObject(TuioObject tobj) {
  int newId = tobj.getSymbolID();
  if (newId == calibraterID) { //marker
    calibrater = null;
    println("calibrater up");
  } else if (newId == pinID) {
    println("pin up");
    TUIOPin = null;
    pin = null;
  } else {
    listOfMarkers.remove(tobj);
  }
  //println(listOfMarkers);
  if (verbose) println("del obj "+tobj.getSymbolID()+" ("+tobj.getSessionID()+")");
}

// --------------------------------------------------------------

// called at the end of each TUIO frame
void refresh(TuioTime frameTime) {
  //if (verbose) println("frame #"+frameTime.getFrameID()+" ("+frameTime.getTotalMilliseconds()+")");
  if (callback) redraw();
}

/*
// --------------------------------------------------------------
 
 // called when a cursor is added to the scene
 void addTuioCursor(TuioCursor tcur) {
 if (verbose) println("add cur "+tcur.getCursorID()+" ("+tcur.getSessionID()+ ") " +tcur.getX()+" "+tcur.getY());
 //redraw();
 }
 
 // called when a cursor is moved
 void updateTuioCursor (TuioCursor tcur) {
 if (verbose) println("set cur "+tcur.getCursorID()+" ("+tcur.getSessionID()+ ") " +tcur.getX()+" "+tcur.getY()
 +" "+tcur.getMotionSpeed()+" "+tcur.getMotionAccel());
 //redraw();
 }
 
 // called when a cursor is removed from the scene
 void removeTuioCursor(TuioCursor tcur) {
 if (verbose) println("del cur "+tcur.getCursorID()+" ("+tcur.getSessionID()+")");
 //redraw()
 }
 
 // --------------------------------------------------------------
 // called when a blob is added to the scene
 void addTuioBlob(TuioBlob tblb) {
 
 if (verbose) println("add blb "+tblb.getBlobID()+" ("+tblb.getSessionID()+") "+tblb.getX()+" "+tblb.getY()+" "+tblb.getAngle()+" "+tblb.getWidth()+" "+tblb.getHeight()+" "+tblb.getArea());
 //redraw();
 }
 
 // called when a blob is moved
 void updateTuioBlob (TuioBlob tblb) {
 if (verbose) println("set blb "+tblb.getBlobID()+" ("+tblb.getSessionID()+") "+tblb.getX()+" "+tblb.getY()+" "+tblb.getAngle()+" "+tblb.getWidth()+" "+tblb.getHeight()+" "+tblb.getArea()
 +" "+tblb.getMotionSpeed()+" "+tblb.getRotationSpeed()+" "+tblb.getMotionAccel()+" "+tblb.getRotationAccel());
 //redraw()
 }
 
 // called when a blob is removed from the scene
 void removeTuioBlob(TuioBlob tblb) {
 if (verbose) println("del blb "+tblb.getBlobID()+" ("+tblb.getSessionID()+")");
 //redraw()
 }
 
 
 
 // within the draw method we retrieve an ArrayList of type <TuioObject>, <TuioCursor> or <TuioBlob>
 // from the TuioProcessing client and then loops over all lists to draw the graphical feedback.
 
 void tuioDraw()
 {
 //background(255);
 noStroke();
 fill(0);
 textFont(regular, 18*scale_factor);
 float obj_size = object_size*scale_factor; 
 float cur_size = cursor_size*scale_factor; 
 
 ArrayList<TuioObject> tuioObjectList = tuioClient.getTuioObjectList();
 for (int i=0; i<tuioObjectList.size(); i++) {
 TuioObject tobj = tuioObjectList.get(i);
 stroke(0);
 fill(0, 0, 0);
 pushMatrix();
 translate(tobj.getScreenX(width), tobj.getScreenY(height));
 rotate(tobj.getAngle());
 rect(-obj_size/2, -obj_size/2, obj_size, obj_size);
 popMatrix();
 fill(255);
 text(""+tobj.getSymbolID(), tobj.getScreenX(width), tobj.getScreenY(height));
 }
 
 ArrayList<TuioCursor> tuioCursorList = tuioClient.getTuioCursorList();
 for (int i=0; i<tuioCursorList.size(); i++) {
 TuioCursor tcur = tuioCursorList.get(i);
 ArrayList<TuioPoint> pointList = tcur.getPath();
 
 if (pointList.size()>0) {
 stroke(0, 0, 255);
 TuioPoint start_point = pointList.get(0);
 for (int j=0; j<pointList.size(); j++) {
 TuioPoint end_point = pointList.get(j);
 line(start_point.getScreenX(width), start_point.getScreenY(height), end_point.getScreenX(width), end_point.getScreenY(height));
 start_point = end_point;
 }
 
 stroke(192, 192, 192);
 fill(192, 192, 192);
 ellipse( tcur.getScreenX(width), tcur.getScreenY(height), cur_size, cur_size);
 fill(0);
 text(""+ tcur.getCursorID(), tcur.getScreenX(width)-5, tcur.getScreenY(height)+5);
 }
 }
 
 ArrayList<TuioBlob> tuioBlobList = tuioClient.getTuioBlobList();
 for (int i=0; i<tuioBlobList.size(); i++) {
 TuioBlob tblb = tuioBlobList.get(i);
 stroke(0);
 fill(0);
 pushMatrix();
 translate(tblb.getScreenX(width), tblb.getScreenY(height));
 rotate(tblb.getAngle());
 ellipse(-1*tblb.getScreenWidth(width)/2, -1*tblb.getScreenHeight(height)/2, tblb.getScreenWidth(width), tblb.getScreenWidth(width));
 popMatrix();
 fill(255);
 text(""+tblb.getBlobID(), tblb.getScreenX(width), tblb.getScreenX(width));
 }
 }
