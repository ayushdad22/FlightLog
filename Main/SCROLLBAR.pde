class Scrollbar {
  int x; 
  int y;
  int xpos;
  int ypos;
  int width;
  int height;
  int scrollEvent;
  color scrollbarColor;
  
  Scrollbar (int x, int y, int width, int height, color scrollbarColor, int scrollEvent) {
    xpos = x;
    ypos = y;
    this.width = width;
    this.height = height;
    this.scrollbarColor = scrollbarColor;
    this.scrollEvent = scrollEvent;
  }
  
  void draw() {
    fill(scrollbarColor);
    rect(x, y, width, height);
  }
  
  void move() {
    if (y > SCREEN_Y - height) {y = SCREEN_Y - height;}
    else {y = (mouseY - (height / 2));}
  }
  
  int getEvent(int mX, int mY) {
    if (mX > x && mX < x + width && mY > y && mY < y + height) {return scrollEvent;}
    return EVENT_NULL;
  }
}
