import java.util.ArrayList;
import java.util.Collections;
import java.util.concurrent.*;
import processing.core.PApplet;

// Chart class: Handles the creation and rendering of different chart types using data provided - Abdul/Patrick
class Chart {
  PApplet applet;
  BarChart barChart;
  XYChart scatterplot;
  XYChart lineChart;
  ArrayList<String> arrayNames;
  ArrayList<Integer> dataValues;
  String chartType;
  
ArrowWidget rightArrow = new ArrowWidget(150, 185, 65, 30, "Right Arrow", color(255), stdFont, EVENT_RIGHT_ARROW, "right");
ArrowWidget leftArrow = new ArrowWidget(150, 215, 65, 30, "Left Arrow", color(255), stdFont, EVENT_LEFT_ARROW, "left");

 // Constructor: Initializes the chart with a reference to the applet, the data, and the type of chart to display.
  Chart(PApplet applet, ArrayList<String> arrayNames, ArrayList<Integer> dataValues, String chartType) {
    this.applet = applet;
    this.arrayNames = arrayNames;
    this.dataValues = dataValues;
    this.chartType = chartType;
    this.lineChart = new XYChart(applet);
    this.scatterplot = new XYChart(applet);
    this.barChart = new BarChart(applet);
    setupLineChart();
    setupBarChart();
    setupChart();
  }

// Sets up a scatterplot chart with the data provided, configuring its appearance and behavior. - Abdul
  private void setupChart()
  {
    applet.textFont(applet.createFont("Arial", 11), 11);

    float[] xValues = new float[arrayNames.size()];
    for (int i = 0; i < arrayNames.size(); i++) {
      xValues[i] = i + 1;
    }

    float[] yValues = new float[dataValues.size()];
    for (int i = 0; i < dataValues.size(); i++) {
      yValues[i] = dataValues.get(i);
    }

    scatterplot.setData(xValues, yValues);
    scatterplot.showXAxis(true);
    scatterplot.showYAxis(true);
    scatterplot.setXFormat("###");
    scatterplot.setXAxisLabel("\nAirports:");
    scatterplot.setYAxisLabel("Number of Flights\n");

    // Symbol styles
    scatterplot.setPointColour(applet.color(0, 71, 171));
    scatterplot.setPointSize(15);

  }

 // Sets up a bar chart with the data provided, including visual styles and axis information. - Abdul
  private void setupBarChart() {
    float[] values = new float[dataValues.size()];
    for (int i = 0; i < dataValues.size(); i++) {
      values[i] = dataValues.get(i);
    }

    String[] labels = new String[arrayNames.size()];
    for (int i = 0; i < arrayNames.size(); i++) {
      labels[i] = arrayNames.get(i);
    }
    
    barChart.setData(values);
    barChart.setMinValue(0);
    barChart.setMaxValue(Collections.max(dataValues)); 
    barChart.setBarLabels(labels);
    barChart.setBarColour(applet.color(0, 71, 171));
    barChart.setBarGap(4);
    barChart.transposeAxes(true);
    barChart.showValueAxis(true);
    barChart.setValueFormat("#");
    barChart.showCategoryAxis(true);
  }

  // Sets up a line chart with the data provided, defining its style and axis labels. - Abdul
  private void setupLineChart() {

    float[] xValues = new float[arrayNames.size()];
    for (int i = 0; i < arrayNames.size(); i++) {
      xValues[i] = i + 1;
    }
    float[] yValues = new float[dataValues.size()];
    for (int i = 0; i < dataValues.size(); i++) {
      yValues[i] = dataValues.get(i);
    }
    lineChart.setData(xValues, yValues);
    lineChart.showXAxis(true);
    lineChart.showYAxis(true);
    lineChart.setMinY(0);
    lineChart.setYFormat("###");
    lineChart.setXFormat("0");
    lineChart.setPointColour(applet.color(0, 71, 171));
    lineChart.setPointSize(10);
    lineChart.setLineWidth(2);
    lineChart.setXAxisLabel("\nAirports:");
    lineChart.setYAxisLabel("Number of Flights\n");
  }
  //Draws a pie chart representing the data chosen by the user.-Patrick
    void drawPieChart(int x, int y, int w, int h) {
    float lastAngle = 0;
    float total = 0;

 
    for (Integer value : dataValues) {
        total += value;
    }

   
    for (int i = 0; i < dataValues.size(); i++) {
        float value = dataValues.get(i);
        float angle = TWO_PI * (value / total);
        applet.fill(map(i, 0, dataValues.size(), 100, 255)); 
        applet.arc(x + w / 2, y + h / 2, w, h, lastAngle, lastAngle + angle);
        lastAngle += angle;
    }
}

 // Draws the selected chart type on the screen, displaying additional chart information. - Abdul
 void draw(int x, int y, int w, int h) {
    fill(255);
    // Simplified the text display
    String chartInfo = String.format("This is a %s chart of the %s flights of %s",
                        chartType.toLowerCase(),
                        GraphScreen.dropdown1.getSelectedOption().toLowerCase(),
                        returnArrayPrints());
    text(chartInfo, 110, 260);
    
    // Draw chart and arrows based on the chart - Abdul
    switch (chartType) {
        case "Bar":
            barChart.draw(x, y, w, h);
            break;
        case "Line":
            lineChart.draw(x, y, w, h);
            break;
        case "Scatter":
            scatterplot.draw(x, y, w, h);
            break;
        case "Pie":
             drawPieChart(x, y, w, h);
             break;
    }
      rightArrow.draw();
    leftArrow.draw();
}

// Returns a formatted string of the array names to be used in displaying chart information. - Ayush
  public String returnArrayPrints(){
    String arrayString = "";
    for(String name: arrayNames){
      arrayString += name + ", ";
    }
    return arrayString.substring(0, arrayString.length() - 2);
  }
}
