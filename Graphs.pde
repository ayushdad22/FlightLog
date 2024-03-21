class Graphs extends Screens {
  
  Graphs(color backgroundColor, String screenText) {
    super(backgroundColor, screenText);
    
    // Initialize any Graph-specific widgets or settings here
  }

  @Override
  void draw() {
    super.draw(); 
    super.getEvent();
    // Draw widgets from Screens class
    // Add any additional drawing logic for Graphs here
    // For example, drawing a graph visualization
  }
}
