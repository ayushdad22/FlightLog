class Home extends Screens {
  private Planet earth;
  float angle = 0;
  Home(color backgroundColor, String screenText) {
    super(backgroundColor, screenText);
    earth = new Planet(170);

  }
  void draw(){
    angle += 1;
    super.draw();
    pushMatrix();
    translate(500, 400, 100);
    directionalLight(255, 250, 245, -0.7, 0.7, 0);
    rotateY(radians(angle));
    earth.draw();
    popMatrix();
  }
}
