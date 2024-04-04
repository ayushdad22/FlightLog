public class Path {
  
  color pathColor;

  Path(color pathColor) {
    this.pathColor = pathColor;
  }
  
  public PVector getPosition(float latitude, float longitude, float earthRadius) {
    latitude = latitude +0.15;
    longitude = longitude -0.07;
    return new PVector(
      earthRadius * -cos(latitude) * cos(longitude),
      earthRadius * cos(latitude) * sin(longitude),
      earthRadius * -sin(latitude)
    );
  }

  void drawCurve(float latitude1, float longitude1, float latitude2, float longitude2 ) {
    
    PVector marker1 = getPosition(latitude1, longitude1, 200);
    PVector marker2 = getPosition(latitude2, longitude2, 200);
    float heightOfCurve = (marker1.y + marker2.y)/2 - 50;
    
    pushMatrix();
    stroke(pathColor);
    noFill();
    beginShape();
    strokeWeight(2);
    vertex(marker1.x, marker1.y, marker1.z);
    bezierVertex(marker1.x, marker1.y, marker1.z, (marker1.x + marker2.x) / 2, heightOfCurve, marker1.z, marker2.x, marker2.y, marker2.z);
    endShape();
    popMatrix();
  }
}
