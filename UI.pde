void loadSliders() {
  int leftColumn = 20;
  
  //Initialize your buttons on Main
  //Sliders: use sliderName.getValue() to retrieve value (float);
  //Buttons: check main draw function, to show how to run functions when clicked.
  
  
  sliderRows = cp5.addSlider("sliderRows")
    //x,y pos
    .setPosition(leftColumn, 25)
    .setRange(10, 370)
    .setSize(150, 15)
    .setCaptionLabel("ROWS")
    .setDecimalPrecision(0)
    //default value at start
    .setValue(20)
    ;

  //Slider for controlling col count 1-100
  sliderCols = cp5.addSlider("sliderCols")
    .setPosition(leftColumn, 50)
    .setRange(10, 370)
    .setSize(150, 15)
    .setCaptionLabel("COLUMNS")
    .setDecimalPrecision(0)
    .setValue(20)
    ;

/*
  //Slider for controlling col count 1-100
  sliderCoverage = cp5.addSlider("sliderCoverage")
    .setPosition(leftColumn, 75)
    .setRange(0, 1)
    .setSize(150, 15)
    .setCaptionLabel("Wall Coverage")
    .setDecimalPrecision(2)
    .setValue(.20)
    ;
*/

  //Button to generate terrain
  generateBtn = cp5.addButton("GENERATE")
    .setValue(0)
    .setPosition(leftColumn, 100)
    .setSize(80, 30)
    ;

  //Button to generate terrain
  bfsBtn = cp5.addButton("BFS")
    .setValue(0)
    .setPosition(leftColumn, 130)
    .setSize(80, 30)
    ;

  dfsBtn = cp5.addButton("DFS")
    .setValue(0)
    .setPosition(leftColumn, 160)
    .setSize(80, 30)
    ;
    
  turnBtn = cp5.addButton("CORNER TURNS")
    .setValue(0)
    .setPosition(leftColumn, 190)
    .setSize(80, 30)
    ;
    
  splitBtn = cp5.addButton("DECISION SPLITS")
    .setValue(0)
    .setPosition(leftColumn, 220)
    .setSize(80, 30)
    ;
    
  endBtn = cp5.addButton("DEAD ENDS")
    .setValue(0)
    .setPosition(leftColumn, 250)
    .setSize(80, 30)
    ;
}
