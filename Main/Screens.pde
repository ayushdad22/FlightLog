abstract class Screens {
  color backgroundColor;
  String screenText;
  protected ArrayList<Widget> widgetList;

  Screens(color backgroundColor, String screenText) {
    this.backgroundColor = backgroundColor;
    this.screenText = screenText;
    this.widgetList = new ArrayList<Widget>();


    Widget widget1 = new Widget(464, 0, 140, 30, "Graphs", color(226,135,67), stdFont, EVENT_BUTTON1);
    Widget widget2 = new Widget(604, 0, 140, 30, "Maps", color(21,76,121), stdFont, EVENT_BUTTON2);
    Widget widget3 = new Widget(744, 0, 140, 30, "Flight Logs", color(226,135,67), stdFont, EVENT_BUTTON3);
    Widget nextButton = new Widget(884, 0, 140, 30, "Home", color(21,76,121), stdFont, EVENT_BUTTON4);


    widgetList.add(widget1);
    widgetList.add(widget2);
    widgetList.add(widget3);
    widgetList.add(nextButton);
  }

  void draw() {
    fill(0);
    background(backgroundColor);
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
