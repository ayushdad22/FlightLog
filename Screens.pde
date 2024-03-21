abstract class Screens {
  color backgroundColor;
  String screenText;
  protected ArrayList<Widget> widgetList;

  Screens(color backgroundColor, String screenText) {
    this.backgroundColor = backgroundColor;
    this.screenText = screenText;
    this.widgetList = new ArrayList<Widget>();

    // Initialize widgets here to ensure all needed resources are available
    Widget widget1 = new Widget(464, 0, 140, 30, "Graphs", color(232, 37, 54), stdFont, EVENT_BUTTON1);
    Widget widget2 = new Widget(604, 0, 140, 30, "Maps", color(74, 96, 229), stdFont, EVENT_BUTTON2);
    Widget widget3 = new Widget(744, 0, 140, 30, "Search", color(90, 222, 112), stdFont, EVENT_BUTTON3);
    Widget nextButton = new Widget(884, 0, 140, 30, "Home", color(219, 222, 90), stdFont, EVENT_BUTTON4);

    // Add widgets to the list
    widgetList.add(widget1);
    widgetList.add(widget2);
    widgetList.add(widget3);
    widgetList.add(nextButton);
  }

  void draw() {
    fill(0); // Set the text color
    background(backgroundColor);
    for (Widget widget : widgetList) {
      widget.draw();
    }
  }

int getEvent() {
  for (Widget widget : widgetList) {
    if (widget.getEvent(mouseX, mouseY) != 0)
    {
      return(widget.getEvent(mouseX, mouseY));
    }
  }
  return EVENT_NULL;
}
}
