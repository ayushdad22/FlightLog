import de.fhpotsdam.unfolding.*;  //<>//
import de.fhpotsdam.unfolding.core.*;
import de.fhpotsdam.unfolding.data.*;
import de.fhpotsdam.unfolding.events.*;
import de.fhpotsdam.unfolding.geo.*;
import de.fhpotsdam.unfolding.interactions.*;
import de.fhpotsdam.unfolding.mapdisplay.*;
import de.fhpotsdam.unfolding.mapdisplay.shaders.*;
import de.fhpotsdam.unfolding.marker.*;
import de.fhpotsdam.unfolding.providers.*;
import de.fhpotsdam.unfolding.texture.*;
import de.fhpotsdam.unfolding.tiles.*;
import de.fhpotsdam.unfolding.ui.*;
import de.fhpotsdam.unfolding.utils.*;
import de.fhpotsdam.utils.*;
import processing.core.PApplet;

import de.fhpotsdam.unfolding.UnfoldingMap;
import de.fhpotsdam.unfolding.geo.Location;
import de.fhpotsdam.unfolding.utils.MapUtils;

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

UnfoldingMap map;
Screens screen;
Graphs GraphScreen;
Maps MapsScreen;
Home HomeScreen;
Logs LogScreen;
ArrayList<Widget> widgetList;
color defaultBorderColor = color(0);

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
Location americaLocation = new Location(39.8283f, -98.5795f);

DataPoint data;
PApplet mainApplet;
Chart barchart;
Chart scatterplot;
Chart linegraph;
Chart piechart;
AirportLocations loc;
boolean chartLoaded = false;
String selectingData = "";
String search;
Textarea textArea;

ArrayList<SimpleLinesMarker> lineMarker = new ArrayList<SimpleLinesMarker>();
ArrayList<SimplePointMarker> pointMarker = new ArrayList<SimplePointMarker>();
ArrayList<ImageMarker> imageMarker = new ArrayList<ImageMarker>();
ArrayList<String> airportOrign = new ArrayList<String>();
ArrayList<Integer> airportCancelled = new ArrayList<Integer>();
PImage imgEarth;

void setup() {
  size(1024, 780, P3D);
  
  mapSettings();
  imgEarth = loadImage("Earth_Texture.jpg");
  stdFont = createFont("Aachen Bold.ttf", 20);
  
  searchbar = new ControlP5(this);
  
  LogScreen = new Logs(this, color(225), "");
  GraphScreen = new Graphs(this, color(225), "");
  MapsScreen = new Maps(this, color(225), "");
  HomeScreen = new Home(color(255), "");
  currentScreen = HomeScreen;
  widgetList = new ArrayList<Widget>();
  
  println("System Loading...");
  GraphScreen.graphSetup();
  loc = new AirportLocations();
  
}

//creates 2d map usong unfolding - Shuban
void mapSettings() {
  map = new UnfoldingMap(this, 100, 190, 800, 400);
  MapUtils.createDefaultEventDispatcher(this, map);
  map.zoomAndPanTo(americaLocation, 4);
  map.setTweening(true);
  map.setZoomRange(4, 8);
  map.setPanningRestriction(americaLocation, 3000);
}
void draw() {
  for (int i = 0; i < widgetList.size(); i++) {
    Widget aWidget = widgetList.get(i);
    aWidget.draw();
  }
  currentScreen.draw();
  if (currentScreen != LogScreen) {
    LogScreen.removeSearchBar();
    LogScreen.removeTextArea();
  }
  if(chartLoaded && currentScreen == GraphScreen){
    switch(arrowClicked){
      case 0:
      linegraph.draw(280, 315, 450, 250);
      break;
      case 1:
      barchart.draw(280, 315, 450, 220);
      break;
      case 2:
      scatterplot.draw(280, 315, 450, 220);
      break;
      case 3:
      piechart.draw(280, 315, 450, 220);
      break;
    }
  }
}

void controlEvent(ControlEvent event) {
  if (event.isAssignableFrom(Textfield.class)) {
    search = event.getStringValue();
  }
}

void setMarkerImage(Location startLocation, Location endLocation) {
  
  ImageMarker startMarker = new ImageMarker(startLocation, loadImage("ui/marker_gray.png"), 
  MapsScreen.dropdown2.getSelectedOption());
  ImageMarker endMarker = new ImageMarker(endLocation, loadImage("ui/marker_red.png"), MapsScreen.dropdown3.getSelectedOption());
  SimpleLinesMarker connectionMarker = new SimpleLinesMarker(startLocation, endLocation);
  map.addMarker(connectionMarker);
  map.addMarkers(startMarker, endMarker);
  lineMarker.add(connectionMarker);
  imageMarker.add(startMarker);
  imageMarker.add(endMarker);
  
}
void setMarker(Location startLocation, Location endLocation) {

  SimplePointMarker startMarker = new SimplePointMarker(startLocation);
  SimplePointMarker endMarker = new SimplePointMarker(endLocation);
  SimpleLinesMarker connectionMarker = new SimpleLinesMarker(startLocation, endLocation);
  endMarker.setColor(color(255, 0, 0, 100));
  startMarker.setColor(color(0, 255, 0, 100));
  //map.addMarker(connectionMarker);
  map.addMarkers(startMarker, endMarker);
  lineMarker.add(connectionMarker);
  pointMarker.add(startMarker);
  pointMarker.add(endMarker);
  
}
//Switch case that switches current screen to chosen screen when widget is pressed.-Patrick
void mousePressed() {
  currentScreen.mousePressed();
  int event = currentScreen.getEvent(); 
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
  int startX = rightArrow.getShaftStartX();
  int endX = rightArrow.getHeadBaseEndX();
  int startY = rightArrow.getShaftY() - 5; 
  int endY = rightArrow.getShaftY() + 5;

  int leftStartX = leftArrow.getHeadBaseEndX(); 
  int leftEndX = leftArrow.getShaftStartX();    
  int leftStartY = leftArrow.getShaftY() - 5;   
  int leftEndY = leftArrow.getShaftY() + 5;
  
  // Click detection logic
  if (mouseX >= startX && mouseX <= endX && mouseY >= startY && mouseY <= endY)
  {
    if (arrowClicked < 3)
    {
      arrowClicked++;
    } else {
      arrowClicked = 0;
    }
  }

  if (mouseX >= leftStartX && mouseX <= leftEndX && mouseY >= leftStartY && mouseY <= leftEndY)
  {
    if (arrowClicked > 0) {
      arrowClicked--; 
    } else {
      arrowClicked = 3;
    }
  }
}
void mouseMoved() {
  currentScreen.mouseMoved();
}
void mouseWheel(MouseEvent event) {
  currentScreen.mouseWheel(event);
}

void mouseDragged() {
  currentScreen.mouseDragged();
}

/**
 * This function handles the logic when the sorting options are selected in dropdown1.
 * It retrieves data from dataLoadFuture and then calculates the number of cancelled flights for the options selected in dropdown2 and dropdown3.
 * It updates the airportOrign and airportCancelled lists based on the selected options and retrieved data.
 * Finally, it calls createCharts() to generate charts and sets chartLoaded to true. - Brian /Shuban
 */
void clickedDropDown() {
  switch(GraphScreen.dropdown1.getSelectedOption()) {
  case "Cancelled":
    dataLoadFuture.thenAcceptAsync(dataPoint -> {
      CompletableFuture<Integer> cancelledFlightsFuture = dataPoint.getCancelledFlightsCount(GraphScreen.dropdown2.getSelectedOption());
      CompletableFuture<Integer> cancelledFlightsFuture1 = dataPoint.getCancelledFlightsCount(GraphScreen.dropdown3.getSelectedOption());

      CompletableFuture.allOf(cancelledFlightsFuture, cancelledFlightsFuture1).thenRun(() -> {
        if (GraphScreen.dropdown2.getSelectedOption() != "Select an option" && !airportOrign.contains(GraphScreen.dropdown2.getSelectedOption())) {
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
void createCharts() {
  barchart = new Chart(mainApplet, airportOrign, airportCancelled, "Bar");
  linegraph = new Chart(mainApplet, airportOrign, airportCancelled, "Line");
  scatterplot = new Chart(mainApplet, airportOrign, airportCancelled, "Scatter");
  piechart = new Chart(mainApplet, airportOrign, airportCancelled, "Pie");
  chartLoaded = true;
}
/**
 * This function filters the flight data based on the selected search option and data type, 
 * and displays the filtered data in the text area. - Shuban
 */
void textArea() {
  ArrayList<String[]> tempFilteredDataList = new ArrayList<>();
  StringBuilder filteredData = new StringBuilder(); //string builder to build string from an arrayList of string values
  String selectedOption = LogScreen.dropdownSearch.getSelectedOption();
  String dataType = LogScreen.dropdownSort.getSelectedOption();
  

  if (dataLoadFuture.isDone() && selectedOption != null) {
    switch(selectedOption) {
    case "Origin Airport":
      for (String[] flightInfo : data.arrayData) {
        if (flightInfo[2].equalsIgnoreCase(search)) {
          tempFilteredDataList.add(flightInfo);
        }
      }
      break;
    case "Destination Airport":
      for (String[] flightInfo : data.arrayData) {
        if (flightInfo[4].equalsIgnoreCase(search)) {
          tempFilteredDataList.add(flightInfo);
        }
      }
      break;
    case "Origin City":
      for (String[] flightInfo : data.arrayData) {
        if (flightInfo[1].equalsIgnoreCase(search)) {
          tempFilteredDataList.add(flightInfo);
        }
      }
      break;
    case "Destination City":
      for (String[] flightInfo : data.arrayData) {
        if (flightInfo[3].equalsIgnoreCase(search)) {
          tempFilteredDataList.add(flightInfo);
        }
      }
      break;
    case "Carrier":
      for (String[] flightInfo : data.arrayData) {
        if (flightInfo[7].equalsIgnoreCase(search)) {
          tempFilteredDataList.add(flightInfo);
        }
      }
      break;
    }
    
    // sorts/filetrs the data by distance
    data.sortByDistance(dataType, tempFilteredDataList);

    // converts the filtered and sorted list into a string
    for (String[] flightInfo : tempFilteredDataList) {
      for (String flightDetail : flightInfo) {
        filteredData.append(flightDetail).append(" ");
      }
      filteredData.append("\n");
    }
  }
  // Update the TextArea with the filtered data - Shuban
  if (textArea != null) {
    textArea.setText(filteredData.toString());
  } else {
    cp5 = new ControlP5(this);
    textArea = cp5.addTextarea("txt")
      .setPosition(100, 400)
      .setSize(800, 260)
      .setFont(stdFont)
      .setLineHeight(20)
      .setColor(0)
      .setColorBackground(color(255))
      .setColorForeground(color(255, 100));
    textArea.setText(filteredData.toString());
  }
}

// creates search bara using control p5 - Shuban
void searchBar() {
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
