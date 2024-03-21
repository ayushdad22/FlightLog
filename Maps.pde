class Maps extends Screens {
  Maps(color backgroundColor, String screenText) {
    super(backgroundColor, screenText);
  }
  @Override
  void draw() {
    super.draw();
    super.getEvent();// Draw widgets from Screens class
    // Add any additional drawing logic for Graphs here
    // For example, drawing a graph visualization
  }

}
