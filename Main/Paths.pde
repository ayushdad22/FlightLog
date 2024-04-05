public class Path {
  
  color pathColor;
  float latitude, longitude, earthRadius;
  Path(color pathColor, Location airport) {
    this.latitude = radians(airport.x);
    this.longitude = radians(airport.y);
    earthRadius = 170;
    this.pathColor = pathColor;
  }
  
  float[] getPosition( float latitude, float longitude){
     float x = earthRadius *  -cos(latitude) * cos(longitude) ;
    float z = earthRadius * cos(latitude) * sin(longitude);
    float y = earthRadius * -sin(latitude);
    float[] arrayPositons = {x,y,z};
    return arrayPositons;
  }

  void drawCurve(Location location) {
    
    float[] marker1 = getPosition(latitude, longitude);
    float[] marker2 = getPosition(radians(location.x), radians(location.y));
    float heightOfCurve = (marker1[1] + marker2[1])/2 - 50;
    
    drawMarker(marker1);
    drawMarker(marker2);
    pushMatrix();
    stroke(pathColor);
    noFill();
    beginShape();
    strokeWeight(2);
    vertex(marker1[0], marker1[1], marker1[2]);
    bezierVertex(marker1[0], marker1[1], marker1[2], (marker1[0] + marker2[0]) / 2, heightOfCurve, marker1[2], marker2[0], marker2[1], marker2[2]);
    endShape();
    popMatrix();
  }
  void drawMarker(float[] marker){
    pushMatrix();
    translate(marker[0], marker[1], marker[2]);
    fill(255, 0, 0);
    sphere(2);
    popMatrix();
  }
}
