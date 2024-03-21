import java.util.ArrayList;
import java.util.Collections;

class BarChartApp {
    PApplet applet;
    BarChart barChart;
    ArrayList<String> arrayNames;
    ArrayList<Integer> dataValues;
    String chartType;

    BarChartApp(PApplet applet, ArrayList<String> arrayNames, ArrayList<Integer> dataValues, String chartType) {
        this.applet = applet;
        this.arrayNames = arrayNames;
        this.dataValues = dataValues;
        this.chartType = chartType;
        this.barChart = new BarChart(applet); // Initialize barChart object
        setupBarChart();
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
        barChart.setBarColour(applet.color(200, 80, 80, 150));
        barChart.setBarGap(4);
        barChart.transposeAxes(true);
        barChart.showValueAxis(true);
        barChart.setValueFormat("#");
        barChart.showCategoryAxis(true);
    }

    void draw(int x, int y, int w, int h) {
        switch (chartType) {
            case "Bar":
                barChart.draw(x, y, w, h);
                break;
        }
    }
}
