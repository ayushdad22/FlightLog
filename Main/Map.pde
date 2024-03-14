import de.fhpotsdam.unfolding.*;
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

Table table;
//PieChart pie;
ArrayList<Flight> flights;
Path flightPath;
float maxPanningDistance = 3000; // in km
PFont font;
Flight flight;

UnfoldingMap map;

void setup() {
  size(1200, 1000, P3D);
  table = loadTable("C:\\Users\\thopp\\Downloads\\flights2k(1).csv", "header");
  //flightPath = new Path (50, 90, 400, 100);
  flights = new ArrayList();
  font = loadFont("ArialMT-15.vlw");
  textFont(font);
  //text((flight.printData(flights)), 10, 10);
  loadData();

  mapSettings();
  setMarker(BHM, MHT);             // set airports
  printData(flights);

  // createAirportPieChart();
}

void mapSettings() {
  map = new UnfoldingMap(this, 200, 200, 800, 600);
  MapUtils.createDefaultEventDispatcher(this, map);
  Location americaLocation = new Location(39.8283f, -98.5795f);
  map.zoomAndPanTo(americaLocation, 4);
  map.setTweening(true);
  map.setZoomRange(4, 8);
  map.setPanningRestriction(americaLocation, maxPanningDistance);
}

void setMarker(Location startLocation, Location endLocation) {
  ImageMarker start = new ImageMarker(startLocation, loadImage("ui/marker_gray.png") ,"Origin");
  ImageMarker end = new ImageMarker(endLocation, loadImage("ui/marker_red.png"), "Destination");
  SimpleLinesMarker connectionMarker = new SimpleLinesMarker(startLocation, endLocation);

  map.addMarker(connectionMarker);
  map.addMarkers(start, end);
}

void draw() {
  background(0);
  //flightPath.draw();
  //flightPath.move();

  //map.draw();
}

/*void createAirportPieChart() {
 // Calculate the frequency of each origin airport
 HashMap<String, Integer> airportFrequency = calculateAirportFrequency();
 
 // Convert the frequency map to arrays for the PieChart class
 String[] airportNames = airportFrequency.keySet().toArray(new String[0]);
 float[] airportFlights = new float[airportNames.length];
 for (int i = 0; i < airportNames.length; i++) {
 airportFlights[i] = airportFrequency.get(airportNames[i]);
 }
 
 PieChart pie = new PieChart(300, airportFlights);
 pie.draw();
 }
 
 HashMap<String, Integer> calculateAirportFrequency() {
 HashMap<String, Integer> airportFrequency = new HashMap<String, Integer>();
 
 for (Flight flight : flights) {
 String originAirport = flight.origin;
 
 if (airportFrequency.containsKey(originAirport)) {
 int currentCount = airportFrequency.get(originAirport);
 airportFrequency.put(originAirport, currentCount + 1);
 } else {
 airportFrequency.put(originAirport, 1);
 }
 }
 
 return airportFrequency;
 }
 */
