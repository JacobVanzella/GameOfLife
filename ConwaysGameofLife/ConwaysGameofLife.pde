// Conway's Game of Life - Implemented by Jacob Vanzella
// The goal of this project is to learn to use Processing 3 better and have fun.

int size = 640;
int cellSize = 20;
int cellX, cellY;
int numOfCells = size/cellSize;

boolean paused = true;

boolean[][] cellGridCurrent = new boolean[numOfCells][numOfCells];
boolean[][] cellGridPrevious = new boolean[numOfCells][numOfCells];

Button pause = new Button(30, 671, 110, 60, "Pause");
Button reset = new Button(30, 751, 110, 60, "Reset");

void setup() {
  size(641, 841);
  background(51);
  stroke(0);
  frameRate(5);
  pause.pressed = paused;

  cellGridCurrent[3][3] = true;
  cellGridCurrent[3][4] = true;
  cellGridCurrent[4][3] = true;
  cellGridCurrent[4][4] = true;
  cellGridCurrent[6][3] = true;
}

void draw() {
  line(0, 641, 641, 641);

  for (int i = 0; i < numOfCells; i++) {
    for (int j = 0; j < numOfCells; j++) {
      if (cellGridCurrent[i][j]) {
        fill(112, 112, 200);
      } else {
        fill(51);
      }
      square(i*cellSize, j*cellSize, cellSize);
    }
  }

  pause.draw();
  reset.draw();
  if (!paused) updateCells();
}

// This method allaws the user to change the state of a cell by clicking it.
void mouseReleased() {
  cellX = mouseX/cellSize;
  cellY = mouseY/cellSize;

  // Pauses call to update if the pause button is pressed.
  if (mouseX >= pause.xPos && mouseX <= pause.xPos + pause.wwidth && mouseY >= pause.yPos && mouseY <= pause.yPos + pause.hheight) {
    pause.pressed = !pause.pressed;
    paused = pause.pressed;
  }

  // Resets the board if the reset button is pressed.
  if (mouseX >= reset.xPos && mouseX <= reset.xPos + reset.wwidth && mouseY >= reset.yPos && mouseY <= reset.yPos + reset.hheight) {
    for (int i = 0; i < numOfCells; i++) {
      for (int j = 0; j < numOfCells; j++) {
        cellGridCurrent[i][j] = false;
      }
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
void updateCells() {
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
