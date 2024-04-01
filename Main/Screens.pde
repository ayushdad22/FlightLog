abstract class Screens {
  color backgroundColor;
  String screenText;
  protected ArrayList<Widget> widgetList;

  Screens(color backgroundColor, String screenText) {
    this.backgroundColor = backgroundColor;
    this.screenText = screenText;
    this.widgetList = new ArrayList<Widget>();


    Widget widget1 = new Widget(100, 100, 200, 30, "Graphs", color(0), stdFont, EVENT_BUTTON1);
    Widget widget2 = new Widget(300, 100, 200, 30, "Maps", color(0), stdFont, EVENT_BUTTON2);
    Widget widget3 = new Widget(500, 100, 200, 30, "Flight Logs", color(0), stdFont, EVENT_BUTTON3);
    Widget nextButton = new Widget(700, 100, 200, 30, "Home", color(0), stdFont, EVENT_BUTTON4);


    widgetList.add(widget1);
    widgetList.add(widget2);
    widgetList.add(widget3);
    widgetList.add(nextButton);
  }

  void draw() {
    fill(0);
    background(100, 200, 255);
    for (Widget widget : widgetList) {
      widget.draw();
    }
  }

  int getEvent() {
    for (Widget widget : widgetList) {
      if (widget.getEvent(mouseX, mouseY) != EVENT_NULL) {
        return widget.getEvent(mouseX, mouseY);
      }
    }
    return EVENT_NULL;
  }
}
