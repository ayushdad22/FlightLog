

class ArrowWidget extends Widget
{
  int arrowWidth = 215;
  int arrowHeight = 400;
  int marginRight = 20;
  int windowWidth = 1024;
  int windowHeight = 780;

  String direction;


  ArrowWidget(int x, int y, int width, int height, String label, color widgetColor, PFont widgetFont, int event, String direction)
  {
    super(x, y, width, height, label, widgetColor, widgetFont, event);
    this.direction = direction;
  }

  void draw() {
    strokeWeight(5);
    stroke(255);
    fill(255);

    int shaftY = 400;
    int headBaseStartX = direction.equals("left") ? 150 : 850;
    int headBaseEndX = direction.equals("left") ? 135 : 870;
    int headY = 400;


    triangle(headBaseStartX, shaftY - 5, headBaseEndX, headY, headBaseStartX, shaftY + 5);
  }
}
