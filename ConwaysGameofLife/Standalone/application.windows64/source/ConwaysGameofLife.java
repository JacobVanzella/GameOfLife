import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class ConwaysGameofLife extends PApplet {

// Conway's Game of Life - Implemented by Jacob Vanzella
// The goal of this project is to learn to use Processing 3 better and have fun.

int size = 640;
int cellSize = 20;
int cellX, cellY;
int numOfCells = size/cellSize;
float colour;

boolean paused = true;

boolean[][] cellGridCurrent = new boolean[numOfCells][numOfCells];
boolean[][] cellGridPrevious = new boolean[numOfCells][numOfCells];
boolean[][] cellGridPreset = new boolean[numOfCells][numOfCells];

Button pause = new Button(30, 671, 110, 60, "Start");
Button set = new Button(30, 751, 110, 60, "Set");
Button reset = new Button(160, 751, 110, 60, "Reset");
Button clear = new Button(160, 671, 110, 60, "Clear");


public void setup() {
  
  background(51);
  stroke(0);
  frameRate(5);
  colour = 245;
  pause.pressed = paused;

  // Default board setup.
  for (int i = 0; i < 11; i++) {
    if (i == 5) i++;
    cellGridPreset[10+i][16] = true;
  }
}

public void draw() {
  line(0, 641, 641, 641);  // Bolder line for seperation of board and controls.

  // Draws the cells on the board.
  for (int i = 0; i < numOfCells; i++) {
    for (int j = 0; j < numOfCells; j++) {
      if (cellGridCurrent[i][j]) {
        fill(colour);
      } else {
        fill(51);
      }
      square(i*cellSize, j*cellSize, cellSize);
    }
  }

  pause.draw();
  set.draw();
  reset.draw();
  clear.draw();
  if (!paused) updateCells();  // If not paused calls update to calculate the next board state.
}

// This method allaws the user to change the state of a cell by clicking it.
public void mouseReleased() {
  cellX = mouseX/cellSize;
  cellY = mouseY/cellSize;

  // Pauses call to update if the pause button is pressed.
  if (mouseX >= pause.xPos && mouseX <= pause.xPos + pause.wwidth && mouseY >= pause.yPos && mouseY <= pause.yPos + pause.hheight) {
    pause.pressed = !pause.pressed;
    paused = pause.pressed;
    if (paused) {
      pause.setText("Start");
    } else {
      pause.setText("Pause");
    }
  }

  // Resets the board if the reset button is pressed.
  if (mouseX >= clear.xPos && mouseX <= clear.xPos + clear.wwidth && mouseY >= clear.yPos && mouseY <= clear.yPos + clear.hheight) {
    for (int i = 0; i < numOfCells; i++) {
      for (int j = 0; j < numOfCells; j++) {
        cellGridCurrent[i][j] = false;
      }
    }
  }

  // Sets the current board as the board preset.
  if (mouseX >= set.xPos && mouseX <= set.xPos + set.wwidth && mouseY >= set.yPos && mouseY <= set.yPos + set.hheight) {
    for (int i = 0; i < numOfCells; i++) {
      cellGridPreset[i] = cellGridCurrent[i].clone();
    }
  }

  // Sets the current board as the board preset.
  if (mouseX >= reset.xPos && mouseX <= reset.xPos + reset.wwidth && mouseY >= reset.yPos && mouseY <= reset.yPos + reset.hheight) {
    for (int i = 0; i < numOfCells; i++) {
      cellGridCurrent[i] = cellGridPreset[i].clone();
    }
  }



  try {
    cellGridCurrent[cellX][cellY] = !cellGridCurrent[cellX][cellY];
  } 
  catch (Exception e) {
    return;
  }
}

// This method updates the state of the board for the next generation.
public void updateCells() {
  int neighboursAlive;
  for (int i = 0; i < numOfCells; i++) {
    cellGridPrevious[i] = cellGridCurrent[i].clone();
  }

  for (int i = 0; i < numOfCells; i++) {
    for (int j = 0; j < numOfCells; j++) {
      neighboursAlive = 0;

      for (int col = -1; col < 2; col++) {
        for (int row = -1; row < 2; row++) {
          try {
            if (col == 0 && row == 0) continue;
            if (cellGridPrevious[i+col][j+row]) neighboursAlive++;
          } 
          catch(Exception e) {
            continue;
          }
        }
      }

      if (cellGridPrevious[i][j] && (neighboursAlive == 2 || neighboursAlive == 3)) {
        cellGridCurrent[i][j] = true;
      } else if (neighboursAlive == 3) {
        cellGridCurrent[i][j] = true;
      } else {
        cellGridCurrent[i][j] = false;
      }
    }
  }
}
public class Button {

  public int xPos, yPos;
  public int wwidth, hheight;

  public boolean pressed;

  private String text;

  Button(int xPos, int yPos, int wwidth, int hheight, String text) {
    this.xPos = xPos;
    this.yPos = yPos;
    this.wwidth = wwidth;
    this.hheight = hheight;
    this.text = text;
    pressed = false;
  }

  public void draw() {
    if (pressed) fill(255, 20, 20); 
    else fill(200);
    rect(xPos, yPos, wwidth, hheight, 7);

    fill(25);
    textSize(32);
    textAlign(CENTER, CENTER);
    text(text, xPos+(wwidth/2), yPos+(hheight/2.5f));
  }

  public void setText(String text) {
    this.text = text;
  }
}

  public void settings() {  size(641, 841); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "ConwaysGameofLife" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
