import java.util.ArrayList;
import java.util.LinkedList;
import java.util.Stack;

class DFS {
  int[] dx = { -1, 1, 0, 0};
  int[] dy = { 0, 0, -1, 1};
  int cellIndex;
  ArrayList<Cell> matrix;
  int[] visited;
  int curRow;
  int curCol;
  int rows;
  int cols;
  int levels;
  int maxStackSize;
  int counter;
  boolean found;
  Stack<Cell> stack = new Stack();

  DFS(ArrayList<Cell> matrix, int rows, int cols, int startRow, int startCol) {
    this.rows = rows;
    this.cols = cols;
    this.curRow = startRow;
    this.curCol = startCol;
    this.matrix = matrix;
    this.cellIndex = (curRow * cols) + curCol;
    this.visited = new int[rows*cols];
    this.levels = 0;
    this.found = false;
    this.maxStackSize = 1;
    this.counter = 0;

    this.stack.push(matrix.get(cellIndex));
    this.visited[cellIndex] = 1;
    matrix.get(cellIndex).visited = true;
  }

  void traverse() {
    if (stack.size() > 0 && found == false) {
      this.maxStackSize = Math.max(this.maxStackSize, stack.size());
      for (int i = 0; i < 1; i++) {

        Cell c = stack.pop();
        this.counter++;
        cellIndex = matrix.indexOf(c);
        this.curCol = cellIndex % cols;
        this.curRow = (cellIndex - curCol) / cols;

        if (c.target == true) {
          this.found = true;
          println("Found target at row: " + curRow + " , col: " + curCol);
          //break;
          return;
        }

        //Add neighbors to queue;
        for (int j = 0; j < 4; j++) {
          int nx = curCol + dx[j];
          int ny = curRow + dy[j];

          int neighIndex = ny * cols + nx ;

          //Add neighbor to queue if inbounds and not visited
          if (nx>=0 && nx < cols && ny >= 0 && ny < rows && visited[neighIndex] != 1) {
            if (matrix.get(neighIndex).value != 2) {
              visited[neighIndex] = 1;
              stack.push(matrix.get(neighIndex));
            }
          }
        }
        c.processed = true;
      }
    }
  }
  
  //Prints to console
  void printStatistics() {
    if (this.found == true || stack.size() == 0) {
      if (this.found) {
        println("Found target at row: " + curRow + " , col: " + curCol);
      } else {
        println("Target Not found");
      }
      println("Total Processed: " + counter + " Max Queue Size: " + this.maxStackSize);
    }
  }

  //Results displayed on screen (DFS)
  void results()
  {
    fill(0, 0, 255);
    int x = 850;
    int y = 60;
    textSize(30);
    text("DFS: ", x, y);
    y+= 30;
    textSize(20);
    text("Found: " + this.found, x, y);
    y+=30;
    text("Vertices Processed: " + this.counter, x, y);
    y+=30;
    text("Max Stack Size: " + this.maxStackSize, x, y);
  }
}
