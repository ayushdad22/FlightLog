//Ayush
public class Path {
  
  color pathColor;
  float latitude, longitude, earthRadius;
  float[] marker;
  Path(color pathColor, Location airport) {// path color and origin airport is used as parameters
    this.latitude = radians(airport.x);
    this.longitude = radians(airport.y);
    earthRadius = 170;
    this.pathColor = pathColor;
    marker = getPosition(latitude, longitude);
  }
  //create x and y and z coordinates using mathematical conversion. 
  float[] getPosition( float latitude, float longitude){
     float x = earthRadius *  -cos(latitude) * cos(longitude) ; 
    float z = earthRadius * cos(latitude) * sin(longitude);
    float y = earthRadius * -sin(latitude);
    float[] arrayPositons = {x,y,z};
    return arrayPositons;
  } 
  //minor information: The negative values exist due to processings flipped coordinate system, 
  //Pvectors for some reason changed the values creating inaccurate marking so floats were used instead

  void drawCurve(Location location) {// desintation airport is used as parameter
    
    
    float[] otherMarker = getPosition(radians(location.x), radians(location.y));
    float heightOfCurve = (marker[1] + otherMarker[1])/2 - 50; //find height of both markers and get average and increase by 50
    pushStyle();
    drawMarker(marker);
    drawMarker(otherMarker);
    stroke(pathColor);
    noFill();
    beginShape();
    strokeWeight(2);
    vertex(marker[0], marker[1], marker[2]);
    bezierVertex(marker[0], marker[1], marker[2], (marker[0] + otherMarker[0]) / 2, heightOfCurve, marker[2], otherMarker[0], otherMarker[1], otherMarker[2]);
    endShape();
    popStyle();
    
  }
  //creates markers at airport location
  void drawMarker(float[] markerPos){
    pushMatrix();
    translate(markerPos[0], markerPos[1], markerPos[2]);
    if(markerPos[0] == marker[0] && markerPos[1] == marker[1] && markerPos[2] == marker[2]){
      fill(0, 255, 0);
    }else{
      fill(255, 0, 0);
    }
    sphere(2);
    popMatrix();
  }
}
