class Cell {
  PVector position;
  int value;
  boolean visited;
  boolean start;
  boolean target;
  boolean current;
  boolean processed;
  boolean dfs;
  
  Cell(float x, float y, float z) {
    this.position = new PVector(x,y,z);
    this.value = 0;
    this.visited = false;
    this.processed = false;
    this.start = false;
    this.target = false;
    //this.current = false;
    //this.dfs = false;
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
