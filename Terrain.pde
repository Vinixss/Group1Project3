import java.util.Map;
import java.util.ArrayList;
import java.util.Random;

class Terrain {
  ArrayList<PVector> vertexData;
  int[][] matrixData;
  ArrayList<Cell> cellsData;
  float gridSize;
  int rows;
  int cols;
  int startCoord[] = {0, 0};
  int targetCoord[] = {5, 5};
  float coverage;
  boolean bfsOverlay = false;
  boolean dfsOverlay = false;

  Terrain() {
    this.gridSize = 80;
    this.rows = 370;
    this.cols = 370;
    this.vertexData = new ArrayList<PVector>();
    this.cellsData = new ArrayList<Cell>();
    this.coverage = 0.2f;
  }

  //This is call when Generate button is clicked. Creating a new 2D grid.
  //Wall: 2 , Start: -1 , target: 1
  //additionally set startCoord attributes for class with the starting point coordinates, same with targetCoord.
  
  //Sets Random Walls, Starting Point, Target Point
  void createMatrix(int rows, int cols) {
    this.matrixData = new int[rows][cols];
    for(int i = 0; i < rows; i++) {
      for(int j = 0; j < cols; j++) {
        this.matrixData[i][j] = 2;
      }
     }
    
    Random random = new Random();
    int randomCol = random.nextInt(cols);
    int randomRow = random.nextInt(rows);
    
    //Used to set up wall cells by only counting nodes 2 away
    int[] dx = { -2, 2, 0, 0};
    int[] dy = { 0, 0, -2, 2};
    
    recursiveMaze(rows, cols, randomRow, randomCol, dx, dy, random);
    
    
    //Set Start Randomly
    randomCol = random.nextInt(cols);
    randomRow = random.nextInt(rows);
    matrixData[randomRow][randomCol] = -1;
    startCoord[0] = randomRow;
    startCoord[1] = randomCol;

    //Set End Randomly
    randomCol = random.nextInt(cols);
    randomRow = random.nextInt(rows);
    targetCoord[0] = randomRow;
    targetCoord[1] = randomCol;
    matrixData[randomRow][randomCol] = 1;


    /*
    //Set walls randomly (loop count = rows*cols*coverage);
    int wallsToInsert = (int)(rows*cols*this.coverage);

    for (int i = 0; i < wallsToInsert; i++) {
      randomCol = random.nextInt(cols);
      randomRow = random.nextInt(rows);

      if (matrixData[randomRow][randomCol] != -1 && matrixData[randomRow][randomCol] != 1) {
        matrixData[randomRow][randomCol] = 2;
      }
    }
    */
  }
  
  void recursiveMaze(int rows, int cols, int currentRow, int currentColumn, int[] dx, int[] dy, Random random) {
    //Sets the new node to open
    this.matrixData[currentRow][currentColumn] = 0;
    
    //Used to keep track of where we've been
    ArrayList<Integer> previousDirections = new ArrayList<Integer>(4);
    int direction;
    int[] ex = {-1, 1, 0, 0};
    int[] ey = {0, 0, -1, 1};
    
    //Checks all 4 neighbors. If it is valid and hasn't been checked, carve the path and go to that nodde
    for(int i = 0; i < 4; i++) {
      direction = random.nextInt(4);
      
      while(previousDirections.contains(direction)) {
        direction = random.nextInt(4);
      }
      
      int nextCol = currentColumn + dx[direction];
      int nextRow = currentRow + dy[direction];
      
      if(( nextCol < 0 || nextCol >= cols ) || ( nextRow < 0 || nextRow >= rows ) || ( this.matrixData[nextRow][nextCol] == 0 )) {
        previousDirections.add(direction);
        continue;
      }
      
      matrixData[currentRow + ey[direction]][currentColumn + ex[direction]] = 0;
      recursiveMaze(rows, cols, nextRow, nextCol, dx, dy, random);
      previousDirections.add(direction);
    }
  }

  //Reads matrixData and creates arraylist of Cell objects
  void generateGridData() {
    for (int row = 0; row < rows; row++) {
      for (int col = 0; col < cols; col++) {
        Cell newCell = new Cell(row - (rows/2), 0, col - (cols/2));
        if (row == startCoord[0] && col == startCoord[1]) {
          newCell.start = true;
        }
        if (row == targetCoord[0] && col == targetCoord[1]) {
          newCell.target = true;
        }
        if (matrixData[row][col] == 2) {
          newCell.value = 2;
        }
        //May have to convert to a set , to be able to access in dfs, bfs
        cellsData.add(newCell);
      }
    }
  }

  //Loops through ellsData and draws each cell
  void drawGrid() {
    for (int i = 0; i < cellsData.size(); i++) {

      Cell currentCell = cellsData.get(i);
      currentCell.drawCell();

      fill(255, 0, 0);
    }
  }

  //Reset Terrain
  void clearTerrain() {
    this.vertexData.clear();
    this.cellsData.clear();
  }

  //Restarts grid, based on sliders
  void reloadTerrain() {
    this.rows = (int)sliderRows.getValue();
    this.cols = (int)sliderCols.getValue();
    this.startCoord[0] = 8;
    this.startCoord[1] = 7;
    this.targetCoord[0] = rows-1;
    this.targetCoord[1] = cols -1;
    this.clearTerrain();
    this.coverage = (float)sliderCoverage.getValue();
    this.createMatrix(rows, cols);
    this.generateGridData();
    this.bfsOverlay = false;
    this.dfsOverlay = false;
  }

  //Reload Grid, without generating a new grid (same starting, ending, walls)
  void reloadGrid() {
    this.clearTerrain();
    this.generateGridData();
  }
}
