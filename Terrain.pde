import java.util.Map;
import java.util.ArrayList;
import java.util.Stack;
import java.util.Random;


class Pair {
  int y;
  int x;
  
  Pair(int key, int value) {
    y = key;
    x = value;
  }
  
  int getY() {
    return y;
  }
  
  int getX() {
    return x;
  }
}

class Terrain {
  ArrayList<PVector> vertexData;
  int[][] matrixData;
  ArrayList<Cell> cellsData;
  JunctionPath junctions;
  float gridSize;
  int rows;
  int cols;
  int startCoord[] = {0, 0};
  int targetCoord[] = {5, 5};
  float coverage;
  boolean bfsOverlay = false;
  boolean dfsOverlay = false;
  boolean turnView = false;
  boolean splitView = false;
  boolean endView = false;

  Terrain() {
    this.gridSize = 80;
    this.rows = 370;
    this.cols = 370;
    this.vertexData = new ArrayList<PVector>();
    this.cellsData = new ArrayList<Cell>();
    this.junctions = new JunctionPath();
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
    
    //Used for removing the space between two nodes
    int[] ex = {-1, 1, 0, 0};
    int[] ey = {0, 0, -1, 1};
    ArrayList<Integer> previousDirections = new ArrayList<Integer>(4);
    
    //Ensures I can keep track of all nodes
    Pair node = new Pair(randomRow, randomCol);
    Pair neighbor;
    Stack<Pair> nodes = new Stack<Pair>();
    nodes.push(node);
    
    //Randomized DFS
    while(!(nodes.empty())) {
      if(previousDirections.size() == 4) {
        previousDirections.clear();
        nodes.pop();
        continue;
      }
      
      int y = nodes.peek().getY();
      int x = nodes.peek().getX();
      
      this.matrixData[y][x] = 0;
      int direction;
      direction = random.nextInt(4);
      
      while(previousDirections.contains(direction)) {
        direction = random.nextInt(4);
      }
      
      
      int nextCol = x + dx[direction];
      int nextRow = y + dy[direction];
      
      if(( nextCol < 0 || nextCol >= cols ) || ( nextRow < 0 || nextRow >= rows ) || this.matrixData[nextRow][nextCol] == 0) {
        previousDirections.add(direction);
        continue;
      }
      else {
        previousDirections.clear();
        this.matrixData[y + ey[direction]][x + ex[direction]] = 0;
        neighbor = new Pair(nextRow, nextCol);
        nodes.push(neighbor);
      }
    }
    previousDirections.clear();
    
    
    //Set Start Randomly
    randomCol = random.nextInt(cols);
    randomRow = random.nextInt(rows);
    matrixData[randomRow][randomCol] = -1;
    startCoord[0] = randomRow;
    startCoord[1] = randomCol;
    
    junctions.setStart(randomRow, randomCol);

    //Set End Randomly
    randomCol = random.nextInt(cols);
    randomRow = random.nextInt(rows);
    targetCoord[0] = randomRow;
    targetCoord[1] = randomCol;
    matrixData[randomRow][randomCol] = 1;
    
    junctions.setEnd(randomRow, randomCol);
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
        else {
          if (row + 1 != rows) {
            if (matrixData[row+1][col] != 2) {
              newCell.setDir(0);
            }
          }
          if (row != 0) {
            if (matrixData[row-1][col] != 2) {
              newCell.setDir(1);
            }
          }
          if (col + 1 != cols) {
            if (matrixData[row][col+1] != 2) {
              newCell.setDir(2);
            }
          }
          if (col != 0) {
            if (matrixData[row][col-1] != 2) {
              newCell.setDir(3);
            }
          }
          if (newCell.dirNum() == 1) {
            newCell.deadEnd = true;
          }
          else if (newCell.dirNum() == 2) {
            if (newCell.directions[0] != newCell.directions[1]) {
              newCell.turn = true;
            }
          }
          else if (newCell.dirNum() == 3) {
            newCell.turn = true;
            newCell.split = true;
          }
          else if (newCell.dirNum() == 4) {
            newCell.turn = true;
            newCell.split = true;
          }
        }
        
/*        else {
          if (row + 1 != rows) {
            if (matrixData[row+1][col] == 0 || matrixData[row+1][col] == 1 || matrixData[row+1][col] == -1) {
              if (col + 1 != cols) {
                if (matrixData[row][col+1] == 0 || matrixData[row][col+1] == 1 || matrixData[row][col+1] == -1) {
                  newCell.turn = true;
                }
              }
              if (col != 0) {
                if (matrixData[row][col-1] == 0 || matrixData[row][col-1] == 1 || matrixData[row][col-1] == -1) {
                  if (newCell.turn) {
                    newCell.split = true;
                  }
                  else {
                    newCell.turn = true;
                  }
                }
              }
            }
            else if (matrixData[row+1][col] == 2) {
              if (col + 1 != cols) {
                if (col != 0) {
                  if (matrixData[row][col-1] == 2 && matrixData[row][col+1] == 2) {
                    newCell.deadEnd = true;
                  }
                  else if (row != 0) {
                    if (matrixData[row-1][col] == 2 && (matrixData[row][col+1] == 2 || matrixData[row][col-1] == 2)) {
                      newCell.deadEnd = true;
                    }
                  }
                }
                else if (col == 0) {
                  if (matrixData[row][col+1] == 2) {
                    newCell.deadEnd = true;
                  }
                  else if (row == 0) {
                    newCell.deadEnd = true;
                  }
                  else if (matrixData[row-1][col] == 2) {
                    newCell.deadEnd = true;
                  }
                }
              }
              else if (matrixData[row][col-1] == 2) {
                newCell.deadEnd = true;
              }
              else if (row == 0) {
                newCell.deadEnd = true;
              }
              else if (matrixData[row-1][col] == 2) {
                newCell.deadEnd = true;
              }
            }
          }
          if (row != 0) {
            if (matrixData[row-1][col] == 0 || matrixData[row-1][col] == 1 || matrixData[row-1][col] == -1) {
              if (col + 1 != cols) {
                if (matrixData[row][col+1] == 0 || matrixData[row][col+1] == 1 || matrixData[row][col+1] == -1) {
                  if (newCell.turn) {
                    newCell.split = true;
                  }
                  else {
                    newCell.turn = true;
                  }
                }
              }
              if (col != 0) {
                if (matrixData[row][col-1] == 0 || matrixData[row][col-1] == 1 || matrixData[row][col-1] == -1) {
                  if (newCell.turn) {
                    newCell.split = true;
                  }
                  else {
                    newCell.turn = true;
                  }
                }
              }
            }
            else if (matrixData[row-1][col] == 2) {
              if (col + 1 != cols) {
                if (col != 0) {
                  if (matrixData[row][col-1] == 2 && matrixData[row][col+1] == 2) {
                    newCell.deadEnd = true;
                  }
                  else if (row + 1 != rows) {
                    if (matrixData[row+1][col] == 2 && (matrixData[row][col+1] == 2 || matrixData[row][col-1] == 2)) {
                      newCell.deadEnd = true;
                    }
                  }
                }
                else if (col == 0) {
                  if (matrixData[row][col+1] == 2) {
                    newCell.deadEnd = true;
                  }
                  else if (row + 1 == rows) {
                    newCell.deadEnd = true;
                  }
                  else if (matrixData[row+1][col] == 2) {
                    newCell.deadEnd = true;
                  }
                }
              }
              else if (matrixData[row][col-1] == 2) {
                newCell.deadEnd = true;
              }
              else if (row + 1 == rows) {
                newCell.deadEnd = true;
              }
              else if (matrixData[row+1][col] == 2) {
                newCell.deadEnd = true;
              }
            }
          }
        } */
        //May have to convert to a set , to be able to access in dfs, bfs
        cellsData.add(newCell);
        if (newCell.turn || newCell.deadEnd) {
          junctions.addCell(newCell, row, col);
        }
      }
    }
    junctions.created = true;
  }

  //Loops through ellsData and draws each cell
  void drawGrid() {
    for (int i = 0; i < cellsData.size(); i++) {

      Cell currentCell = cellsData.get(i);
      currentCell.seeTurn = turnView;
      currentCell.seeSplit = splitView;
      currentCell.seeDeadEnd = endView;
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
    //this.coverage = (float)sliderCoverage.getValue();
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
