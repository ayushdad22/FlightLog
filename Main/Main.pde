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
  //if(key == CODED && keyCode == DOWN && tableFuture.isDone() && !tableFuture.isCompletedExceptionally()){
  //  Table table = tableFuture.join();
  //  for (TableRow tableRow : table.rows()) {
  //    String stateAbv = tableRow.getString("ORIGIN");
  //    String state = tableRow.getString("ORIGIN_CITY_NAME");
  //    if (!arrayStateAbv.contains(stateAbv)) {
  //      arrayStateAbv.add(stateAbv);
  //      arrayState.add(state);
  //      println(state, stateAbv);
  //    }
  //  }
  //}
  //if(key == CODED && keyCode == UP && tableFuture.isDone() && !tableFuture.isCompletedExceptionally()){
  //  Table table = tableFuture.join();

  //  for (TableRow tableRow : table.rows()) {
  //    String state = tableRow.getString("ORIGIN");
  //    if (!arrayState.contains(state)) {
  //      arrayState.add(state);
  //    }
  //  }
  //  ArrayList<String> destStates = new ArrayList<>(arrayState);
  //  for (String originState : arrayState) {
  //    destStates.remove(originState);

  //    for (String destState : destStates) {
  //      for (TableRow tableRow : table.rows()) {
  //        String depTime = tableRow.getString("DEP_TIME");
  //        String expDepTime = tableRow.getString("CRS_DEP_TIME");
  //        String arrTime = tableRow.getString("ARR_TIME");
  //        String expArrTime = tableRow.getString("CRS_ARR_TIME");
  //        String origin = tableRow.getString("ORIGIN_CITY_NAME");
  //        String originAirport = tableRow.getString("ORIGIN");
  //        String dest = tableRow.getString("DEST_CITY_NAME");
  //        String destAirport = tableRow.getString("DEST");
  //        float distance = tableRow.getFloat("DISTANCE");

  //        if (originAirport.contains(originState) && destAirport.contains(destState)) {
  //          String[] distanceData = {origin,originAirport,expArrTime,arrTime,dest,destAirport,expDepTime,depTime, String.valueOf(distance)};
  //          arrayDistances.add(distanceData);
            
  //        }
  //      }
  //    }
  //  }    
  //  dataLoaded = true;
  //  data = new DataPoint(arrayDistances);
  //}
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
      
      if (!arrayState.contains(origin)) {
        String[] distanceData = {origin,originAirport,expArrTime,arrTime,dest,destAirport,expDepTime,depTime, String.valueOf(distance)};
        arrayDistances.add(distanceData);
        
      }
    }
    data = new DataPoint(arrayDistances);
    dataLoaded = true;
  }
}
