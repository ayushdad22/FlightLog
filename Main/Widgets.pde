class Widget {
  int x, y, width, height;
  String label;
  int event;
  color widgetColor, labelColor, borderColor;
  PFont widgetFont;

  Widget(int x, int y, int width, int height, String label,
    color widgetColor, PFont widgetFont, int event) {
    this.x=x;
    this.y=y;
    this.width = width;
    this.height= height;
    this.label=label;
    this.event=event;
    this.widgetColor=widgetColor;
    this.widgetFont=widgetFont;
    labelColor= color(255);
    borderColor = defaultBorderColor;
  }

  void draw() {
    fill(widgetColor);
    stroke(borderColor);
    rect(x, y, width, height, 15, 15, 0, 0);
    noStroke();
    fill(labelColor);
    text(label, x+10, y+height-10);
    textSize(20);

    fill(182, 182, 182);
    rect(0, 0, 464, 30);

    stroke(0);
    line(0, 30, 1024, 30);
  }

  int getEvent(int mX, int mY) {
    if (mX > x && mX < x + width && mY > y && mY < y + height) {
      return event;
    }
    return EVENT_NULL;
  }


  boolean isMouseOver(int mX, int mY) {
    return (mX > x && mX < x + width && mY > y && mY < y + height);
  }

  void setBorderColor(color newColor) {
    borderColor = newColor;
  }
}
