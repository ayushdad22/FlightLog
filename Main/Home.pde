class Home extends Screens {
  private Planet earth;
  float angle = 0;
  PImage imageLogo;
  PFont text;
  Home(color backgroundColor, String screenText) {
    super(backgroundColor, screenText);
    earth = new Planet(170);
    imageLogo = loadImage("PlaneWatcherLogo.png");
    text = createFont("Aachen Bold.ttf", 20);
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

    // Disable depth testing to draw the image on top of everything
    hint(DISABLE_DEPTH_TEST);
    pushStyle();
    lights();
    image(imageLogo, 190, 270, 300, 300);
    textFont(text);
    fill(18, 188, 252);
    text("Group 15: Ayush, Shuban, Brian, Abdul, Thai, Patrick", 125, 640);
    popStyle();
    // Re-enable depth testing for future 3D drawings
    hint(ENABLE_DEPTH_TEST);
  }
}
