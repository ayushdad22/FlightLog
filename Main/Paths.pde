public class Path {
  
  color pathColor;
  float latitude, longitude, earthRadius;
  float[] marker;
  Path(color pathColor, Location airport) {
    this.latitude = radians(airport.x);
    this.longitude = radians(airport.y);
    earthRadius = 170;
    this.pathColor = pathColor;
    marker = getPosition(latitude, longitude);
  }
  
  float[] getPosition( float latitude, float longitude){
     float x = earthRadius *  -cos(latitude) * cos(longitude) ;
    float z = earthRadius * cos(latitude) * sin(longitude);
    float y = earthRadius * -sin(latitude);
    float[] arrayPositons = {x,y,z};
    return arrayPositons;
  }

  void drawCurve(Location location) {
    
    
    float[] otherMarker = getPosition(radians(location.x), radians(location.y));
    float heightOfCurve = (marker[1] + otherMarker[1])/2 - 50;
    
    drawMarker(marker);
    drawMarker(otherMarker);
    pushMatrix();
    stroke(pathColor);
    noFill();
    beginShape();
    strokeWeight(2);
    vertex(marker[0], marker[1], marker[2]);
    bezierVertex(marker[0], marker[1], marker[2], (marker[0] + otherMarker[0]) / 2, heightOfCurve, marker[2], otherMarker[0], otherMarker[1], otherMarker[2]);
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
