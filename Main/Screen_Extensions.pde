class Graphs extends Screens {
  Graphs(color backgroundColor, String screenText) {
    super(backgroundColor, screenText);
  }

  void graphSetup() {
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
        String diverted = str(tableRow.getInt("DIVERTED"));
        String airlines = tableRow.getString("MKT_CARRIER");
        String[] arrayData = {date, origin, airportOrigin, dest, destAirport, String.valueOf(distance), cancel, airlines, diverted};
        arrayListData.add(arrayData);
      }
      data = new DataPoint(arrayListData);
      dataLoaded = true;
      println("Data processing finished.");
      dataLoadFuture.complete(data); // Signal that data loading is complete
    }
    );
  }
}


class Maps extends Screens {
  Maps(color backgroundColor, String screenText) {
    super(backgroundColor, screenText);
  }
}

class Home extends Screens {
  Home(color backgroundColor, String screenText) {
    super(backgroundColor, screenText);
  }
}

class Logs extends Screens {
  Logs(color backgroundColor, String screenText) {
    super(backgroundColor, screenText);
  }
}
