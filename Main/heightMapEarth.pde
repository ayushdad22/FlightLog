class HeightMapEarth{
  PImage img, img1;
  int cols, rows;
  int scl = 2;
  float[][] terrain;
  float radius = 150; 
  HeightMapEarth(){
    //img = loadImage("Earth_Height_Map.jpg");
    img = loadImage("World_elevation_map.png");
    img1 = loadImage("Earth_Texture.jpg");
    img1.resize(width, height);
    img.resize(width, height);
    img.filter(GRAY);
    
    cols = img.width / scl;
    rows = img.height / scl;
    terrain = new float[cols][rows];
    img.loadPixels();
    float elevationScale = 10; // Adjust this scale factor as needed for a more realistic appearance
    for (int y = 0; y < rows; y++) {
      for (int x = 0; x < cols; x++) {
        float bright = brightness(img.pixels[index(x * scl, y * scl)]);
        terrain[x][y] = map(bright, 0, 255, -elevationScale, elevationScale);
      }
    }
    
  }
  int index(int x, int y) {
    return x + y * img.width;
  }
  
  void draw(){
    textureMode(NORMAL);
    noStroke();
    rotateX(PI);
    for (int y = 0; y < rows - 1; y++) {
      beginShape(TRIANGLE_STRIP);
      texture(img1);
      for (int x = 0; x <= cols; x++) {
        int currentX = x % cols; 

        float u = (float) currentX / cols;
        float v1 = (float) y / rows;
        float v2 = (float) (y + 1) / rows;

        PVector p1 = getPointOnSphere(currentX, y, terrain[currentX][y]);
        vertex(p1.x, p1.y, p1.z, u, v1);

        PVector p2 = getPointOnSphere(currentX, y + 1, terrain[currentX][(y + 1) % rows]); // Wrap the y+1 to close the sphere
        vertex(p2.x, p2.y, p2.z, u, v2);
      }  
      endShape(CLOSE);
    }
  }
  
  PVector getPointOnSphere(int x, int y, float elevation) {

    float theta = map(y, 0, rows, 0, PI);
    float phi = map(x, 0, cols, 0, TWO_PI);

    float r = radius + elevation;
    float xPos = r * sin(theta) * cos(phi);
    float yPos = r * cos(theta);
    float zPos = r * sin(theta) * sin(phi);

    return new PVector(xPos, yPos, zPos);
  }
}
