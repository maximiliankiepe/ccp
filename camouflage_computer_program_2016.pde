/**********************************************

  Camouflage Computer Program
  
  A computer program that hides itself

  Maximilian Kiepe, 20 August 2016

**********************************************/

// IMPORT ABSTRACT WINDOW TOOLKIT LIBRARIES
import java.awt.Robot;
import java.awt.AWTException;
import java.awt.Rectangle;

// SET VARIABLES
final int[] xy = new int[2];
boolean flag;
PImage screenshot; 

// SETUP
void setup() {
  surface.setLocation(displayWidth,displayHeight); // sets the initial window outside of the screen, so that there is no blank frame in the screenshot
  size(400,400); //define size of window sketch
  flag = false; // set var to false
  screenshot(); // call function screenshot
  screenshot.save(dataPath("") + "/screenshot.jpg"); //save screenshot to data folder
}

// LOOP FUNCTIONS
void draw() {
  // set location of window once
  if (!flag) {
    surface.setLocation(200, 200);
    flag = true;
  }  
  
  getWindowLocation(this, xy); // call function and get the location of the sketch window
  
  PImage img; // define new PImage
  img = loadImage("screenshot.jpg"); // load the screenshot.jpg
  image(img, 0, 0, 400, 400, xy[0], xy[1], 400, 400); // place it in the sketch window
  PImage copy = img.get(xy[0], xy[1]+22, 400, 400); // create a cutout of the image
  image(copy, 0, 0); // place the cutout of the image in the frame
} 
 
// FUNCTION TO TAKE A SCREENSHOT
void screenshot() {
  // handle exceptions
  try{
    Robot robot_Screenshot = new Robot(); // new robot class
    screenshot = new PImage(robot_Screenshot.createScreenCapture // create new Image with the screenshot 
    (new Rectangle(0,0,displayWidth,displayHeight))); // screenshot has wifth and height of the display  
  }
  catch (AWTException e){
  // signals that an AWT exception has occurred
  }
}

// CLASS TO GET LOCATION OF FRAME
static final int[] getWindowLocation(final PApplet pa, int... xy) {
   
  // declare variables
  final Object surf = pa.getSurface().getNative();
  final PGraphics canvas = pa.getGraphics();
     
  // get the psoition of the frame
  final java.awt.Component f = ((processing.awt.PSurfaceAWT.SmoothCanvas) surf).getFrame();
  xy[0] = f.getX();
  xy[1] = f.getY();
  
  // return corrdinates
  return xy;
}