import controlP5.*;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List; 
import java.util.Set;
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
    String[] selectData2 = {"Cancelled", "Delayed", "Diverted", "All"};

   public String getAllDataSortedAlphabetically2() {
        //sortDataByCityAndAirport(); // Sort the data alphabetically

        StringBuilder result = new StringBuilder();
        for (String[] flightInfo : arrayData) {
            for (String info : flightInfo) {
                result.append(info).append(" ");
            }
            result.append("\n"); // Add a newline after each flight information
        }
        return result.toString();
    }
    
    public ArrayList<String> dateData() {
        return extractDataFromIndex(0); // Index for date
    }

    public ArrayList<String> airportOrigin() {
        return extractUniqueDataFromIndex(2); // Index for origin airport
    }

    public ArrayList<String> distanceData() {
        return extractDataFromIndex(10); // Index for distance
    }

    public ArrayList<String> canceledData() {
        return extractDataFromIndex(9); // Index for canceled status
    }

    public ArrayList<String> airlineData() {
        return extractDataFromIndex(11); // Index for airline
    }

    public ArrayList<String> destinationAirportData() {
        return extractDataFromIndex(6); // Index for destination airport
    }

    // Counts flights from a specific origin
    public int countFlightsFromOrigin2(String originAirportCode) {
        return (int) arrayData.stream()
                .filter(data -> data[2].equals(originAirportCode))
                .count();
    }

    // Extracts data from a specified index for all entries
    private ArrayList<String> extractDataFromIndex(int index) {
        ArrayList<String> extractedData = new ArrayList<>();
        for (String[] data : arrayData) {
            extractedData.add(data[index]);
        }
        return extractedData;
    }

    // Extracts unique data from a specified index for all entries
    private ArrayList<String> extractUniqueDataFromIndex(int index) {
        Set<String> extractedData = new HashSet<>();
        for (String[] data : arrayData) {
            extractedData.add(data[index]);
        }
        return new ArrayList<>(extractedData);
    }

  String[] selectData = {"Cancelled", "Delayed", "Diverted", "All"};

 public String getAllDataSortedAlphabetically() {
        //sortDataByCityAndAirport(); // Sort the data alphabetically

        StringBuilder result = new StringBuilder();
        for (String[] flightInfo : arrayData) {
            for (String info : flightInfo) {
                result.append(info).append(" ");
            }
            result.append("\n"); // Add a newline after each flight information
        }
        return result.toString();
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
    return CompletableFuture.supplyAsync(() -> 
        arrayData.stream()
                 .filter(data -> data[2].equals(airportName) && "1".equals(data[6]))
                 .count()
    ).thenApply(Long::intValue);
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
      switch(dataType) {
      case "Distance":
        arraySortData.sort(new Comparator<String[]>() {
          @Override
            public int compare(String[] distance1, String[] distance2) {
            // Convert the distance strings to float and compare them as numbers.
            Float dist1 = Float.parseFloat(distance1[5]);
            Float dist2 = Float.parseFloat(distance2[5]);
            return dist1.compareTo(dist2);
          }
        }
        );
        break;
      case "Alphabetical":
        sortDataByCityAndAirport(arraySortData);
        break;
      }
    }
  }



  private ArrayList<String[]> sortDataByCityAndAirport(ArrayList<String[]> arraySortData) {
    arraySortData.sort(new Comparator<String[]>() {
      @Override
        public int compare(String[] flight1, String[] flight2) {
        // First compare by city/state
        int cityStateComparison = flight1[1].compareTo(flight2[1]);
        if (cityStateComparison != 0) {
          return cityStateComparison;
        }
        // If cities/states are the same, compare by airport code
        return flight1[2].compareTo(flight2[2]);
      }
    }
    );
    return arraySortData;
  }
}
