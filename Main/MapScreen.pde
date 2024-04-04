class Maps extends Screens {
  private Planet earth;
  boolean state = false;
  float scaleFactor = 1.0;
  Maps(color backgroundColor, String screenText) {
    super(backgroundColor, screenText);
    earth = new Planet(170);
  }
  void draw() {
    super.draw();
    if(state){
    pushMatrix();
    fill(255);
    //directional
    translate(500,400,100);
    scale(scaleFactor);
    if(mousePressed){
      rotateY(mouseX/50);
    }
    earth.draw();
    
    popMatrix();
    }else{map.draw();}
    
    if (mouseX > 100+ 3*800/4 && mouseX < 100+ 3*800/4 + 800/4 &&
      mouseY > 160 && mouseY < 160 + 30) {
      fill(color(100, 200, 255)+100);
    } else {
      fill(100, 200, 255);
    }

    rect(100+ 3*800/4, 160, 800/4, 30);
    fill(255);
    text("Submit", 173+ 3*800/4, 173);
  }
  void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  scaleFactor -= e * 0.05; // Adjust zoom speed here
  scaleFactor = constrain(scaleFactor, 0.1, 1.1); // Limit zoom range
}

}
