class Screen {
  color backgroundColor;
 
  Screen(color backgroundColor) {
    this.backgroundColor = backgroundColor;
  }
 
  void draw() {
    background(backgroundColor);
  }
}
