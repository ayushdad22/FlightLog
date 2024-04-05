import controlP5.*;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.HashMap;
import java.util.Map;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import org.gicentre.utils.stat.*;

// for charts:
// num of flights in a day
// flights to aiport in a week
// longest flight distance
// most number of flights from airlines

public class DataPoint {
  private ArrayList<String[]> arrayData;

  public DataPoint(ArrayList<String[]> arrayData) {
    this.arrayData = arrayData;
  }

  String[] selectData = {"Cancelled", "Delayed", "Diverted", "All"};

  public String getAllDataSortedAlphabetically() {
    sortDataByCityAndAirport(); // Sorts the data alphabetically by city and airport

    StringBuilder result = new StringBuilder();
    for (String[] flightInfo : arrayData) {
      String flightDetails = String.join(" ", flightInfo);
      result.append(flightDetails).append("\n");
    }
    return result.toString();
  }

  //dates
  public ArrayList<String>  dateData() {
    ArrayList<String> dateData = new ArrayList<String>();
    for (String[] data : arrayData) {
      dateData.add(data[0]); //origin index
    }
    return dateData;
  }

  //airport origin
  public ArrayList<String>  airportOrigin() {
    ArrayList<String> originData = new ArrayList<String>();
    for (String[] data : arrayData) {
      if (!originData.contains(data[2])) {
        originData.add(data[2]); //origin index
      }
    }
    return originData;
  }
  //distance data
  public ArrayList<String>  distanceData() {
    ArrayList<String> distData = new ArrayList<String>();
    for (String[] data : arrayData) {
      distData.add(data[10]); //distance index
    }
    return distData;
  }
  //cancelled data
  public ArrayList<String>  canceledData() {
    ArrayList<String> cnclData = new ArrayList<String>();
    for (String[] data : arrayData) {
      cnclData.add(data[9]); //cancel index
    }
    return cnclData;
  }
  //airline data
  public ArrayList<String>  airlineData() {
    ArrayList<String> arlnData = new ArrayList<String>();
    for (String[] data : arrayData) {
      arlnData.add(data[11]); // airline index
    }
    return arlnData;
  }

  //destination airport data
  public ArrayList<String> destinationAirportData() {
    ArrayList<String> airData = new ArrayList<String>();
    for (String[] data : arrayData) {
      airData.add(data[6]); // destination airport index
    }
    return airData;
  }

  public int countFlightsFromOrigin(String originAirportCode) {
    int flightsFromOrigin = 0;
    for (String[] data : arrayData) {
      if (data[2].equals(originAirportCode)) {
        flightsFromOrigin++;
      }
    }
    return flightsFromOrigin;
  }

  public CompletableFuture<Integer> getCancelledFlightsCount(String airportName) {
    CompletableFuture<Integer> future = CompletableFuture.supplyAsync(() -> {
      int cancelledFlightsCount = 0;
      for (String[] data : arrayData) {
        if (data[2].equals(airportName) && data[6].equals("1")) {
          cancelledFlightsCount++;
        }
      }
      return cancelledFlightsCount;
    }
    );
    return future;
  }


  public String getFlightWithLongestDistance() {
    float maxDistance = 0;
    String flightWithLongestDistance = null;

    for (String[] data : arrayData) {
      float distance = Float.parseFloat(data[5]); // assuming distance index is 10
      if (distance > maxDistance) {
        maxDistance = distance;
        flightWithLongestDistance = data[2];
      }
    }

    return flightWithLongestDistance;
  }

  public int countFlightsForAirline(String airline) {
    int count = 0;
    for (String[] data : arrayData) {
      if (data[11].equals(airline)) { // Assuming airline index is 11
        count++;
      }
    }
    return count;
  }

  public int countDelayed(String airportName) {
    int count = 0;
    for (String[] data : arrayData) {
      if (data[2].equals(airportName) && data[6].equals("1")) { // Assuming airport name index is 2 and delayed status index is 6
        count++;
      }
    }
    return count;
  }



  public int countFlightsInOneDay(String date) {
    int count = 0;
    for (String[] data : arrayData) {
      if (data[0].equals(date)) { // Assuming date index is 0
        count++;
      }
    }
    return count;
  }

  public int countFlightsInOneWeek(String startDate) {
    int count = 0;

    LocalDate start = LocalDate.parse(startDate);
    LocalDate end = start.plusDays(6); // Adding 6 days to get the end date (one week later)

    for (String[] data : arrayData) {
      LocalDate flightDate = LocalDate.parse(data[0]); // Assuming date index is 0
      if (!flightDate.isBefore(start) && !flightDate.isAfter(end)) {
        count++;
      }
    }
    return count;
  }

  public int countDiverted(String airportName) {
    int count = 0;
    for (String[] data : arrayData) {
      if (data[2].equals(airportName) && data[8].equals("1")) { // Assuming airport name index is 2 and delayed status index is 6
        count++;
      }
    }
    return count;
  }

  private void sortByDistance(String dataType, ArrayList<String[]> arraySortData) {
    if (dataType != null) {
      switch (dataType) {
      case "Distance":
        arraySortData.sort((distance1, distance2) -> {
          Float dist1 = Float.parseFloat(distance1[5]);
          Float dist2 = Float.parseFloat(distance2[5]);
          return dist1.compareTo(dist2);
        }
        );
        break;
      case "Alphabetical":
        sortDataByCityAndAirport();
        break;
      default:
        // Handle the default case or leave it empty if there's nothing to do
        break;
      }
    }
  }

  private void sortDataByCityAndAirport() {
    arrayData.sort(new Comparator<String[]>() {
      @Override
        public int compare(String[] flight1, String[] flight2) {
        // First compare by city/state
        int cityStateComparison = flight1[0].compareTo(flight2[0]);
        if (cityStateComparison != 0) {
          return cityStateComparison;
        }
        // If cities/states are the same, compare by airport code
        return flight1[1].compareTo(flight2[1]);
      }
    }
    );
  }

  public int countFlightsBetweenAirports(String originAirportCode, String destinationAirportCode) {
    int count = 0;
    for (String[] data : arrayData) {
      if (data[2].equals(originAirportCode) && data[4].equals(destinationAirportCode)) {
        count++;
      }
    }
    return count;
  }


  public String[] getDestinations(String originAirportCode) {
    ArrayList<String> destinations = new ArrayList<>();

    for (String[] data : arrayData) {
      if (data[2].equals(originAirportCode)) {
        destinations.add(data[4]);
      }
    }

    // Convert ArrayList to String array
    String[] airports = destinations.toArray(new String[destinations.size()]);

    return airports;
  }
}
