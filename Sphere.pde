import peasy.*;
import peasy.org.apache.commons.math.*;
import peasy.org.apache.commons.math.geometry.*;
float earthRadius = 200;
float startLat = radians(29.9872);
float startLon = radians(-95.3474);
float endLat = radians(40.6413);
float endLon = radians(-73.7781);
float x1, y1, z1, x2, y2, z2;

Planet earth;
Path path;
PeasyCam cam;
PImage imgEarth;
Marker markerStart;
Marker markerEnd;

void setup() {
  size (1000, 600, P3D);

  imgEarth = loadImage("Earth_Texture.jpg");
  //imgEarth = loadImage("HighDef_Earth_Texture.jpg"); //There is also a lowdef
  path = new Path(color(0,0,0));
  earth = new Planet(earthRadius);
  cam = new PeasyCam(this, 400);
  markerStart = new Marker(color(255, 0, 0));
  markerEnd = new Marker(color(255,0,0));

  cam.lookAt(0, -120, 0);
  cam.setYawRotationMode();
  // Adjust the camera rotation angles to focus on the USA
  cam.rotateX(-PI/30); //angle down
  cam.rotateY(-PI/1);

  cam.setMinimumDistance(230);
}

void draw() {

  background(0);
  //lights();//if you want light around the entire earth
  directionalLight(255, 255, 255, 0.2, 0.5, 1); //spin the sphere around until you see america
  //directionalLight(255, 0, 255, 0.2, 0.5, 1); //adds funny colours
  earth.draw();
  //path.drawCurve(startLat, startLon, endLat, endLon);
  markerStart.drawMarker(startLat, startLon);
  markerEnd.drawMarker(endLat, endLon);
}
