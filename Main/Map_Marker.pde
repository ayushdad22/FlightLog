
public class Marker{
  Path firstAirport;
  String location;
  String[] arrayOfAirports;
  AirportLocations dataForAirport;
  Marker(String firstAirport, String[] arrayOfAirports) {
    dataForAirport = new AirportLocations();
    this.arrayOfAirports = arrayOfAirports;
    this.location = firstAirport;
     this.firstAirport = new Path(0, dataForAirport.getLocation(firstAirport));
  }
  
  void createPath(){
    for(String airport : arrayOfAirports){
      firstAirport.drawCurve((dataForAirport.getLocation(airport)));
    }
  }
  void unfoldingMapCreatePath(){
    for(String airport : arrayOfAirports){
      setMarker(dataForAirport.getLocation(location), dataForAirport.getLocation(airport));
    }
  }
}
