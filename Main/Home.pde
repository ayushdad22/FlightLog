class Home extends Screens {
  private HeightMapEarth earth;
  float angle = 0;
  PImage imageLogo;
  Home(color backgroundColor, String screenText) {
    super(backgroundColor, screenText);
    earth = new HeightMapEarth();
    imageLogo = loadImage("PlaneWatcherLogo-removebg-preview.png");
  }
  void draw() {
    angle += 1;
    super.draw();
    pushStyle();
    pushMatrix();
    translate(540, 400, 100);
    directionalLight(255, 250, 245, -0.9, 0.7, 0);
    rotateY(radians(angle));
    earth.draw();
    popMatrix();
    popStyle();

    hint(DISABLE_DEPTH_TEST);
    pushStyle();
    lights();
    image(imageLogo, 190, 270, 300, 300);
    popStyle();
    hint(ENABLE_DEPTH_TEST);
  }
}
