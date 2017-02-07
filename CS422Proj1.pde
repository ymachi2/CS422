// uncomment these two lines to get audio in Processing
//import processing.sound.*;
//SoundFile beepSound;

// here is a processing.js solution from http://aaron-sherwood.com/processingjs/circleSound.html
// uncomment this line to get audio in Processing.js
Audio beepSound = new Audio();

// also note the soundfile needs to be in the data folder for processing and outside that folder for Processing.js
// sounds are also a bit slowerer to start up in Processing.js

// placeholder for future image
PImage img;
PImage bg;
PImage button;
PImage buttonSel;
PImage button2;
PImage button2Sel;
PImage timeWin;
PImage tempWin;
PImage onLight;
PImage offLight;
boolean started;

// some buttons
int[][] buttons = { {1100, 180}, {1100, 300}, {1100, 420}, {1100, 540}};
int[][] numbuttons = { {90, 300}, {150, 300}, {210, 300}, 
                       {90, 360}, {150, 360}, {210, 360},
                       {90, 420}, {150, 420}, {210, 420},
                       {90, 480}, {150, 480}, {210, 480}};
                       
int buttonX = 100;
int buttonY = 75;

// no buttons / mode currently selected
int selectedOne = -1;
int selectedNum = -1;
int prevSelected = -1;

int currentTime;
int inTime;
String inString = "";

PFont f;

/////////////////////////////////////////////////////

void loadSounds(){
  // beep soundfile shortened from http://soundbible.com/2158-Text-Message-Alert-5.html
  
  //Processing load sound
  //beepSound = new SoundFile(this, "bing.mp3");
  
  // processing.js load sound
  beepSound.setAttribute("src","bing.mp3");
}

void playBeep() {
  // play audio in processing or processing.js
  beepSound.play();
}

/////////////////////////////////////////////////////

void setup() {
  // set the canvas size
  size(1280, 800);
  
  // grab an image to use later
  // as with sounds Processing likes files in the data directory, Processing.js outside that directory
  img = loadImage("sketch2.gif", "gif");
  bg = loadImage("Toaster.png", "png");
  button = loadImage("redButt.png", "png");
  button2 = loadImage("redButt.png", "png");
  buttonSel = loadImage("selectRedButt.png", "png");
  button2Sel = loadImage("selectRedButt.png", "png");
  timeWin = loadImage("redGlass.png", "png");
  tempWin = loadImage("redGlass.png", "png");
  onLight = loadImage("blueLight.png", "png");
  offLight = loadImage("offBlueLight.png", "png");
  img.loadPixels();
  bg.loadPixels();
  button.loadPixels();
  button2.loadPixels();
  buttonSel.loadPixels();
  button2Sel.loadPixels();
  timeWin.loadPixels();
  tempWin.loadPixels();
  onLight.loadPixels();
  offLight.loadPixels();
  button.resize(100,75);
  button2.resize(50,50);
  buttonSel.resize(100,75);
  button2Sel.resize(50,50);
  timeWin.resize(175, 108);
  tempWin.resize(90, 50);
  onLight.resize(75,75);
  offLight.resize(75,75);
  
  currentTime = 0;
  inTime = 0;
  started = false;
  
  f = createFont("Arial",24,true);
  
  loadSounds();
}

/////////////////////////////////////////////////////

void draw() {
  String timeString;
  String secString;
  String minString;
  String tempString;
  int faren;
  int celc;
  
  background(bg);
  noStroke();
  textFont(f);
  textSize(27);
  fill(255,255,255);
  textAlign(CENTER);
    
  image(timeWin, 90, 185);  
  image(tempWin, 263, 186);
  if(started){
    image(onLight, 270, 245);
  }
  else{
    image(offLight, 270, 245);
  }
    
  // draw some buttons
  for (int loopCounter=0; loopCounter < buttons.length; loopCounter++)
    image(button, buttons[loopCounter][0], buttons[loopCounter][1]);
     
  for (int loopCounter=0; loopCounter < numbuttons.length; loopCounter++){
    image(button2, numbuttons[loopCounter][0], numbuttons[loopCounter][1]);
    if(loopCounter == 9){
      textSize(18);
      text("Reset", numbuttons[loopCounter][0]+25, numbuttons[loopCounter][1]+35);
    }
    else if(loopCounter == 10){
      textSize(27);
      text(str(0), numbuttons[loopCounter][0]+25, numbuttons[loopCounter][1]+35);
    }
    else if(loopCounter == 11){
      textSize(18);
      text("Start", numbuttons[loopCounter][0]+25, numbuttons[loopCounter][1]+35);
    }
    else{
      textSize(27);
      text(str(loopCounter+1), numbuttons[loopCounter][0]+25, numbuttons[loopCounter][1]+35);
    }  
  }
    
  // draw the active button in a different color
  if (selectedOne >= 0)
    image(buttonSel, buttons[selectedOne][0], buttons[selectedOne][1]);
    
  if (selectedNum >= 0){
    image(button2Sel, numbuttons[selectedNum][0], numbuttons[selectedNum][1]);
    if(selectedNum == 9){
      textSize(18);
      text("Reset", numbuttons[selectedNum][0]+25, numbuttons[selectedNum][1]+35);
    }
    else if(selectedNum == 10){
      textSize(27);
      text(str(0), numbuttons[selectedNum][0]+25, numbuttons[selectedNum][1]+35);
    }
    else if(selectedNum == 11){
      textSize(18);
      text("Start", numbuttons[selectedNum][0]+25, numbuttons[selectedNum][1]+35);
    }
    else{
      textSize(27);
      text(str(selectedNum+1), numbuttons[selectedNum][0]+25, numbuttons[selectedNum][1]+35);
    }
  }
  
  // print out the number of seconds the app has been running
  
  textFont(f);
  textSize(36);
  fill(0,0,0);
  textAlign(CENTER);
  
  secString = str((floor((currentTime/1000)%60)));
  minString = str((floor((currentTime/1000)/60)));
  if(secString.length() == 1){
    secString = "0"+secString;
  }
  if(minString.length() == 1){
    minString = "0"+minString;
  }
  timeString = minString + ":" + secString;
  text(timeString, 175, 250);
  
  faren = 100;
  celc = (int)((float)(faren - 32) / 1.8);
  tempString = faren + "F" + "/" + celc + "C";
  
  textSize(14);
  text(tempString, 308, 215);
  
  fill(255,255,255);
  textSize(27);
  text("Toast", 1150, 223);
  text("Pizza", 1150, 343);
  text("Bagel", 1150, 463);
  text("Taquito", 1150, 583);

  if(currentTime <= 0){
    started = false; 
  }
  
  if(currentTime >= 0 && started){
    currentTime = currentTime - 15;
  }
}

/////////////////////////////////////////////////////

// if the mouse button is released inside a known button keep track of which button was pressed
// and play a confirmation sound

void mouseReleased() {
  
  for (int loopCounter=0; loopCounter < buttons.length; loopCounter++){
      if ((mouseX > buttons[loopCounter][0]) && (mouseX < buttons[loopCounter][0]+buttonX)
      && (mouseY > buttons[loopCounter][1]) && (mouseY < buttons[loopCounter][1]+buttonY)){
        prevSelected = selectedOne;
        selectedOne = loopCounter;
        playBeep();
        if (selectedOne == 0 && selectedOne != prevSelected){
          started = false;
        }
  
        if (selectedOne == 1 && selectedOne != prevSelected){
          currentTime = 150000;
          started = false;
        }
  
        if (selectedOne == 2 && selectedOne != prevSelected){
          currentTime = 120000;
          started = false;
        }
  
        if (selectedOne == 3 && selectedOne != prevSelected){
          currentTime = 120000;
          started = false;
        }
      }  
  }
  for (int loopCounter=0; loopCounter < numbuttons.length; loopCounter++){
      if ((mouseX > numbuttons[loopCounter][0]) && (mouseX < numbuttons[loopCounter][0]+buttonX)
      && (mouseY > numbuttons[loopCounter][1]) && (mouseY < numbuttons[loopCounter][1]+buttonY)){
        selectedNum = loopCounter;
        playBeep();
        if (selectedNum >= 0){
          if(selectedNum == 9){
            currentTime = 0;
            started = false;
          }
          else if(selectedNum == 10){
            
          }
          else if(selectedNum == 11){
            started = true;
          }
          else{

          }
        }
      }
  }
}