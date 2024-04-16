import controlP5.*;

class Camera
{
  PVector cameraPosition;
  PVector lookatTarget;
  ArrayList<PVector> targets;

  int currentTarget = 0;
  float fieldOfView;
  float radius;
  float theta;
  float phi;
  float mouseSensitivity;

  Camera() {
    this.cameraPosition = new PVector(0, 0, 0);
    this.lookatTarget = new PVector(0, 0, 0);
    this.targets = new ArrayList<>();
    this.radius = 20;
    this.theta = 120; //up-down
    this.phi = 90; //left-right
    this.mouseSensitivity = .5;
    this.fieldOfView = 90;
  };


  //Called every frame from within the main draw() function, receives a
  //FOV value to use in the perspective() function, calculates values to pass
  //to the camera() function
  void Update() {
    perspective(radians(this.fieldOfView), (float)width/height, 0.1, 1000.0);

    //lookatTarget = targets.get(currentTarget);
    cameraPosition.x = lookatTarget.x + (radius * cos(radians(phi)) * sin(radians(theta)));
    cameraPosition.y = lookatTarget.y + (radius * cos(radians(theta)));
    cameraPosition.z = lookatTarget.z + (radius * sin(radians(theta)) * sin(radians(phi)));


    camera(cameraPosition.x, cameraPosition.y, cameraPosition.z,
      lookatTarget.x, lookatTarget.y, lookatTarget.z,
      0, 1, 0);
  }



  //  Called during setup(), this adds a location (PVector) to be stored
  //internally, for the camera to look at.
  void addLookAtTarget(PVector newLocation) {
    targets.add(newLocation);
  };

  //Move to the next {look at} target in the stored list. For example, if the
  //camera was looking at the first, look at the second. If it was looking at
  //the last, wrap around to look at the first.
  void cycleTarget() {
    if (this.currentTarget < targets.size() -1) {
      this.currentTarget++;
    } else {
      this.currentTarget = 0;
    }
  };


  //  This moves the camera closer to, or farther from, the orbit target, by
  //changing the radius of the spherical coordinates (see below).
  void zoom(float delta) {
    this.radius = max(10, min(200, radius + delta));
  };



  //Update the camera\'s two angles by how much the mouse has moved
  //horizontally and vertically.
  void updateAngles(float deltaX, float deltaY) {
    this.phi += deltaX;
    this.theta += deltaY;
    //Theta campled
    this.theta = max(1, min(179, theta));
  };

  void updateLookAtTarget(float deltaX, float deltaY) {
    this.lookatTarget.x -= deltaX *.5;
    this.lookatTarget.z -= deltaY *.5;
  }

  void mouseDragged() {
    if ((mouseButton == LEFT || mouseButton == RIGHT) && !cp5.isMouseOver()) {
      float mouseMovementX = (mouseX - pmouseX) * this.mouseSensitivity;
      float mouseMovementY = (mouseY - pmouseY) * this.mouseSensitivity;
      this.updateAngles(mouseMovementX, mouseMovementY);
    }
    //if (mouseButton == LEFT) {
    //  float mouseMovementX = (mouseX - pmouseX) * this.mouseSensitivity;
    //  float mouseMovementY = (mouseY - pmouseY) * this.mouseSensitivity;
    //  this.updateLookAtTarget(mouseMovementX, mouseMovementY);
    //}
  }

  void mouseWheel(MouseEvent event) {
    float e = event.getCount();
    this.zoom(e * (0.5));
  }
}
