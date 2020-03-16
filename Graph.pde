class Graph {  // object class to graph each property

  String address;
  float oldPrice;
  float newPrice;
  String date;
  // using XYChart from giCentre library to draw line graph for each property; (taken help from online giCentre graph example)
  XYChart lineChart;

  Graph(String address, String oldPrice, String newPrice, String date, PApplet parent) {
    this.address = address;
    this.oldPrice = parseFloat(oldPrice);
    this.newPrice = parseFloat(newPrice);
    this.date = date;
    lineChart = new XYChart(parent);
  }
  
  // graphs:
  
  void drawLineGraph() {
    lineChart.setData(new float[] {2017, 2018}, 
      new float[] {this.oldPrice, this.newPrice});                   /* 
                                                                     data scalled as discussed with Kerstin 
                                                                     Ruhland (UGPC staff member)
                                                                     */
    lineChart.showXAxis(true);
    lineChart.showYAxis(true);
    lineChart.setMinY(0);
    lineChart.setMinX(2014);
    lineChart.setMaxX(2019);
    lineChart.setXAxisLabel(this.date.substring(0, 6) + "YEAR");
    lineChart.setYAxisLabel("PRICE");
    lineChart.setXFormat("0000");
    lineChart.setYFormat("€#,###,###");
    lineChart.setPointColour(255);
    lineChart.setPointSize(10);
    lineChart.setLineWidth(5);
    textSize(50);
    lineChart.draw(500, 200, width-1000, height-400);
    //fill(255);
    //rect(1000,200,width-2000,height-1500);
    //text(oldPrice, 800,1000);
  }
  
}
