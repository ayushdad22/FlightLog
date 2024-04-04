class Logs extends Screens {
  PApplet applet;
  DropDownMenu dropdownSearch;

  Logs(PApplet applet, color backgroundColor, String screenText) {
    super(backgroundColor, screenText);
    this.applet = applet;
    String[] options = {"Origin Airport", "Origin City", "Destination Airport", "Destination City", "Carrier"};
    dropdownSearch = new DropDownMenu(applet, 100, 160, 800/4, 30, options);
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
  }

  void mousePressed() {
    dropdownSearch.mousePressed();
  }
  void mouseMoved() {
    dropdownSearch.mouseMoved();
  }

  void mouseWheel(MouseEvent event) {
    dropdownSearch.mouseWheel(event);
  }
}
