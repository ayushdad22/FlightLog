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

//Super cLass DataPoint - Brian
public class DataPoint {
  private ArrayList<String[]> arrayData;
  private AirportLocations location;
  public DataPoint(ArrayList<String[]> arrayData) {
    this.arrayData = arrayData;
    location = new AirportLocations();
  }

  String[] selectData = {"Cancelled", "Delayed", "Diverted", "All"};
  
  // Sorts the data alphabetically by city and airport - Brian
  public String getAllDataSortedAlphabetically() {
    sortDataByCityAndAirport(); 

    StringBuilder result = new StringBuilder();
    for (String[] flightInfo : arrayData) {
      String flightDetails = String.join(" ", flightInfo);
      result.append(flightDetails).append("\n");
    }
    return result.toString();
  }

  //Finding the dates  - Brian
  public ArrayList<String>  dateData() {
    ArrayList<String> dateData = new ArrayList<String>();
    for (String[] data : arrayData) {
      dateData.add(data[0]); //origin index
    }
    return dateData;
  }

  //finding airport origin - Brian 
  public ArrayList<String>  airportOrigin() {
    ArrayList<String> originData = new ArrayList<String>();
    for (String[] data : arrayData) {
      if (!originData.contains(data[2])) {
        originData.add(data[2]); //origin index
      }
    }
    return originData;
  }
  //Finding the distance between two airports - Brian
  public ArrayList<String>  distanceData() {
    ArrayList<String> distData = new ArrayList<String>();
    for (String[] data : arrayData) {
      distData.add(data[10]); //distance index from the main functions
    }
    return distData;
  }
  //cancelled flights data for the flights - Brian
  public ArrayList<String>  canceledData() {
    ArrayList<String> cnclData = new ArrayList<String>();
    for (String[] data : arrayData) {
      cnclData.add(data[9]); //cancel index
    }
    return cnclData;
  }
  //gets the airline data -Brian
  public ArrayList<String>  airlineData() {
    ArrayList<String> arlnData = new ArrayList<String>();
    for (String[] data : arrayData) {
      arlnData.add(data[11]); // airline index
    }
    return arlnData;
  }

  //destination of the airport data used in dropdown menus - Brian
  public ArrayList<String> destinationAirportData() {
    ArrayList<String> airData = new ArrayList<String>();
    for (String[] data : arrayData) {
      airData.add(data[6]); // destination airport index
    }
    return airData;
  }
  // counting the flights from origin and adding the data up - Brian
  public int countFlightsFromOrigin(String originAirportCode) {
    int flightsFromOrigin = 0;
    for (String[] data : arrayData) {
      if (data[2].equals(originAirportCode)) {
        flightsFromOrigin++;
      }
    }
    return flightsFromOrigin;
  }
 //completing future loads the data and checks the cancelled flights data and compares airport to airport data from above functions -Brian
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

  //This function is used to get the longest flight data by distance - Brian
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
  //flights for each airline that it iterates through - Brian
  public int countFlightsForAirline(String airline) {
    int count = 0;
    for (String[] data : arrayData) {
      if (data[11].equals(airline)) { // Assuming airline index is 11
        count++;
      }
    }
    return count;
  }
  public String distanceBetweenTwoAirports(String originAirport, String destinationAirport){
    for(String[]data : arrayData){
      if(data[2].equals(originAirport) && data[4].equals(destinationAirport)){
        return data[5] + "m";
      }
    }
    return str((int)location.getLocation(originAirport).getDistance(location.getLocation(destinationAirport))) + "m";
  }
  public int distanceBetweenAirports(String originAirport, String destinationAirport){
    for (String[] data : arrayData) {
      if(data[1] ==  originAirport && data[3] ==  destinationAirport){
        return int(data[5]);
      }
    }
      return 0;
  }
  
 //sorting the number of delayed flights - Brian
  public int countDelayed(String airportName) {
    int count = 0;
    for (String[] data : arrayData) {
      if (data[2].equals(airportName) && data[6].equals("1")) { // Assuming airport name index is 2 and delayed status the index is 6
        count++;
      }
    }
    return count;
  }


  //count all the flights in one day - Brian 
  public int countFlightsInOneDay(String date) {
    int count = 0;
    for (String[] data : arrayData) {
      if (data[0].equals(date)) { // Assuming date index is 0
        count++;
      }
    }
    return count;
  }

  //Counting the number of flights in one week - Brian 
  public int countFlightsInOneWeek(String startDate) {
    int count = 0;

    LocalDate start = LocalDate.parse(startDate);
    LocalDate end = start.plusDays(6); // Adding 6 days to get the data for one week after end date (one week later)

    for (String[] data : arrayData) {
      LocalDate flightDate = LocalDate.parse(data[0]); // Assuming date index if  0 is index
      if (!flightDate.isBefore(start) && !flightDate.isAfter(end)) {
        count++;
      }
    }
    return count;
  }
  //count diverted flights by airport name  - Brian
  public int countDiverted(String airportName) {
    int count = 0;
    for (String[] data : arrayData) {
      if (data[2].equals(airportName) && data[8].equals("1")) { // Assuming airport name index is 2 and delayed status index is 6
        count++;
      }
    }
    return count;
  }
  //sorting the distance by data and taking arrayList and it's data type sorted - Brian
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
  //function for sortingData by city and airport - Brian
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
  
  //counting flights between airport 1 and 2 and so on for the search bar menu - Brian
  public int countFlightsBetweenAirports(String originAirportCode, String destinationAirportCode) {
    int count = 0;
    for (String[] data : arrayData) {
      if (data[2].equals(originAirportCode) && data[4].equals(destinationAirportCode)) {
        count++;
      }
    }
    return count;
  }

  //getting the distance of the origin Airport by it's code for the search bar menu - Brian
  public String[] getDestinations(String originAirportCode) {
    ArrayList<String> destinations = new ArrayList<>();

    for (String[] data : arrayData) {
      if (data[2].equals(originAirportCode)) {
        destinations.add(data[4]);
      }
    }

    // Convert ArrayList to String array :)
    String[] airports = destinations.toArray(new String[destinations.size()]);

    return airports;
  }
}
