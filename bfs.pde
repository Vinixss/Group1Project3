import java.util.ArrayList;
import java.util.LinkedList;
import java.util.Queue;

class BFS {
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
  int maxQueueSize;
  int counter;
  boolean found;
  Queue<Cell> queue = new LinkedList<>();

  BFS(ArrayList<Cell> matrix, int rows, int cols, int startRow, int startCol) {
    this.rows = rows;
    this.cols = cols;
    this.curRow = startRow;
    this.curCol = startCol;
    this.matrix = matrix;
    this.cellIndex = (curRow * cols) + curCol;
    this.visited = new int[rows*cols];
    this.levels = 0;
    this.found = false;
    this.maxQueueSize = 1;
    this.counter = 0;

    this.queue.offer(matrix.get(cellIndex));
    this.visited[cellIndex] = 1;
    matrix.get(cellIndex).visited = true;
  }

  void traverseLevel() {

    if (queue.size() > 0 && found == false) {
      this.maxQueueSize = Math.max(this.maxQueueSize, queue.size());
      this.levels++;
      for (int i = 0; i < queue.size(); i++) {

        Cell c = queue.poll();
        this.counter++;
        cellIndex = matrix.indexOf(c);
        this.curCol = cellIndex % cols;
        this.curRow = (cellIndex - curCol) / cols;

        if (c.target == true) {
          this.found = true;
          break;
        }

        //Add neighbors to queue;
        for (int j = 0; j < 4; j++) {
          int nx = curCol + dx[j];
          int ny = curRow + dy[j];

          int neighIndex = ny * cols + nx ;

          //Add neighbor to queue if inbounds and not visited
          if (nx>=0 && nx < cols && ny >= 0 && ny < rows && visited[neighIndex] != 1) {
            if (matrix.get(neighIndex).value != 2) {
              matrix.get(neighIndex).visited = true;
              visited[neighIndex] = 1;
              queue.offer(matrix.get(neighIndex));
            }
          }
        }
        c.processed = true;
      }
    }
  }

  //Prints info to console
  void printStatistics() {
    if (this.found == true || queue.size() == 0) {
      if (this.found) {
        println("Found target at row: " + curRow + " , col: " + curCol);
      } else {
        println("Target Not found");
      }
      println("Total Processed: " + counter + " Max Queue Size: " + this.maxQueueSize);
    }
  }

  //Results displayed on screen 
  void results()
  {
    fill(255,0,0);
    int x = 610;
    int y = 60;
    //text(string, x-pos, y-pos);
    textSize(30);
    text("BFS: ",x, y);
    y+= 30;
    textSize(20);
    text("Found: " + this.found, x, y);
    y+= 30;
    text("Vertices Processed: " + this.counter, x, y);
    y+=30;
    text("Max Queue Size: " + this.maxQueueSize, x, y);
  }
}
