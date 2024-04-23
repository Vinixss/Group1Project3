import controlP5.*;
ControlP5 cp5;


//UI Components
Slider sliderRows, sliderCols;
Button generateBtn, bfsBtn, dfsBtn, turnBtn, splitBtn, endBtn;
Camera orbitCamera = new Camera();
Terrain terrain = new Terrain();
BFS bfs;
DFS dfs;

void setup()
{
  size(1200, 1200, P3D);
  pixelDensity(2);
  cp5 = new ControlP5(this);
  windowResizable(true);
  windowMove(600, 0);

  loadSliders();
  terrain.reloadTerrain();
  bfs = new BFS(terrain.cellsData, terrain.rows, terrain.cols, terrain.startCoord[0], terrain.startCoord[1]);
  dfs = new DFS(terrain.cellsData, terrain.rows, terrain.cols, terrain.startCoord[0], terrain.startCoord[1]);
}

void draw()
{
  background(200, 200, 200);
  orbitCamera.Update();
  terrain.drawGrid();

  camera();
  perspective();
  if (generateBtn.isPressed()) {
    terrain.reloadTerrain();

    bfs = new BFS(terrain.cellsData, terrain.rows, terrain.cols, terrain.startCoord[0], terrain.startCoord[1]);
    dfs = new DFS(terrain.cellsData, terrain.rows, terrain.cols, terrain.startCoord[0], terrain.startCoord[1]);
  }
  
  if (bfsBtn.isPressed()) {
    terrain.reloadGrid();
    bfs = new BFS(terrain.cellsData, terrain.rows, terrain.cols, terrain.startCoord[0], terrain.startCoord[1]);
    terrain.bfsOverlay = true;
    terrain.dfsOverlay = false;
  }
  if (dfsBtn.isPressed()) {
    terrain.reloadGrid();
    dfs = new DFS(terrain.cellsData, terrain.rows, terrain.cols, terrain.startCoord[0], terrain.startCoord[1]);
    terrain.bfsOverlay = false;
    terrain.dfsOverlay = true;
  }
  if (terrain.bfsOverlay == true) {
    if (bfs.found == true || bfs.queue.size() == 0) {
      bfs.printStatistics();
      terrain.bfsOverlay = false;
    }
    bfs.traverseLevel();
  }
  if (terrain.dfsOverlay == true) {
    if (dfs.found == true || dfs.stack.size() == 0) {
      dfs.printStatistics();
      terrain.dfsOverlay = false;
    }

    dfs.traverse();
  }
  
  //Display BFS, DFS Results
  pushMatrix();
  noStroke();
  //white rect
  fill(222,222,222);
  rect(600, 20, 480, 150, 30, 30, 30, 30);
  bfs.results();
  dfs.results();
  popMatrix();
}


void keyReleased() {
  if (key == 'a') {
    dfs.traverse();
  }
  if (key == 't') {
    terrain.reloadGrid();
    terrain.turnView = !(terrain.turnView);
  }
  if (key == 'e') {
    terrain.reloadGrid();
    terrain.endView = !(terrain.endView);
  }
  if (key == 'd') {
    terrain.reloadGrid();
    terrain.splitView = !(terrain.splitView);
  }
}

void mouseDragged() {
  orbitCamera.mouseDragged();
}

void mouseWheel(MouseEvent event) {
  orbitCamera.mouseWheel(event);
}

void mouseReleased() {
  if(mouseX >= 20 && mouseX <= 100 && mouseY >= 190 && mouseY < 220) {
    terrain.reloadGrid();
    terrain.turnView = !(terrain.turnView);
  }
  if(mouseX >= 20 && mouseX <= 100 && mouseY >= 220 && mouseY < 250) {
    terrain.reloadGrid();
    terrain.splitView = !(terrain.splitView);
  }
  if(mouseX >= 20 && mouseX <= 100 && mouseY >= 250 && mouseY <= 280) {
    terrain.reloadGrid();
    terrain.endView = !(terrain.endView);
  }
}
