class Maps extends Screens {
  private Planet earth;
  DropDownMenu dropdown1, dropdown2, dropdown3;
  boolean state = false;
  float scaleFactor = 1.0;
  PApplet applet;
  DataPoint data;
  boolean drawPath = false;
  float angleX = -0.6299998;
  float angleY = 3.3899996;
  float distance = 500;
  Marker markers;
  Maps(PApplet applet, color backgroundColor, String screenText) {
    super(backgroundColor, screenText);
    earth = new Planet(170);
    String[] options = {""};
    String[] select = {"All", "Direct"};
    this.applet = applet;
    dropdown1 = new DropDownMenu(applet, 100, 160, 800/4, 30, select);
    dropdown2 = new DropDownMenu(applet, 100+ 800/4, 160, 800/4, 30, options);
    dropdown3 = new DropDownMenu(applet, 100+ 2*800/4, 160, 800/4, 30, options);
    dataLoadFuture.thenAcceptAsync(dataPoint -> {
      String[] stringArray = dataPoint.airportOrigin().toArray(new String[0]);
      dropdown2.setOptions(stringArray);
      dropdown3.setOptions(stringArray);
    }
    );
  }

  void draw() {
    super.draw();

    if (state) {
      pushMatrix();
      fill(255);
      //directional
      translate(500, 400, 100);
      scale(scaleFactor);
      rotateX(angleX);
      rotateY(angleY);
      if (dropdown2.getSelectedOption() != null && drawPath && dropdown3.getSelectedOption() != null) {
        markers.createPath();
      }

      earth.draw();
      popMatrix();
    } else {
      if (dropdown2.getSelectedOption() != null && drawPath && dropdown3.getSelectedOption() != null) {
        markers.unfoldingMapCreatePath();
      }

      map.draw();
    }

    dropdown1.draw();
    dropdown2.draw();
    dropdown3.draw();
    if (mouseX > 100 + 3 * 800 / 4 && mouseX < 100 + 3 * 800 / 4 + 800 / 4 &&
      mouseY > 160 && mouseY < 160 + 30) {
      fill(color(100, 200, 255) + 100);
    } else {
      fill(100, 200, 255);
    }
    rect(100 + 3 * 800 / 4, 160, 800 / 4, 30);
    if (mouseX > 100 + 3 * 800 / 4 && mouseX < 100 + 3 * 800 / 4 + 800 / 4 &&
      mouseY > 590 && mouseY < 590 + 30) {
      fill(color(100, 200, 255) + 100);
    } else {
      fill(100, 200, 255);
    }
    rect(100 + 3 * 800 / 4, 590, 800 / 4, 30);
    fill(255);
    text("Submit", 173 + 3 * 800 / 4, 173);

    text(state ? "3D" : "2D", 173 + 3 * 800 / 4, 603);
  }
  void mouseDragged() {
    println(angleX, angleY);
    angleX += (pmouseY - mouseY) * 0.01;
    angleY -= (pmouseX - mouseX) * 0.01;
  }

  void mouseWheel(MouseEvent event) {
    float e = event.getCount();
    scaleFactor -= e * 0.05; // Adjust zoom speed here
    scaleFactor = constrain(scaleFactor, 0.1, 1.1); // Limit zoom range
    float delta = event.getCount() * 10;
    distance += delta;
    distance = constrain(distance, 100, 1000);
    dropdown1.mouseWheel(event);
    dropdown2.mouseWheel(event);
    dropdown3.mouseWheel(event);
  }

  void mousePressed() {
    dropdown1.mousePressed();
    dropdown2.mousePressed();
    dropdown3.mousePressed();
    if (mouseX > 100+ 3*800/4 && mouseX < 100+ 3*800/4 + 800/4 &&
      mouseY > 160 && mouseY < 160 + 30 && currentScreen == MapsScreen) {
      if (dropdown2.getSelectedOption() != null &&  dropdown3.getSelectedOption() != null) {
        String[] airportArray = {
          "ATL", "ATW", "AUS", "AZA", "BDL", "BET", "BHM", "BIL", "BIS", "BLI",
          "BLV", "BNA", "BOI", "BOS", "BRW", "BUF", "BUR", "BWI", "BZN", "CDV",
          "CHS", "CID", "CLE", "CLT", "CMH"
        };
        //String[] airportArray = {
        //  dropdown3.getSelectedOption()
        //};
        drawPath = true;
        markers = new Marker(dropdown2.getSelectedOption(), airportArray);
      }
    } else if (mouseX > 100+ 3*800/4 && mouseX < 100+ 3*800/4 + 800/4 &&
      mouseY > 590 && mouseY < 590 + 30) {
      state = !state;
    }
  }
  void mouseMoved() {
    dropdown1.mouseMoved();
    dropdown2.mouseMoved();
    dropdown3.mouseMoved();
  }
}
