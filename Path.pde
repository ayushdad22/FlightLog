public class Path {
  
  color pathColor;

  Path(color pathColor) {
    this.pathColor = pathColor;
  }
  void getPosition(float latitude1, float longitude1, float latitude2, float longitude2) {
    x1 = earthRadius * -cos(latitude1) * cos(longitude1);
    z1 = earthRadius * cos(latitude1) * sin(longitude1);
    y1 = earthRadius * -sin(latitude1);

    x2 = earthRadius * -cos(latitude2) * cos(longitude2);
    z2 = earthRadius * cos(latitude2) * sin(longitude2);
    y2 = earthRadius * -sin(latitude2);
  }

  void drawCurve(float latitude1, float longitude1, float latitude2, float longitude2 ) {
    getPosition(latitude1, longitude1, latitude2, longitude2);
    float heightOfCurve = y1 - 50;
    pushMatrix();
    stroke(pathColor);
    noFill();
    beginShape();
    strokeWeight(2);
    vertex(x1, y1, z1);
    bezierVertex(x1, y1, z1, (x1 + x2) / 2, heightOfCurve, z1, x2, y2, z2);
    endShape();
    popMatrix();
  }
}
