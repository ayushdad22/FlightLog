Scrollbar scrollbar;
final int EVENT_BUTTON = 1;
final int EVENT_NULL = 0;
final int SCREEN_X = 500;
final int SCREEN_Y = 500;

void settings() {
  size(SCREEN_X, SCREEN_Y);
}

void setup() {
  scrollbar = new Scrollbar (0, 0, 20, 75, 255, EVENT_BUTTON);
}

void draw() {
  background(0);
  scrollbar.draw();
}
  
void mouseDragged() {
  int scrollEvent;
  scrollEvent = scrollbar.getEvent(mouseX, mouseY);
  
  if (scrollEvent == EVENT_BUTTON) {
    scrollbar.move();
  }
}
