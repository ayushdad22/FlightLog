//import libraries
import java.util.ArrayList;
import java.util.ArrayList;
import java.util.concurrent.*;
import processing.data.Table;
import processing.data.TableRow;
import controlP5.*;

// constants
final int SCROLLBAR_COLOR = #0799fa;
final int SCREEN_X = 1024;
final int SCREEN_Y = 780;
final int EVENT_BUTTON1= 1;
final int EVENT_BUTTON2= 2;
final int EVENT_BUTTON3= 3;
final int EVENT_BUTTON4 = 4;
final int EVENT_BUTTON5 = 5;
final int EVENT_BUTTON_NEXT = 6;
final int EVENT_BUTTON_BACK = 7;
final int EVENT_NULL=0;

Screens screen;
Graphs GraphScreen;
Maps MapsScreen;
Home HomeScreen;
Logs LogScreen;
ArrayList<Widget> widgetList;
color defaultBorderColor = color(0);
color rectColor;
PFont stdFont;
Screens screen5, currentScreen;
ControlP5 cp5, cp, searchbar;
boolean dataLoaded = false;
String selectedTab;
String selectedData = "";
CompletableFuture<DataPoint> dataLoadFuture = new CompletableFuture<>();

DataPoint data;
PApplet mainApplet;
Chart barchart;
Chart scatterplot;
Chart linegraph;
boolean chartLoaded = false;
String selectingData = "";
String search;
Textarea textArea;

ArrayList<String> airportOrign = new ArrayList<String>();
ArrayList<Integer> airportCancelled = new ArrayList<Integer>();


void setup() {
  size(1024, 780);
  mainApplet = this;
  stdFont = loadFont("ArialMT-18.vlw");
  searchbar = new ControlP5(this);
  LogScreen = new Logs(color(226, 135, 67), "");
  GraphScreen = new Graphs(color(226, 135, 67), "");
  MapsScreen = new Maps(color(21, 76, 121), "");
  HomeScreen = new Home(color(21, 76, 121), "");
  currentScreen = HomeScreen;
  widgetList = new ArrayList<Widget>();
  println("System Loading...");
  GraphScreen.graphSetup();
}

void draw() {
  for (int i = 0; i < widgetList.size(); i++) {
    Widget aWidget = widgetList.get(i);
    aWidget.draw();
  }
  currentScreen.draw();
  if (currentScreen instanceof Logs) { // Only show the search bar on the Logs screen
    textArea();
    searchBar();
  } else {
    LogScreen.removeSearchBar();
    LogScreen.removeTextArea();
  }
  if (chartLoaded) {
    barchart.draw(300, 315, 400, 200);
    linegraph.draw(300, 85, 400, 200);
    scatterplot.draw(300, 550, 400, 200);
  }
}

void keyPressed() {
  if (key == CODED && keyCode == UP && dataLoaded && !dataLoadFuture.isCompletedExceptionally()) {
    dataLoadFuture.thenAcceptAsync(dataPoint -> {
      //println(dataPoint.airportOrigin());
      addPrintButton();
      cp5 = new ControlP5(this);
      cp5.addScrollableList("HOME")
        .setPosition(660, 60)
        .setBackgroundColor(SCROLLBAR_COLOR)
        .setSize(300, 300)
        .setBarHeight(50)
        .setItemHeight(50)
        .close()
        .addItems(dataPoint.airportOrigin());

      cp5 = new ControlP5(this);
      cp5.addScrollableList("HOME")
        .setPosition(360, 60)
        .setBackgroundColor(SCROLLBAR_COLOR)
        .setSize(300, 300)
        .setBarHeight(50)
        .setItemHeight(50)
        .close()
        .addItems(dataPoint.airportOrigin());

      cp = new ControlP5(this);
      cp.addScrollableList("SELECT_DATA")
        .setPosition(60, 60)
        .setBackgroundColor(SCROLLBAR_COLOR)
        .setSize(300, 300)
        .setBarHeight(50)
        .setItemHeight(50)
        .close()
        .addItems(dataPoint.selectData);
    }
    );
  } else if (chartLoaded) {
    // Remove the buttons and dropdowns from the ControlP5 instance
    cp5.getController("PRINT_BUTTON").remove();
    cp5.getController("HOME").remove();
    cp.getController("SELECT_DATA").remove();
  }
}

void controlEvent(ControlEvent event) {
  if (event.isFrom("SELECT_DATA")) {
    selectedData = cp.get(ScrollableList.class, "SELECT_DATA").getItem((int) event.getValue()).get("name").toString();
  }
  if (event.isFrom("HOME")) {
    selectedTab = cp5.get(ScrollableList.class, "HOME").getItem((int) event.getValue()).get("name").toString();

    switch(selectedData) {
    case "Cancelled":
      dataLoadFuture.thenAcceptAsync(dataPoint -> {
        CompletableFuture<Integer> cancelledFlightsFuture = dataPoint.getCancelledFlightsCount(selectedTab);
        cancelledFlightsFuture.thenAccept(cancelledFlightsCount -> {
          airportOrign.add(selectedTab);
          airportCancelled.add(cancelledFlightsCount);
          barchart = new Chart(mainApplet, airportOrign, airportCancelled, "Bar");
          linegraph = new Chart(mainApplet, airportOrign, airportCancelled, "Line");
          scatterplot = new Chart(mainApplet, airportOrign, airportCancelled, "Scatter");
        }
        );
      }
      );
      break;
    case "Delayed":
      int countDelayed = data.countDelayed(selectedTab);
      airportOrign.add(selectedTab);
      airportCancelled.add(countDelayed);
      barchart = new Chart(mainApplet, airportOrign, airportCancelled, "Bar");
      linegraph = new Chart(mainApplet, airportOrign, airportCancelled, "Line");
      scatterplot = new Chart(mainApplet, airportOrign, airportCancelled, "Scatter");
      break;
      //case "Per Week":
      //  data.countFlightsInOneWeek("01/01/2022  00:00:00" );
      //  break;
    case "All":
      int countAll = data.countFlightsFromOrigin(selectedTab);
      airportOrign.add(selectedTab);
      airportCancelled.add(countAll);
      barchart = new Chart(mainApplet, airportOrign, airportCancelled, "Bar");
      linegraph = new Chart(mainApplet, airportOrign, airportCancelled, "Line");
      scatterplot = new Chart(mainApplet, airportOrign, airportCancelled, "Scatter");
      break;

    case "Diverted":
      int divertedCount = data.countDiverted(selectedTab);
      println(divertedCount);
      airportOrign.add(selectedTab);
      airportCancelled.add(divertedCount);
      barchart = new Chart(mainApplet, airportOrign, airportCancelled, "Bar");
      linegraph = new Chart(mainApplet, airportOrign, airportCancelled, "Line");
      scatterplot = new Chart(mainApplet, airportOrign, airportCancelled, "Scatter");
      break;
    }
  } else if (event.isFrom("PRINT_BUTTON")) {
    chartLoaded = true;
  }

  if (event.isAssignableFrom(Textfield.class)) {
    search = event.getStringValue();
    println(search);
  }
}

void mousePressed() {
  int event = currentScreen.getEvent(); // Get event from the current screen
  switch(event) {
  case EVENT_BUTTON1:
    currentScreen = GraphScreen;
    println("graphs");
    break;
  case EVENT_BUTTON2:
    currentScreen = MapsScreen;
    println("maps");
    break;
  case EVENT_BUTTON3:
    currentScreen = LogScreen;
    println("logs");
    break;
  case EVENT_BUTTON4:
    currentScreen = HomeScreen;
    println("home");
    break;
  case EVENT_BUTTON5:
    currentScreen = screen5;
    println("....");
    break;
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

void addPrintButton() {
  cp5 = new ControlP5(this);
  cp5.addButton("PRINT_BUTTON")
    .setPosition(10, 350)
    .setSize(100, 50)
    .setLabel("SUBMIT");
}

void searchBar() {
  // Check if the search bar already exists
  if (searchbar.getController("SEARCH") == null) {
    searchbar.addTextfield("SEARCH")
      .setPosition(370, 300)
      .setSize(250, 30)
      .setFont(stdFont)
      .setColor(color(255));
  }
}

void textArea() {

  StringBuilder filteredData = new StringBuilder();

  // origin airport
  for (String[] flightInfo : data.arrayData) {
    if (flightInfo[2].equalsIgnoreCase(search)) {
      for (String flightDetail : flightInfo) {
        filteredData.append(flightDetail).append(" ");
      }
      filteredData.append("\n");
    }
  }

  // dest airport
  //for (String[] flightInfo : data.arrayData) {
  //  if (flightInfo[4].equalsIgnoreCase(search)) {
  //
  //    for (String flightDetail : flightInfo) {
  //      filteredData.append(flightDetail).append(" ");
  //    }
  //    filteredData.append("\n");
  //  }
  //}

  // origin city abbr
  //  for (String[] flightInfo : data.arrayData) {
  //  if (flightInfo[1].equalsIgnoreCase(search)) {
  //
  //    for (String flightDetail : flightInfo) {
  //      filteredData.append(flightDetail).append(" ");
  //    }
  //    filteredData.append("\n");
  //  }
  //}

  ////dest city abbr
  //  for (String[] flightInfo : data.arrayData) {
  //    if (flightInfo[3].equalsIgnoreCase(search)) {
  //
  //      for (String flightDetail : flightInfo) {
  //        filteredData.append(flightDetail).append(" ");
  //      }
  //      filteredData.append("\n");
  //    }
  //  }

  // airline carrier (2 letters)
  //for (String[] flightInfo : data.arrayData) {
  //  if (flightInfo[7].equalsIgnoreCase(search)) {
  //
  //    for (String flightDetail : flightInfo) {
  //      filteredData.append(flightDetail).append(" ");
  //    }
  //    filteredData.append("\n");
  //  }
  //}

  // Set the text area to display the filtered data
  cp5 = new ControlP5(this);
  textArea = cp5.addTextarea("txt")
    .scroll((float)mouseX/(float)mouseY)
    .setPosition(100, 400)
    .setSize(800, 300)
    .setFont(createFont("arial", 17))
    .setLineHeight(30)
    .setColor(0)
    .setColorBackground(color(255))
    .setColorForeground(color(255, 100));
  ;
  textArea.setText(filteredData.toString() + "...");

  noStroke();
  fill(2, 0, 108);
  ellipse(340, 315, 40, 40);
  push();
  stroke(255);
  strokeWeight(3);
  line(338.5, 313, 348, 323);
  ellipse(338.5, 313, 10, 10);

  pop();
}
