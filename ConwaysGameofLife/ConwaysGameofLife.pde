// Conway's Game of Life - Implemented by Jacob Vanzella
// The goal of this project is to learn to use Processing 3 better and have fun.
// Inspired by my good friend Ashish Maskeri <3

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


void setup() {
  size(641, 841);
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

void draw() {
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
void mouseReleased() {
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
