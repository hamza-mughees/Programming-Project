// ctrl + t for format

import org.gicentre.utils.stat.*;
import java.util.*;

String logo = "PropertyHunt";
TableRow row;                                // to store each row from the imported tabular data
Table data;                                  // to store data
String element;                              // to store each element of the data
Button selection;                            // button for each property to load its statistics  (FIRST QUERY)
Button recent;                               // to load the recent changes (last 24 rows of the data)  (SECOND QUERY)
Button randomise;                            // random set of 24 ordered properties displayed everytime this button is clicked  (THIRD QUERY)
Button topTen;                               // loads the top ten highest price changes screen
Graph propertyGraph;                         // to graph each property
Property property;                           // selection buttons lead to property screen when clicked
TopTen topTenChanges;                        // top 10 properties with highest change in price;
boolean mainScreen = true;
boolean addressScreen = false;
boolean recentChanges = false;
boolean topTenScreen = false;
int rowNumber;
int count = 0;

void setup() {
  size(3000, 2000);
  data = loadTable("prices.tsv");  // import data
  rowNumber = (int)random(976);    // to load 24 random properties from the 1000 in the file
  topTenChanges = new TopTen(data, this);
}

void draw() {
  // initial setup
  background(0);
  textFont(createFont("Georgia", 100));
  // print logo
  fill(255);
  text(logo, 45, 125);
  stroke(255);
  strokeWeight(5);
  line(45, 145, 190, 145);
  line(240, 145, 370, 145);
  line(410, 145, 670, 145);
  line(45, 160, 670, 160);

  // randomise button
  textFont(createFont("Georgia", 40));
  randomise = new Button(1600, 25, 230, 80, 0, 0, 0, false, "Randomise");
  randomise.update();
  randomise.display();
  textAlign(LEFT);

  // recent changes button
  textFont(createFont("Georgia", 40));
  recent = new Button(2000, 25, 150, 80, 0, 0, 0, false, "Recent");
  recent.update();
  recent.display();
  textAlign(LEFT);

  // top ten price drops button
  textFont(createFont("Georgia", 40));
  topTen = new Button(2300, 25, 450, 80, 0, 0, 0, false, "Top ten price drops");
  topTen.update();
  topTen.display();
  textAlign(LEFT);

  if (recent.isClicked())
    recentChanges = true;

  // randomises the addresses when clicked to display different houses each time
  if (randomise.isClicked()) {
    if (count == 0) {
      rowNumber = (int)random(975);
      count++;
    }
    recentChanges = false;
  }

  if (!randomise.isClicked())
    count = 0;

  if (topTen.isClicked() && mainScreen) {
    mainScreen = false;
    topTenScreen = true;
  }

  // print data headings
  textFont(createFont("Georgia bold", 20));
  text("  Address:", 45, 210);
  text("County:", 1515, 210);
  text("  Old Price:", 1915, 210);
  text("New Price:", 2315, 210);
  text("Date:", 2715, 210);
  strokeWeight(2);
  stroke(255);
  line(0, 230, width, 230);

  // print data and buttons;
  //if (recentChanges)
  //  fill(255);
  //else
  //  fill(0);
  //ellipse(770, 152, 20, 20);

  fill(255);
  textFont(createFont("Georgia", 40));
  int x = 45;
  int y = 280;

  // to load recent 24 rows and fill an ellipse which indicates that user is currently viewing recent price changes
  if (recentChanges) {
    fill(255);
    rowNumber = 976;
  } else fill(0);
  ellipse(1970, 52, 20, 20);
  fill(255);

  for (int r=rowNumber; r<(rowNumber+24); r++) {
    if (mainScreen)
      row = data.getRow(r);
    for (int c=0; c<5; c++) {
      element = row.getString(c);
      element = element.replace("\"", "");
      if (c==2)
        element = element.replace(",", "");
      if (c==2 || c==3)
        element = "€" + element;
      text(element, x, y);
      if (c==0) {
        selection = new Button(0, y-50, width, 70, 0, 0, 0, false, "");
        selection.update();
        selection.display();
        x += 1470;
      } else x += 400;

      if (selection.isClicked() && mainScreen) {
        mainScreen = false;
        addressScreen = true;
      }

      if (!mainScreen && addressScreen) {
        //graphs called here
        // make a new object class in which parameters r address,initial value,current value
        // and displays the price changes of a property over time and etc.
        propertyGraph = new Graph(row.getString(0).replace("\"", ""), row.getString(2).replace("\"", "").replace(",", ""), row.getString(3), row.getString(4), this);
        property = new Property(row.getString(0).replace("\"", ""), row.getString(2), row.getString(3), row.getString(4), propertyGraph);
        property.setNewScreen();
        property.drawPropertyGraph();
        if (property.backClicked()) {
          mainScreen = true;
          addressScreen = false;
        }
      }

      if (!mainScreen && topTenScreen) {
        topTenChanges.setNewScreen();
        topTenChanges.drawGraph();
        if (topTenChanges.backClicked()) {
          mainScreen = true;
          topTenScreen = false;
        }
      }
    }
    x = 45;
    y += 70;
  }
}
