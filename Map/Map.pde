
Table table;
ArrayList<Flight> flights;
//Path flightPath;
float maxPanningDistance = 3000; // in km
//PFont font;
Flight flight;
//public enum MapState = {2D, 3D};
UnfoldingMap map;

void setup() {
  size(1200, 1000, P3D);
  //table = loadTable("C:\\Users\\thopp\\Downloads\\flights2k(1).csv", "header");
  //flightPath = new Path (50, 90, 400, 100);
  //flights = new ArrayList();
  //font = loadFont("ArialMT-15.vlw");
  //textFont(font);
  //text((flight.printData(flights)), 10, 10);
  //loadData();

  mapSettings();
  setMarker(BHM, MHT);             // set airports
}

void mapSettings() {
  map = new UnfoldingMap(this, 200, 200, 800, 600);
  MapUtils.createDefaultEventDispatcher(this, map);
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

  map.draw();
}
