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

  String[] selectData = {"Cancelled", "Delayed", "All", "Diverted"};


 public String getAllDataSortedAlphabetically() {
        sortDataByCityAndAirport(); // Sort the data alphabetically

        StringBuilder result = new StringBuilder();
        for (String[] flightInfo : arrayData) {
            for (String info : flightInfo) {
                result.append(info).append(" ");
            }
            result.append("\n"); // Add a newline after each flight information
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
}
