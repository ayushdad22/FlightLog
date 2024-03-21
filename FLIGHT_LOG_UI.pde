final int SCREENX = 1024;
final int SCREENY = 780;
final int EVENT_BUTTON1 = 1;
final int EVENT_BUTTON2 = 2;
final int EVENT_BUTTON3 = 3;
final int EVENT_BUTTON4 = 4;
final int EVENT_BUTTON5 = 5;
final int EVENT_NULL = 0;
final int SCROLLBAR_COLOR = #0799fa;
ControlP5 cp5;
PFont stdFont;
Screen graphScreen, mapScreen, homeScreen, searchScreen, currentScreen;

void settings() {
  size(SCREENX, SCREENY);
}
 
void setup() {
  // Scrollable List
  String[] tabs = new String[]{"Graphs", "Maps", "Search", "Home"};
  cp5 = new ControlP5(this); 
  cp5.addScrollableList("HOME")
    .setPosition(724, 0)
    .setBackgroundColor(SCROLLBAR_COLOR)
    .setSize(300, 300)
    .setBarHeight(50)
    .setItemHeight(50)
    .close()
    .addItems(tabs);
    
  cp5.setFont(new ControlFont(createFont("Arial", 15)));
 
  stdFont = loadFont("Arial-Black-20.vlw");
  textFont(stdFont);

  
  graphScreen = new Screen(color(232, 37, 54));
  mapScreen = new Screen(color(219, 222, 90));
  searchScreen = new Screen(color(90, 222, 112));
  homeScreen = new Screen(color(74, 96, 229));
  currentScreen = homeScreen;
}
 
void draw() {
  currentScreen.draw();
}

void controlEvent (ControlEvent event) {
  String selectedTab;
  if (event.isFrom("HOME")) {
    selectedTab = cp5.get(ScrollableList.class, "HOME").getItem((int) event.getValue()).get("name").toString();
    switch (selectedTab) {
      case "Graphs":
        currentScreen = graphScreen;
        break;
      case "Maps":
        currentScreen = mapScreen;
        break;
      case "Search":
        currentScreen = searchScreen;
        break;
      case "Home":
        currentScreen = homeScreen;
        break;
    }
  }
}
