//ayush
class Planet {
  //variables
  float radius, angle, distance;
  PVector vectorCoord;
  PShape globe;

  Planet (float radius) {
    // create variable with placeholder values
    vectorCoord = PVector.random3D();
    this.radius = radius;
    noStroke();
    noFill();
    //draw Prcoessing geometry 
    globe = createShape(SPHERE, this.radius);
    globe.setTexture(imgEarth);
  }
  void draw() {
    pushMatrix();
    //define x, y and z values
    float x = distance * sin(radians(45));
    float y = distance * cos(radians(45));
    float z = 0;
    
    vectorCoord.set(x, y, z);
    //place it in 3d universe
    translate(vectorCoord.x, vectorCoord.y, vectorCoord.z);
    shape(globe);
    popMatrix();
  }
}
