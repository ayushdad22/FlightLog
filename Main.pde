final int SCREENX = 1024;
final int SCREENY = 780;
final int EVENT_BUTTON1= 1;
final int EVENT_BUTTON2= 2;
final int EVENT_BUTTON3= 3;
final int EVENT_BUTTON4 = 4;
final int EVENT_BUTTON5 = 5;
final int EVENT_NULL=0;
Screens screen;
Graphs GraphScreen;
Maps MapsScreen;
ArrayList<Widget> widgetList;
color defaultBorderColor = color(0); // Assigning default border color
color rectColor;
PFont stdFont;
Screens screen1, screen2, screen3, screen4, screen5, currentScreen;
import java.util.ArrayList;
import java.util.concurrent.*;
boolean dataLoaded = false;
CompletableFuture<Table> tableFuture = new CompletableFuture<>();

void setup() {
  size(1024, 780);
  tableFuture = CompletableFuture.supplyAsync(
    () -> loadTable("flights_full.csv", "header")
  );
  GraphScreen = new Graphs(color(255,0,0), "");
  MapsScreen = new Maps(color(0,255,0), "");
  currentScreen = GraphScreen;
  widgetList = new ArrayList<Widget>();
  // Create instances of Widget

}

void draw() {  
  background(255); // Clearing background
  for (int i = 0; i<widgetList.size(); i++) {
    Widget aWidget = widgetList.get(i);
    aWidget.draw();
  }
  currentScreen.draw(); // Drawing current screen
}

ArrayList<String> arrayStateAbv = new ArrayList<>();
ArrayList<String> arrayState = new ArrayList<>();
ArrayList<String[]> arrayDistances = new ArrayList<>();

void keyPressed(){
  if (key == CODED && keyCode == UP && tableFuture.isDone() && !tableFuture.isCompletedExceptionally()) {
    Table table = tableFuture.join();
    for (TableRow tableRow : table.rows()) {
      String origin = tableRow.getString("ORIGIN_CITY_NAME");
      String originAirport = tableRow.getString("ORIGIN");
      String dest = tableRow.getString("DEST_CITY_NAME");
      String destAirport = tableRow.getString("DEST");
      if (!arrayState.contains(origin)) {
        String[] distanceData = {origin, originAirport, dest, destAirport};
        arrayDistances.add(distanceData);
      }
    }
    dataLoaded = true;
  }
}

void mousePressed() {
  for (int i = 0; i<widgetList.size(); i++) {
    Widget aWidget = widgetList.get(i);
    if (aWidget.isMouseOver(mouseX, mouseY)) {
      int event = aWidget.getEvent(mouseX, mouseY);
      switch(event) {
        case EVENT_BUTTON1:
          currentScreen = GraphScreen;
          println("no");
          break;
        case EVENT_BUTTON2:
          currentScreen = MapsScreen;
          println("yes");
          break;
        case EVENT_BUTTON3:
          currentScreen = screen3;
          break;
        case EVENT_BUTTON4:
          currentScreen = screen4;
          break;
        case EVENT_BUTTON5:
          currentScreen = screen5;
          break;
      }
    }
  }
}

void mouseMoved() {
  for (int i = 0; i < widgetList.size(); i++) {
    Widget aWidget = widgetList.get(i);
    if (aWidget.isMouseOver(mouseX, mouseY)) {
      aWidget.setBorderColor(color(255));
    } else {
      aWidget.setBorderColor(defaultBorderColor);
    }
  }
}
