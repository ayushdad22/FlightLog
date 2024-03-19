import java.util.ArrayList;
import java.util.concurrent.*;
boolean dataLoaded = false;
CompletableFuture<Table> tableFuture = new CompletableFuture<>();
DataPoint data;

void setup() {
  tableFuture = CompletableFuture.supplyAsync(
    () -> loadTable("flights_full.csv", "header")
  );
}

void draw() {  
  println(dataLoaded);
  if(dataLoaded){
    data.draw();
  }
}
ArrayList<String> arrayStateAbv = new ArrayList<>();
ArrayList<String> arrayState = new ArrayList<>();
ArrayList<String[]> arrayDistances = new ArrayList<>();

void keyPressed(){

  if(key == CODED && keyCode == UP && tableFuture.isDone() && !tableFuture.isCompletedExceptionally()){
    Table table = tableFuture.join();
    for (TableRow tableRow : table.rows()) {
      String depTime = tableRow.getString("DEP_TIME");
      String expDepTime = tableRow.getString("CRS_DEP_TIME");
      String arrTime = tableRow.getString("ARR_TIME");
      String expArrTime = tableRow.getString("CRS_ARR_TIME");
      String origin = tableRow.getString("ORIGIN_CITY_NAME");
      String originAirport = tableRow.getString("ORIGIN");
      String dest = tableRow.getString("DEST_CITY_NAME");
      String destAirport = tableRow.getString("DEST");
      float distance = tableRow.getFloat("DISTANCE");
      String airlines = tableRow.getString("MKT_CARRIER");
      
      if (!arrayState.contains(origin)) {
        String[] distanceData = {origin,originAirport,expArrTime,arrTime,dest,destAirport,expDepTime,depTime, String.valueOf(distance), (airlines)};
        arrayDistances.add(distanceData);
        
      }
    }
    data = new DataPoint(arrayDistances);
    dataLoaded = true;
  }
}
