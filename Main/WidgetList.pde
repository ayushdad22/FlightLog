final int SCREENX = 1024;
final int SCREENY = 780;
final int EVENT_BUTTON1= 1;
final int EVENT_BUTTON2= 2;
final int EVENT_BUTTON3= 3;
final int EVENT_BUTTON4 = 4;
final int EVENT_BUTTON5 = 5;
final int EVENT_NULL=0;
ArrayList<Widget> widgetList;
color defaultBorderColor;
color rectColor;
PFont stdFont;
Screen screen1, screen2, screen3, screen4, screen5, currentScreen;

void setup() {

  size(1024, 780);

  stdFont = loadFont("Arial-Black-20.vlw");
  textFont(stdFont);

  widgetList = new ArrayList<Widget>();
   // Create instances of Widget
  Widget widget1 = new Widget(464, 0, 140, 30, "Graphs", color(232, 37, 54), stdFont, EVENT_BUTTON1);
  Widget widget2 = new Widget(604, 0, 140, 30, "Maps", color(74, 96, 229), stdFont, EVENT_BUTTON2);
  Widget widget3 = new Widget(744, 0, 140, 30, "Search", color(90, 222, 112), stdFont, EVENT_BUTTON3);
  Widget nextButton = new Widget(884, 0, 140, 30, "Home", color(219, 222, 90), stdFont, EVENT_BUTTON4);
  Widget backButton = new Widget(30, 20, 140, 40, "Blank", color(219, 222, 90), stdFont, EVENT_BUTTON5);
  

  // Add widgets to the list
  widgetList.add(widget1);
  widgetList.add(widget2);
  widgetList.add(widget3);
  widgetList.add(nextButton);
  widgetList.add(backButton);


 /*Checkbox checkbox = new Checkbox(100, 250, 180, 40, "Checkbox", color(150, 150, 150), stdFont, EVENT_BUTTON5, false);
   RadioButton radioButton = new RadioButton(100, 350, 180, 40, "RadioButton", color(150, 150, 150), stdFont, EVENT_BUTTON4, false);
   
   widgetList.add(checkbox);
   widgetList.add(radioButton);*/

  defaultBorderColor = color(0);  // Set the default border color

  // Create instances of Screen
  screen1 = new Screen(color(232, 37, 54), "Search bar");
  screen2 = new Screen(color(219, 222, 90), "Search bar");
  screen3 = new Screen(color(90, 222, 112), "Search bar");
  screen4 = new Screen(color(74, 96, 229), "Search bar");
  screen5 = new Screen(color(232, 37, 54), "Search bar");
  currentScreen = screen2;

  // Add widgets to screens
  screen1.addWidget(widget1);
  screen1.addWidget(widget2);
  screen1.addWidget(widget3);
  screen1.addWidget(nextButton);


  screen2.addWidget(widget1);
  screen2.addWidget(widget2);
  screen2.addWidget(widget3);
  screen2.addWidget(nextButton);

  
  screen3.addWidget(widget1);
  screen3.addWidget(widget2);
  screen3.addWidget(widget3);
  screen3.addWidget(nextButton);

  
  screen4.addWidget(widget1);
  screen4.addWidget(widget2);
  screen4.addWidget(widget3);
  screen4.addWidget(nextButton);

  
  screen5.addWidget(widget1);
  screen5.addWidget(widget2);
  screen5.addWidget(widget3);
  screen5.addWidget(nextButton);

  /* screen2.addWidget(checkbox);
   screen2.addWidget(radioButton);*/
}

void draw() {
  for (int i = 0; i<widgetList.size(); i++) {
    Widget aWidget = (Widget)widgetList.get(i);
    aWidget.draw();
  }
  currentScreen.draw();
}

/*
void draw() {
 for (Widget aWidget : widgetList) {
 aWidget.draw();
 }
 }*/
void mousePressed() {
  int event;

  for (int i = 0; i<widgetList.size(); i++) {
    Widget aWidget = (Widget) widgetList.get(i);
    event = aWidget.getEvent(mouseX, mouseY);
    switch(event) {
    case EVENT_BUTTON1:
      currentScreen = screen5;
      println("button 1!");
      break;
    case EVENT_BUTTON2:
      currentScreen = screen4;
      println("button 2!");
      break;
    case EVENT_BUTTON3:
      rectColor = color(0, 255, 0);
      currentScreen = screen3;
      println("button 3!");
      break;
    case EVENT_BUTTON4:
 println("button 4!");
      currentScreen = screen2;
      rectx = 1000;
      recty = 1000;
      break;
    case EVENT_BUTTON5:
      println("button 5!");
      currentScreen = screen1;
      rectx = 330;
      recty = 200;
      break;
    }
  }
}
void mouseMoved() {
  for (int i = 0; i < widgetList.size(); i++) {
    Widget aWidget = widgetList.get(i);
    if (aWidget.isMouseOver(mouseX, mouseY)) {
      aWidget.setBorderColor(color(255));
    } else {
      aWidget.setBorderColor(defaultBorderColor);
    }
  }
}
