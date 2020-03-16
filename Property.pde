class Property {  // object class to make a new page which displays 
  // the statistics related to each property, when clicked on
  String address;
  String oldPrice;
  String newPrice;
  String date;
  Graph graph;
  Button back;

  Property(String address, String oldPrice, String newPrice, String date, Graph graph) {
    this.address = address;
    this.oldPrice = oldPrice;
    this.newPrice = newPrice;
    this.date = date;
    this.graph = graph;
    back = new Button(25, 25, 130, 100, 0, 0, 0, true, "<<");
  }

  // to display the property screen when a property is clicked on
  void setNewScreen() {
    fill(0);
    noStroke();
    rect(0, 0, width, height);
    textSize(65);
    fill(255);
    text(address, 200, 80);        // bug, outputs wrong address ;( ( FIXED! :) )
    // back button
    back.update();
    back.display();
    textAlign(LEFT);
  }

  void drawPropertyGraph() {
    graph.drawLineGraph();
  }

  // back button to main screen clicked?
  boolean backClicked() {
    if (back.isClicked()) 
      return true;
    else return false;
  }
}
