import java.util.ArrayList;
import java.util.Collections;

class Chart {
  ArrayList<String> arrayNames;
  ArrayList<Integer> dataValues;
  String chartType;

  Chart(ArrayList<String> arrayNames, ArrayList<Integer> dataValues, String chartType) {
    this.arrayNames = arrayNames;
    this.dataValues = dataValues;
    this.chartType = chartType;
  }

  void draw() {
    switch (chartType) {
      case "Bar":
        drawBarChart();
        break;
    }
    //case "Line":
    
  }

  void drawBarChart() {
    noStroke();
    textSize(20);
    float barWidth = (float) width / arrayNames.size();

    // Find the maximum value in dataValues list
    int maxVal = Collections.max(dataValues);

    for (int i = 0; i < arrayNames.size(); i++) {
      float x = i * barWidth ;
      float y = map(dataValues.get(i), 0, maxVal, height, 0);
      float barHeight = height - y;

      fill(0, 0, 255);
      rect(x, y, barWidth, barHeight);

      fill(0);
      textAlign(CENTER, CENTER);
      text(dataValues.get(i), x + barWidth / 2, height - 40);
      text(arrayNames.get(i), x + barWidth / 2, height - 10);
    }
  }
}
