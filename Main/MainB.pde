import java.util.ArrayList;
import java.util.concurrent.*;
import processing.data.Table;
import processing.data.TableRow;
import controlP5.*;

final int SCROLLBAR_COLOR = #0799fa;
ControlP5 cp5;
boolean dataLoaded = false;
CompletableFuture<DataPoint> dataLoadFuture = new CompletableFuture<>();

DataPoint data;
PApplet mainApplet;
BarChartApp barChartApp;
LineChartApp lineChartApp;
Scatterplot scatterplot;
//Chart chart;
boolean chartLoaded = false;

ArrayList<String> airportOrign = new ArrayList<String>();
ArrayList<Integer> airportCancelled = new ArrayList<Integer>();


void setup() {
  size(1024, 780);
  mainApplet = this;
  //barChartApp = new BarChartApp(mainApplet);
  //lineChartApp = new LineChartApp(mainApplet);
  //scatterplot = new Scatterplot(this);

  println("System Loading...");
  CompletableFuture<Table> tableFuture = CompletableFuture.supplyAsync(() ->
    loadTable("flights_full.csv", "header"));

  tableFuture.thenAccept(table -> {
    println("Table loaded successfully.");
    ArrayList<String[]> arrayListData = new ArrayList<>();
    for (TableRow tableRow : table.rows()) {
      String date = tableRow.getString("FL_DATE");
      String origin = tableRow.getString("ORIGIN_CITY_NAME");
      String airportOrigin = tableRow.getString("ORIGIN");
      String dest = tableRow.getString("DEST_CITY_NAME");
      String destAirport = tableRow.getString("DEST");
      float distance = tableRow.getFloat("DISTANCE");
      String cancel = str(tableRow.getInt("CANCELLED"));
      String airlines = tableRow.getString("MKT_CARRIER");
      String[] arrayData = {date, origin, airportOrigin, dest, destAirport, String.valueOf(distance), cancel, airlines};
      arrayListData.add(arrayData);
    }
    data = new DataPoint(arrayListData);
    dataLoaded = true;
    println("Data processing finished.");
    dataLoadFuture.complete(data); // Signal that data loading is complete
  }
  );
}

void draw() {
  if (chartLoaded) {
    background(255);
    //chart.draw();
    barChartApp.draw(300, 300, 400, 200);
    lineChartApp.draw(300, 100, 400, 200);
    //scatterplot.draw(20, 20, width - 40, height - 40);
  }
}

void keyPressed() {
  if (key == CODED && keyCode == UP && dataLoaded && !dataLoadFuture.isCompletedExceptionally()) {
    dataLoadFuture.thenAcceptAsync(dataPoint -> {
      //println(dataPoint.airportOrigin());
      addPrintButton();
      cp5 = new ControlP5(this);
      cp5.addScrollableList("HOME")
        .setPosition(600, 0)
        .setBackgroundColor(SCROLLBAR_COLOR)
        .setSize(300, 300)
        .setBarHeight(50)
        .setItemHeight(50)
        .close()
        .addItems(dataPoint.airportOrigin());

      cp5 = new ControlP5(this);
      cp5.addScrollableList("HOME")
        .setPosition(300, 0)
        .setBackgroundColor(SCROLLBAR_COLOR)
        .setSize(300, 300)
        .setBarHeight(50)
        .setItemHeight(50)
        .close()
        .addItems(dataPoint.airportOrigin());

      cp5 = new ControlP5(this);
      cp5.addScrollableList("HOME")
        .setPosition(0, 0)
        .setBackgroundColor(SCROLLBAR_COLOR)
        .setSize(300, 300)
        .setBarHeight(50)
        .setItemHeight(50)
        .close()
        .addItems(dataPoint.airportOrigin());
    }
    );
  } else if (chartLoaded) {
    // Remove the buttons and dropdowns from the ControlP5 instance
    cp5.getController("PRINT_BUTTON").remove();
    cp5.getController("HOME").remove();
  }
}

void controlEvent(ControlEvent event) {
  String selectedTab;
  if (event.isFrom("HOME")) {
    selectedTab = cp5.get(ScrollableList.class, "HOME").getItem((int) event.getValue()).get("name").toString();
    dataLoadFuture.thenAcceptAsync(dataPoint -> {
      CompletableFuture<Integer> cancelledFlightsFuture = dataPoint.getCancelledFlightsCount(selectedTab);
      cancelledFlightsFuture.thenAccept(cancelledFlightsCount -> {
        airportOrign.add(selectedTab);
        airportCancelled.add(cancelledFlightsCount);
      }
      );
    }
    );
  } else if (event.isFrom("PRINT_BUTTON")) {
    barChartApp = new BarChartApp(mainApplet, airportOrign, airportCancelled, "Bar");
    lineChartApp = new LineChartApp(mainApplet, airportOrign, airportCancelled, "Bar");
    chartLoaded = true;
  }
}

void addPrintButton() {
  cp5 = new ControlP5(this);
  cp5.addButton("PRINT_BUTTON")
    .setPosition(10, 350)
    .setSize(100, 50)
    .setLabel("Print Counts");
}
