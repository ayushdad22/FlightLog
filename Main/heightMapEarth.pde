// Ayush's code
class HeightMapEarth{
  // Declares variables for storing images, the number of columns and rows, and scale factor
  PImage img, img1;
  int cols, rows;
  int scl = 2; // Scale factor to reduce image resolution for performance
  float[][] terrain; // Array to store elevation data
  float radius = 150; // Radius of the sphere (earth) in pixels

  // Constructor of the HeightMapEarth class
  HeightMapEarth(){
    // Loads the elevation and texture images
    img = loadImage("World_elevation_map.png");
    img1 = loadImage("Earth_Texture.jpg");
    img1.resize(width, height); // Resizes the texture image to match the display window
    img.resize(width, height); // Resizes the elevation map to match the display window
    img.filter(GRAY); // Converts the elevation map to grayscale
    
    // Calculates the number of columns and rows based on image resolution and scale factor
    cols = img.width / scl;
    rows = img.height / scl;
    terrain = new float[cols][rows]; // Initializes the terrain array
    img.loadPixels(); // Loads the pixel data of the elevation map into an array for processing

    float elevationScale = 10; // Factor to scale the elevation for a more dramatic effect
    // Loops through each pixel to convert brightness to elevation
    for (int y = 0; y < rows; y++) {
      for (int x = 0; x < cols; x++) {
        float bright = brightness(img.pixels[index(x * scl, y * scl)]); // Gets the brightness as elevation
        terrain[x][y] = map(bright, 0, 255, -elevationScale, elevationScale); // Maps brightness to elevation
      }
    }
  }

  // Helper function to calculate the index in the pixel array from x, y coordinates
  int index(int x, int y) {
    return x + y * img.width;
  }
  
  // Renders the 3D model of Earth with the applied texture and elevation
  void draw(){
    textureMode(NORMAL); // Uses normalized coordinates for textures
    noStroke(); // Disables drawing an outline for shapes
    rotateX(PI); // Rotates the model to correct the orientation
    
    // Loops through the grid to draw each segment with the correct texture and elevation
    for (int y = 0; y < rows - 1; y++) {
      beginShape(TRIANGLE_STRIP); // Begins a new shape as a strip of triangles
      texture(img1); // Applies the earth texture to the shape
      for (int x = 0; x <= cols; x++) {
        int currentX = x % cols; // Wraps x to create a seamless sphere

        // Calculates normalized texture coordinates
        float u = (float) currentX / cols;
        float v1 = (float) y / rows;
        float v2 = (float) (y + 1) / rows;

        // Calculates the 3D position of two vertices and adds them to the shape
        PVector p1 = getPointOnSphere(currentX, y, terrain[currentX][y]);
        vertex(p1.x, p1.y, p1.z, u, v1);
        PVector p2 = getPointOnSphere(currentX, y + 1, terrain[currentX][(y + 1) % rows]);
        vertex(p2.x, p2.y, p2.z, u, v2);
      }  
      endShape(CLOSE); // Closes and finishes the shape
    }
  }
  
  // Calculates the 3D position on a sphere given a grid position and elevation
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
