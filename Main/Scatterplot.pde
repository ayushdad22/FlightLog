class Scatterplot
{
  PApplet applet;
  XYChart scatterplot;
  ArrayList<String> arrayNames;
  ArrayList<Integer> dataValues;
  String chartType;

  // Data arrays can be initialized here or through a constructor or method.
  float[] income = {25000, 32000, 47000, 54000, 62000, 75000};
  float[] lifeExp = {74, 78, 69, 72, 79, 81};

  // Constructor
  Scatterplot(PApplet applet)
  {
    this.applet = applet;
    this.scatterplot = new XYChart(applet);
    setupChart();
  }

  // Setup chart appearance and data
  private void setupChart()
  {
    applet.textFont(applet.createFont("Arial", 11), 11);
    scatterplot.setData(income, lifeExp);

    // Axis formatting and labels
    scatterplot.showXAxis(true);
    scatterplot.showYAxis(true);
    scatterplot.setXFormat("$###,###");
    scatterplot.setXAxisLabel("\nAverage income per person " + "(inflation adjusted $US)");
    scatterplot.setYAxisLabel("Life expectancy at birth (years)\n");

    // Symbol styles
    scatterplot.setPointColour(applet.color(180, 50, 50, 100));
    scatterplot.setPointSize(5);
  }

  // Draw method to render the scatterplot
  void draw(int x, int y, int width, int height)
  {
    applet.background(255);
    scatterplot.draw(x, y, width, height);
  }
}
