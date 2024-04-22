import java.util.ArrayList;
import java.util.Map;
import java.util.HashMap;


class JunctionPath {
  Map<int[], Cell> junctions = new HashMap<int[], Cell>();
  Map<int[], Cell> choices = new HashMap<int[], Cell>();
  int startRow = 0;
  int startCol = 0;
  int endRow = 0;
  int endCol = 0;
  boolean created = false;
  
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
  
  void extract() {
    
  }
}
