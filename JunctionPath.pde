import java.util.ArrayList;
import java.util.Map;
import java.util.HashMap;


class JunctionPath {
  Map<int[], Cell> junctions = new HashMap<int[], Cell>();
  Map<Map<Cell, int[]>, Map<Cell, Integer>> choices = new HashMap<Map<Cell, int[]>, Map<Cell, Integer>>();
  int startRow = 0;
  int startCol = 0;
  int endRow = 0;
  int endCol = 0;
  boolean created = false;
  boolean end_found = false;
  
  void addCell(Cell c, int x, int y) {
    if (!created) {
      int[] temp = {x, y};
      junctions.put(temp, c);
    }
  }
  
  void setStart(int startRow, int startCol) {
    this.startRow = startRow;
    this.startCol = startCol;
  }
  
  void setEnd(int endRow, int endCol) {
    this.endRow = endRow;
    this.endCol = endCol;
  }
  
  void pathWalk(Map<Cell, int[]> node, int row, int col, int curDirection, int stepNum) {
    if (curDirection == 1) {
      for (int i = row + 1; i < terrain.rows; i++) {
        int[] temp = {i, col};
        if (junctions.get(temp) == null) {
          continue;
        }
        else {
          if ((junctions.get(temp)).target) {
            Map<Cell, Integer> addtemp = new HashMap<Cell, Integer>();
            addtemp.put(junctions.get(temp), stepNum + i - row);
            choices.put(node, addtemp);
            break;
          }
          if ((junctions.get(temp)).deadEnd) {
            break;
          }
          else if ((junctions.get(temp)).turn) {
            if ((junctions.get(temp)).split) {
              Map<Cell, Integer> addtemp = new HashMap<Cell, Integer>();
              Map<Cell, int[]> nodetemp = new HashMap<Cell, int[]>();
              addtemp.put(junctions.get(temp), stepNum + i - row);
              choices.put(node, addtemp);
              nodetemp.put(junctions.get(temp), temp);
              for (int j = 0; j < (junctions.get(temp)).directions.length; j++) {
                if ((junctions.get(temp)).directions[j] == 1) {
                  pathWalk(nodetemp, i, col, j + 1, stepNum + i - row);
                }
              }
            }
            else {
              for (int k = 0; k < (junctions.get(temp)).directions.length; k++) {
                if ((junctions.get(temp)).directions[k] == 1) {
                  pathWalk(node, i, col, k + 1, stepNum + i - row);
                }
              }
            }
          }
        }
      }
    }
    else if (curDirection == 2) {
      for (int i = row - 1; i > 0; i--) {
        int[] temp = {i, col};
        if (junctions.get(temp) == null) {
          continue;
        }
        else {
          if ((junctions.get(temp)).target) {
            Map<Cell, Integer> addtemp = new HashMap<Cell, Integer>();
            addtemp.put(junctions.get(temp), stepNum + row - i);
            choices.put(node, addtemp);
            break;
          }
          if ((junctions.get(temp)).deadEnd) {
            break;
          }
          else if ((junctions.get(temp)).turn) {
            if ((junctions.get(temp)).split) {
              Map<Cell, Integer> addtemp = new HashMap<Cell, Integer>();
              Map<Cell, int[]> nodetemp = new HashMap<Cell, int[]>();
              addtemp.put(junctions.get(temp), stepNum + row - i);
              choices.put(node, addtemp);
              nodetemp.put(junctions.get(temp), temp);
              for (int j = 0; j < (junctions.get(temp)).directions.length; j++) {
                if ((junctions.get(temp)).directions[j] == 1) {
                  pathWalk(nodetemp, i, col, j + 1, stepNum + row - i);
                }
              }
            }
            else {
              for (int k = 0; k < (junctions.get(temp)).directions.length; k++) {
                if ((junctions.get(temp)).directions[k] == 1) {
                  pathWalk(node, i, col, k + 1, stepNum + row - i);
                }
              }
            }
          }
        }
      }
    }
    else if (curDirection == 3) {
      for (int i = col + 1; i < terrain.rows; i++) {
        int[] temp = {row, i};
        if (junctions.get(temp) == null) {
          continue;
        }
        else {
          if ((junctions.get(temp)).target) {
            Map<Cell, Integer> addtemp = new HashMap<Cell, Integer>();
            addtemp.put(junctions.get(temp), stepNum + i - col);
            choices.put(node, addtemp);
            break;
          }
          if ((junctions.get(temp)).deadEnd) {
            break;
          }
          else if ((junctions.get(temp)).turn) {
            if ((junctions.get(temp)).split) {
              Map<Cell, Integer> addtemp = new HashMap<Cell, Integer>();
              Map<Cell, int[]> nodetemp = new HashMap<Cell, int[]>();
              addtemp.put(junctions.get(temp), stepNum + i - col);
              choices.put(node, addtemp);
              nodetemp.put(junctions.get(temp), temp);
              for (int j = 0; j < (junctions.get(temp)).directions.length; j++) {
                if ((junctions.get(temp)).directions[j] == 1) {
                  pathWalk(nodetemp, row, i, j + 1, stepNum + i - col);
                }
              }
            }
            else {
              for (int k = 0; k < (junctions.get(temp)).directions.length; k++) {
                if ((junctions.get(temp)).directions[k] == 1) {
                  pathWalk(node, row, i, k + 1, stepNum + i - col);
                }
              }
            }
          }
        }
      }
    }
    else if (curDirection == 4) {
      for (int i = col - 1; i > 0; i--) {
        int[] temp = {row, i};
        if (junctions.get(temp) == null) {
          continue;
        }
        else {
          if ((junctions.get(temp)).target) {
            Map<Cell, Integer> addtemp = new HashMap<Cell, Integer>();
            addtemp.put(junctions.get(temp), stepNum + col - i);
            choices.put(node, addtemp);
            break;
          }
          if ((junctions.get(temp)).deadEnd) {
            break;
          }
          else if ((junctions.get(temp)).turn) {
            if ((junctions.get(temp)).split) {
              Map<Cell, Integer> addtemp = new HashMap<Cell, Integer>();
              Map<Cell, int[]> nodetemp = new HashMap<Cell, int[]>();
              addtemp.put(junctions.get(temp), stepNum + col - i);
              choices.put(node, addtemp);
              nodetemp.put(junctions.get(temp), temp);
              for (int j = 0; j < (junctions.get(temp)).directions.length; j++) {
                if ((junctions.get(temp)).directions[j] == 1) {
                  pathWalk(nodetemp, row, i, j + 1, stepNum + col - i);
                }
              }
            }
            else {
              for (int k = 0; k < (junctions.get(temp)).directions.length; k++) {
                if ((junctions.get(temp)).directions[k] == 1) {
                  pathWalk(node, row, i, k + 1, stepNum + col - i);
                }
              }
            }
          }
        }
      }
    }
  }
  
  void extract() {
    int[] temp_s = {startRow, startCol};
    int[] temp_t = {endRow, endCol};
    Cell start = junctions.get(temp_s);
    Cell target = junctions.get(temp_t);
    Map<Cell, int[]> home = new HashMap<Cell, int[]>();
    home.put(start, temp_s);
    for (int i = 0; i < start.directions.length; i++) {
      if (start.directions[i] == 1) {
        pathWalk(home, startRow, startCol, i + 1, 0);
      }
    }
  }
}
