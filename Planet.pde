class Planet {
  
  float radius,angle, distance;
  PVector vectorCoord;
  PShape globe;

  Planet (float radius) { 
    vectorCoord = PVector.random3D();
    this.radius = radius;
    noStroke();
    noFill();
    //this.distance = radius*2 ; 
    globe = createShape(SPHERE, this.radius);
    globe.setTexture(imgEarth);
    
  }
  void draw() {
    pushMatrix();
    float x = distance * sin(radians(45));
    float y = distance * cos(radians(45));
    float z = 0; 

    vectorCoord.set(x, y, z);
    translate(vectorCoord.x, vectorCoord.y, vectorCoord.z);
    shape(globe);
    popMatrix();
  }

}
