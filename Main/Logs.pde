class Logs extends Screens {
  PApplet applet;
  DropDownMenu dropdownSearch, dropdownSort;

  Logs(PApplet applet, color backgroundColor, String screenText) {
    super(backgroundColor, screenText);
    this.applet = applet;
    String[] options = {"Origin Airport", "Origin City", "Destination Airport", "Destination City", "Carrier"};
    String [] sort = {"Alphabetical", "Distance"};
    dropdownSearch = new DropDownMenu(applet, 100, 160, 800/4, 30, options);
    dropdownSort = new DropDownMenu(applet, 100+ 800/4, 160, 800/4, 30, sort);
  }

  void removeSearchBar() {
    searchbar.remove("SEARCH");
  }

  void removeTextArea() {
    if (textArea != null) {
      cp5.remove("txt");
      textArea = null;
    }
  }

  void draw() {
    super.draw();
    dropdownSearch.draw();
    dropdownSort.draw();
     pushStyle();
    stroke(255);
    strokeWeight(3);
    line(343.5, 317, 348, 323);
    fill(0);
    ellipse(338.5, 313, 10, 10);

    popStyle();
    textArea();
    searchBar();
  }

  void mousePressed() {
    dropdownSearch.mousePressed();
    dropdownSort.mousePressed();
  }
  void mouseMoved() {
    dropdownSearch.mouseMoved();
    dropdownSort.mouseMoved();
  }

  void mouseWheel(MouseEvent event) {
    dropdownSearch.mouseWheel(event);
    dropdownSort.mouseWheel(event);
  }
}
