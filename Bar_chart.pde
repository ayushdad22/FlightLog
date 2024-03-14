import org.gicentre.utils.spatial.*;
import org.gicentre.utils.network.*;
import org.gicentre.utils.network.traer.physics.*;
import org.gicentre.utils.geom.*;
import org.gicentre.utils.move.*;
import org.gicentre.utils.stat.*;
import org.gicentre.utils.gui.*;
import org.gicentre.utils.colour.*;
import org.gicentre.utils.text.*;
import org.gicentre.utils.*;
import org.gicentre.utils.network.traer.animation.*;
import org.gicentre.utils.io.*;

BarChart barChart;
XYChart lineChart;
//XYChart scatterplot;

void setup()
{
  size(1000,750);
  
  barChart = new BarChart(this);
  barChart.setData(new float[] {0.76, 0.24, 0.39, 0.18, 0.20});
     
  // Scaling
  barChart.setMinValue(0);
  barChart.setMaxValue(1);
   
  // Axis appearance
  textFont(createFont("Serif",10),10);
   
  barChart.showValueAxis(true);
  barChart.setValueFormat("#%");
  barChart.setBarLabels(new String[] {"Cynthia","Daniel","Eli",
                                       "Fasil","Gertrude"});
  barChart.showCategoryAxis(true);
 
  // Bar colours and appearance
  barChart.setBarColour(color(200,80,80,150));
  barChart.setBarGap(4);
   
  // Bar layout
  barChart.transposeAxes(true);
  
  
  
  
  
  
  
  textFont(createFont("Arial",10),10);
 
  // Both x and y data set here.  
  lineChart = new XYChart(this);
  lineChart.setData(new float[] {1900, 1910, 1920, 1930, 1940, 1950,
                                  1960, 1970, 1980, 1990, 2000},
                    new float[] { 6322,  6489,  6401, 7657, 9649, 9767,
                                  12167, 15154, 18200, 23124, 28645});
   
  // Axis formatting and labels.
  lineChart.showXAxis(true); 
  lineChart.showYAxis(true); 
  lineChart.setMinY(0);
     
  lineChart.setYFormat("$###,###");  // Monetary value in $US
  lineChart.setXFormat("0000");      // Year
   
  // Symbol colours
  lineChart.setPointColour(color(180,50,50,100));
  lineChart.setPointSize(5);
  lineChart.setLineWidth(2);
  
  
  
  
  
  
  
  //size(500,250);   
  //textFont(createFont("Arial",11),11);
 
  // Both x and y data set here.  
  //scatterplot = new XYChart(this);
  
  //// Load in data from a file 
  //// (first line of file contains column headings).
  //String[] data = loadStrings("ukIncomeAndLifeExp.csv");
  //float[] income  = new float[data.length-1];
  //float[] lifeExp = new float[data.length-1];
      
  //for (int i=0; i<data.length-1; i++)
  //{
  //  String[] tokens = data[i+1].split(",");
  //  income[i]  = Float.parseFloat(tokens[1]);   
  //  lifeExp[i] = Float.parseFloat(tokens[2]); 
  //}
  //scatterplot.setData(income,lifeExp);
  
  //// Axis formatting and labels.
  //scatterplot.showXAxis(true); 
  //scatterplot.showYAxis(true); 
  //scatterplot.setXFormat("$###,###");
  //scatterplot.setXAxisLabel("\nAverage income per person "+  
  //                          "(inflation adjusted $US)");
  //scatterplot.setYAxisLabel("Life expectancy at birth (years)\n");
 
  //// Symbol styles
  //scatterplot.setPointColour(color(180,50,50,100));
  //scatterplot.setPointSize(5);
}

void draw()
{
  background(255);
  barChart.draw(50, 50, width - 600, height - 600);
  
  
  
 
  textSize(9);
  lineChart.draw(350,400,width-400,height-400);
   
  // Draw a title over the top of the chart.
  fill(120);
  textSize(20);
  text("Income per person, United Kingdom", 70,30);
  textSize(11);
  text("Gross domestic product measured in inflation-corrected $US", 
        70,45);
        
        
   
        //scatterplot.draw(20,20,width-40,height-40);
} 
