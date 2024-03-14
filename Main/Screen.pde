class Screen {
  ArrayList<Widget> widgetList;
  color backgroundColor;
  String screenText;


  Screen(color backgroundColor, String screenText) {
    this.backgroundColor = backgroundColor;
    this.widgetList = new ArrayList<Widget>(); // Initialize widgetList
    this.screenText = screenText;
  }

  void addWidget(Widget widget) {
    widgetList.add(widget);
  }

  void draw() {
    fill(0); // Set the text color
    background (backgroundColor);

    for (Widget widget : widgetList) {
      widget.draw();
    }
    if (this == screen2) {
      fill(255);
      textSize(20);
      text(screenText, 20, 20);
    } else {
      fill(255);
      textSize(20);
      text(screenText, 20, 20);
    }
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
