import java.util.ArrayList;
import java.util.Collections;
import java.util.concurrent.*;
import processing.core.PApplet;

class Chart {
  PApplet applet;
  BarChart barChart;
  XYChart scatterplot;
  XYChart lineChart;
  ArrayList<String> arrayNames;
  ArrayList<Integer> dataValues;
  String chartType;

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
    scatterplot.setPointColour(applet.color(180, 50, 50, 100));
    scatterplot.setPointSize(5);
  }

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
    barChart.setMaxValue(Collections.max(dataValues)); // Setting max value dynamically
    barChart.setBarLabels(labels);
    barChart.setBarColour(applet.color(0, 71, 171));
    barChart.setBarGap(4);
    barChart.transposeAxes(true);
    barChart.showValueAxis(true);
    barChart.setValueFormat("#");
    barChart.showCategoryAxis(true);
  }

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
    lineChart.setPointColour(applet.color(180, 50, 50, 100));
    lineChart.setPointSize(5);
    lineChart.setLineWidth(2);
    lineChart.setXAxisLabel("\nAirports:");
    lineChart.setYAxisLabel("Number of Flights\n");
  }


  void draw(int x, int y, int w, int h) {
    switch (chartType) {
    case "Bar":
      barChart.draw(x, y, w, h);
      break;
    case "Line":
      lineChart.draw(x, y, w, h);
      break;
    case "Scatter":
      scatterplot.draw(x, y, w, h);
    }
  }
}
