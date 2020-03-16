/*
 this class will draw a third screen on which a bar chart with the top ten properties
 which have the greatest property price drops will be represented
 */

class TopTen {

  Table data;
  //String address;
  //float oldPrice;
  //float newPrice;
  // using ArrayList to store each price drop
  float[] priceChanges = new float[1000];
  // using BarChart from giCentre library to draw bar graph for top ten greatest price drops; (taken help from online giCentre graph example)
  BarChart barChart;
  Button back;

  TopTen(Table data, PApplet parent) {    //, String address, String oldPrice, String newPrice
    this.data = data;
    //this.address = address;
    //this.oldPrice = parseFloat(oldPrice);
    //this.newPrice = parseFloat(newPrice);
    barChart = new BarChart(parent);
    back = new Button(25, 25, 130, 100, 0, 0, 0, true, "<<");
  }

  // to display a new screen for top ten properties
  void setNewScreen() {
    fill(0);
    noStroke();
    rect(0, 0, width, height);
    textSize(65);
    fill(255);
    text("Top 10 properties with the greatest price drops", 200, 80);
    // back button
    back.update();
    back.display();
    textAlign(LEFT);
  }

  void drawGraph() {
    for (int row = 0; row < 1000; row++)
      // calculating each price drop and storing in an array of floats
      priceChanges[row] = parseFloat(data.getRow(row).getString(2).replace("\"", "").replace(",", "")) - parseFloat(data.getRow(row).getString(3));
    // copy of non-sorted price drops array to compare with sorted price drops array and organize addresses accordingly in another array of strings
    float[] copy = new float[1000];
    for (int i=0; i<1000; i++) {
      copy[i] = priceChanges[i];
    }
    String[] addresses = new String[10];
    Arrays.sort(priceChanges);
    // to reverse order of array from ascending to descending
    for (int i=0; i<priceChanges.length/2; i++) {
      float temp = priceChanges[i];
      priceChanges[i] = priceChanges[priceChanges.length-1-i];
      priceChanges[priceChanges.length-1-i] = temp;
    }
    // to order the top ten addresses
    for (int i=0; i<10; i++) {
      boolean matched = false;
      for (int r=0; r<1000 && !matched; r++) {
        if (priceChanges[i] == copy[r]) {
          addresses[i] = data.getRow(r).getString(0).replace("\"", "");
          matched = true;
        } else addresses[i] = null;
      }
    }
    //text(addresses[0] + " = " + priceChanges[0], 100, 500);
    //text(addresses[1] + " = " + priceChanges[1], 100, 600);
    //text(addresses[2] + " = " + priceChanges[2], 100, 700);    for experimental purposes :)
    //text(addresses[3] + " = " + priceChanges[3], 100, 800);
    //text(addresses[4] + " = " + priceChanges[4], 100, 900);

    // a bar chart with the first ten elements of the above array will be drawn

    //println(priceChanges[0]+" "+priceChanges[1]+" "+priceChanges[2]+" "+priceChanges[3]+" "+priceChanges[4]+" "+priceChanges[5]+" "+priceChanges[6]+" "+priceChanges[7]+" "+priceChanges[8]+" "+priceChanges[9]);

    barChart.setData(new float[] {priceChanges[0], priceChanges[1], priceChanges[2], priceChanges[3], priceChanges[4], 
      priceChanges[5], priceChanges[6], priceChanges[7], priceChanges[8], priceChanges[9]});
    // P1, P2,... will be used to label the integrals in the x-axis of bar chart to save space (P1 = Property 1)
    barChart.setBarLabels(new String[] {"P1", "P2", "P3", "P4", "P5", "P6", "P7", "P8", "P9", "P10"});

    barChart.setMinValue(0);

    barChart.showValueAxis(true);    
    barChart.showCategoryAxis(true);
    barChart.setValueAxisLabel("PRICE DROPS (OLD PRICE - NEW PRICE)");
    barChart.setCategoryAxisLabel("P (PROPERTY)");
    barChart.setValueFormat("€##,###");
    textSize(50);
    barChart.draw(200, 200, width-1500, height-400);
    // to display meaning of x-axis interval labels
    int y = 300;
    for (int i=0; i<10; i++) {
      fill(255);
      textSize(40);
      text("P" + (i+1) + " = " + addresses[i], 1600, y);
      y+=60;
    }
  }

  // back button to main screen clicked?
  boolean backClicked() {
    if (back.isClicked()) 
      return true;
    else return false;
  }
}
