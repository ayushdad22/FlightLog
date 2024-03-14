class Marker{
    color markerColor;

  Marker(color markerColor) {
    this.markerColor = markerColor;
  }
  
  void drawMarker(float latitude, float longitude) {
  float x = earthRadius *  -cos(latitude) * cos(longitude) ;
  float z = earthRadius * cos(latitude) * sin(longitude);
  float y = earthRadius * -sin(latitude);
  println(x,y,z);
 
  pushMatrix();
  translate(x, y, z);
  fill(markerColor);
  sphere(2);
  popMatrix();
}
}
