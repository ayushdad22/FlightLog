import controlP5.*;

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
final int EVENT_RIGHT_ARROW = 8;
final int EVENT_LEFT_ARROW = 9;
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
int arrowClicked = 0;
ArrowWidget rightArrow = new ArrowWidget(150, 185, 65, 30, "Right Arrow", color(255, 0, 0), stdFont, EVENT_RIGHT_ARROW, "right");
ArrowWidget leftArrow = new ArrowWidget(150, 215, 65, 30, "Left Arrow", color(0, 255, 0), stdFont, EVENT_LEFT_ARROW, "left");



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
  stdFont = createFont("arial", 20);
  searchbar = new ControlP5(this);
  LogScreen = new Logs(mainApplet,color(225), "");
  GraphScreen = new Graphs(mainApplet, color(225), "");
  MapsScreen = new Maps(color(225), "");
  HomeScreen = new Home(color(255), "");
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
  if (currentScreen == LogScreen) {
    push();
    stroke(255);
    strokeWeight(3);
    line(343.5, 317, 348, 323);
    fill(0);
    ellipse(338.5, 313, 10, 10);

    pop();
    textArea();
    searchBar();
  } else {
    LogScreen.removeSearchBar();
    LogScreen.removeTextArea();
  }
  if (chartLoaded && arrowClicked == 0 && currentScreen == GraphScreen) 
  {
    linegraph.draw(280, 315, 450, 250);
  }
  if (chartLoaded && arrowClicked == 1 && currentScreen == GraphScreen) 
  {
    barchart.draw(280, 315, 450, 220);

  }
  if (chartLoaded && arrowClicked == 2 && currentScreen == GraphScreen) 
  {
    
    scatterplot.draw(280, 315, 450, 220);
  }
}


void controlEvent(ControlEvent event) {
  if (event.isAssignableFrom(Textfield.class)) {
    search = event.getStringValue();
  }
}

void mousePressed() {
  GraphScreen.mousePressed();
  LogScreen.mousePressed();
  int event = currentScreen.getEvent(); // Get event from the current screen
  switch(event) {
  case EVENT_BUTTON1:
    currentScreen = GraphScreen;

    break;
  case EVENT_BUTTON2:
    currentScreen = MapsScreen;

    break;
  case EVENT_BUTTON3:
    currentScreen = LogScreen;

    break;
  case EVENT_BUTTON4:
    currentScreen = HomeScreen;

    break;
  case EVENT_BUTTON5:
    currentScreen = screen5;

    break;
  }

  if (mouseX > 100+ 3*800/4 && mouseX < 100+ 3*800/4 + 800/4 &&
    mouseY > 160 && mouseY < 160 + 30 ) 
  {
    clickedDropDown();
  }
    int startX = rightArrow.getShaftStartX();
    int endX = rightArrow.getHeadBaseEndX();
    int startY = rightArrow.getShaftY() - 5; // Assuming a small margin around the shaft for click detection
    int endY = rightArrow.getShaftY() + 5;
    
    int leftStartX = leftArrow.getHeadBaseEndX(); // The leftmost point of the arrowhead
    int leftEndX = leftArrow.getShaftStartX();    // The rightmost point of the arrow shaft
    int leftStartY = leftArrow.getShaftY() - 5;   // Assuming a small margin around the shaft for click detection
    int leftEndY = leftArrow.getShaftY() + 5;
    // Click detection logic
    if (mouseX >= startX && mouseX <= endX && mouseY >= startY && mouseY <= endY) 
    {
          if (arrowClicked < 2) 
          {
            arrowClicked++; 
        }else{
          arrowClicked = 0;
        }
    }
    
    if (mouseX >= leftStartX && mouseX <= leftEndX && mouseY >= leftStartY && mouseY <= leftEndY) 
    {
    if (arrowClicked > 0) {
        arrowClicked--; // Decrease the arrowClicked counter if the left arrow is clicked
    }else{
          arrowClicked = 2;
        }
    }
  
  
}
void clickedDropDown() {
  switch(GraphScreen.dropdown1.getSelectedOption()) {
  case "Cancelled":
    dataLoadFuture.thenAcceptAsync(dataPoint -> {
      CompletableFuture<Integer> cancelledFlightsFuture = dataPoint.getCancelledFlightsCount(GraphScreen.dropdown2.getSelectedOption());
      CompletableFuture<Integer> cancelledFlightsFuture1 = dataPoint.getCancelledFlightsCount(GraphScreen.dropdown3.getSelectedOption());

      CompletableFuture.allOf(cancelledFlightsFuture, cancelledFlightsFuture1).thenRun(() -> {
        if (GraphScreen.dropdown2.getSelectedOption() != "Select an option" && !airportOrign.contains(GraphScreen.dropdown2.getSelectedOption())) { //<>//
          airportOrign.add(GraphScreen.dropdown2.getSelectedOption());
          airportCancelled.add(cancelledFlightsFuture.join());
        }
        if (GraphScreen.dropdown3.getSelectedOption() != "Select an option" && !airportOrign.contains(GraphScreen.dropdown3.getSelectedOption())) {
          airportOrign.add(GraphScreen.dropdown3.getSelectedOption());
          airportCancelled.add(cancelledFlightsFuture1.join());
        }
        createCharts();
        chartLoaded = true;
      }
      );
    }
    );
    break;
  case "Delayed":
    int countDelayed = data.countDelayed(GraphScreen.dropdown2.getSelectedOption());
    int countDelayed1 = data.countDelayed(GraphScreen.dropdown3.getSelectedOption());

    if (!GraphScreen.dropdown2.getSelectedOption().equals("Select an option") && !airportOrign.contains(GraphScreen.dropdown2.getSelectedOption())) {
      airportOrign.add(GraphScreen.dropdown2.getSelectedOption());
      airportCancelled.add(countDelayed);
    }

    if (!GraphScreen.dropdown3.getSelectedOption().equals("Select an option") && !airportOrign.contains(GraphScreen.dropdown3.getSelectedOption())) {
      airportOrign.add(GraphScreen.dropdown3.getSelectedOption());
      airportCancelled.add(countDelayed1);
    }

    createCharts();
    chartLoaded = true;

    break;

  case "All":
    int countAll = data.countFlightsFromOrigin(GraphScreen.dropdown2.getSelectedOption());
    int countAll1 = data.countFlightsFromOrigin(GraphScreen.dropdown3.getSelectedOption());


    if (!GraphScreen.dropdown2.getSelectedOption().equals("Select an option") && !airportOrign.contains(GraphScreen.dropdown2.getSelectedOption()) ) {
      airportOrign.add(GraphScreen.dropdown2.getSelectedOption());
      airportCancelled.add(countAll);
    }

    if (!GraphScreen.dropdown3.getSelectedOption().equals("Select an option") && !airportOrign.contains(GraphScreen.dropdown3.getSelectedOption())) {
      airportOrign.add(GraphScreen.dropdown3.getSelectedOption());
      airportCancelled.add(countAll1);
    }

    createCharts();
    chartLoaded = true;

    break;

  case "Diverted":
    int divertedCount = data.countDiverted(GraphScreen.dropdown2.getSelectedOption());
    int divertedCount1 = data.countDiverted(GraphScreen.dropdown3.getSelectedOption());


    if (!GraphScreen.dropdown2.getSelectedOption().equals("Select an option") && !airportOrign.contains(GraphScreen.dropdown2.getSelectedOption())) {
      airportOrign.add(GraphScreen.dropdown2.getSelectedOption());
      airportCancelled.add(divertedCount);
    }

    if (!GraphScreen.dropdown3.getSelectedOption().equals("Select an option") && !airportOrign.contains(GraphScreen.dropdown3.getSelectedOption())) {
      airportOrign.add(GraphScreen.dropdown3.getSelectedOption());
      airportCancelled.add(divertedCount1);
    }

    createCharts();
    chartLoaded = true;

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
  GraphScreen.mouseMoved();
  LogScreen.mouseMoved();
}

void mouseWheel(MouseEvent event) {
  if (currentScreen == LogScreen) {
    if (textArea.isMouseOver()) {
      int delta = event.getCount();
      textArea.scroll(-delta * 10); // Adjust scrolling speed as needed
    }
  } else {
    GraphScreen.mouseWheel(event);
  }
}

void searchBar() {
  // Check if the search bar already exists
  if (searchbar.getController("SEARCH") == null) {
    searchbar.addTextfield("SEARCH")
      .setPosition(370, 300)
      .setSize(250, 30)
      .setFont(stdFont)
      .setColor(color(255))
      .setLabel("")
      .setColorBackground(color(30))
      .setColorForeground(color(30));
  }
}
void createCharts() {
  barchart = new Chart(mainApplet, airportOrign, airportCancelled, "Bar");
  linegraph = new Chart(mainApplet, airportOrign, airportCancelled, "Line");
  scatterplot = new Chart(mainApplet, airportOrign, airportCancelled, "Scatter");
  chartLoaded = true;
}

void textArea() {
  StringBuilder filteredData = new StringBuilder();
  String selectedOption = LogScreen.dropdownSearch.getSelectedOption();

  if (dataLoadFuture.isDone() && selectedOption != null) {
    switch(selectedOption) {

    case "Origin Airport":
      for (String[] flightInfo : data.arrayData) {
        if (flightInfo[2].equalsIgnoreCase(search)) {
          for (String flightDetail : flightInfo) {
            filteredData.append(flightDetail).append(" ");
          }
          filteredData.append("\n");
        }
      }
      break;

    case "Destination Airport":
      for (String[] flightInfo : data.arrayData) {
        if (flightInfo[4].equalsIgnoreCase(search)) {

          for (String flightDetail : flightInfo) {
            filteredData.append(flightDetail).append(" ");
          }
          filteredData.append("\n");
        }
      }
      break;

    case "Origin City":
      for (String[] flightInfo : data.arrayData) {
        if (flightInfo[1].equalsIgnoreCase(search)) {

          for (String flightDetail : flightInfo) {
            filteredData.append(flightDetail).append(" ");
          }
          filteredData.append("\n");
        }
      }
      break;

    case "Destination City":
      for (String[] flightInfo : data.arrayData) {
        if (flightInfo[3].equalsIgnoreCase(search)) {

          for (String flightDetail : flightInfo) {
            filteredData.append(flightDetail).append(" ");
          }
          filteredData.append("\n");
        }
      }
      break;

    case "Carrier":
      for (String[] flightInfo : data.arrayData) {
        if (flightInfo[7].equalsIgnoreCase(search)) {

          for (String flightDetail : flightInfo) {
            filteredData.append(flightDetail).append(" ");
          }
          filteredData.append("\n");
        }
      }
      break;
    }
  }


  // Update the TextArea with the filtered data
  if (textArea != null) {
    textArea.setText(filteredData.toString());
  } else {
    cp5 = new ControlP5(this);
    textArea = cp5.addTextarea("txt")
      .setPosition(100, 400)
      .setSize(800, 300)
      .setFont(createFont("arial", 20))
      .setLineHeight(20)
      .setColor(0)
      .setColorBackground(color(255))
      .setColorForeground(color(255, 100));
    textArea.setText(filteredData.toString());
  }
}
