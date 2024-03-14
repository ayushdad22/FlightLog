class DataPoint{
  ArrayList<String[]> arrayData = new ArrayList<>();
  DataPoint(ArrayList<String[]> arrayData){
    this.arrayData = arrayData;
 }
 void draw(){
   for(String[] arrayAirport : arrayData){
     for(String array : arrayAirport){
       print(array +" " );
     }
   }
 }
}
