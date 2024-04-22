class Cell {
  PVector position;
  int[] directions;
  int value;
  boolean visited;
  boolean start;
  boolean target;
  boolean current;
  boolean processed;
  boolean dfs;
  boolean turn;
  boolean split;
  boolean deadEnd;
  boolean seeTurn;
  boolean seeSplit;
  boolean seeDeadEnd;
  
  Cell(float x, float y, float z) {
    this.position = new PVector(x,y,z);
    this.directions = new int[]{0,0,0,0};
    this.value = 0;
    this.visited = false;
    this.processed = false;
    this.start = false;
    this.target = false;
    this.turn = false;
    this.split = false;
    this.deadEnd = false;
    this.seeTurn = false;
    this.seeSplit = false;
    this.seeDeadEnd = false;
    //this.current = false;
    //this.dfs = false;
  }
  
  void setDir(int direction) {
    directions[direction] = 1;
  }
  
  int dirNum() {
    int sum = 0;
    for (int i = 0; i < directions.length; i++) {
      sum += directions[i];
    }
    return sum;
  }
  
  //Set cell colors based on attributes
  void drawCell() {
    float sideLength = 1;
    stroke(1);
    beginShape();
    fill(100,200,100);
    if (this.visited) {
      fill(255,255,0);
    }
    if (this.value == 2) {
      fill(0, 0,0);
    }
    if (this.seeTurn && this.turn && !this.visited) {
      fill(205, 20, 222);
    }
    if (this.seeSplit && this.split && !this.visited) {
      fill(245, 113, 32);
    }
    if (this.seeDeadEnd && this.deadEnd && !this.visited) {
      fill(145, 145, 145);
    }
    if (this.processed) {
      fill(255,140,100);
    }
    if (this.target) {
      fill(255,0,0);
    }
    if (this.start) {
      fill(0,0,255);
    }
    
    vertex(this.position.x, this.position.y, this.position.z);
    vertex(this.position.x + sideLength, this.position.y, this.position.z);
    vertex(this.position.x + sideLength, this.position.y, this.position.z + sideLength);
    vertex(this.position.x, this.position.y, this.position.z + sideLength);
    
    endShape();    
  }
}
