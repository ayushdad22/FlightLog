import java.util.ArrayList;
import java.util.Collections;

class LineChartApp
{
  PApplet applet;
  XYChart lineChart;
  ArrayList<String> arrayNames;
  ArrayList<Integer> dataValues;
  String chartType;


  LineChartApp(PApplet applet, ArrayList<String> arrayNames, ArrayList<Integer> dataValues, String chartType)
  {
    this.applet = applet;
    this.lineChart = new XYChart(applet);
    this.arrayNames = arrayNames;
    this.dataValues = dataValues;
    this.chartType = chartType;
    setupLineChart();
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
    lineChart.setYFormat("###,###");
    lineChart.setXFormat("0");
    lineChart.setPointColour(applet.color(180, 50, 50, 100));
    lineChart.setPointSize(5);
    lineChart.setLineWidth(2);
  }


  void draw(int x, int y, int w, int h) {
    switch (chartType) {
    case "Bar":
      lineChart.draw(x, y, w, h);
      break;
    }
  }

  //void draw(int x, int y, int w, int h)
  //{
  //  lineChart.draw(x, y, w, h);
  //}
}
