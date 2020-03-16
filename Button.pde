class Button { // universal button class (taken help from youtube video)
  float x;
  float y;
  float Width;
  float Height;
  float red;
  float green;
  float blue;
  boolean fill;
  String text;
  boolean clicked = false;
  boolean pressed = false;

  Button(int x, int y, int w, int h, int r, int g, int b, boolean f, String t) {
    this.x = x;
    this.y = y;
    Width = w;
    Height = h;
    red = r;
    green = g;
    blue = b;
    fill = f;
    text = t;
  }

  // clicking function
  void update() {
    if (mouseButton == LEFT && mousePressed && !pressed) {
      pressed = true;
      if (mouseX > x && mouseX < x + Width && mouseY > y && mouseY < y + Height)
        clicked = true;
    } else clicked = false;

    if (!mousePressed)
      pressed = false;
  }

  // how the button will look
  void display() {
    noStroke();
    if (fill)
      fill(red, green, blue);
    else noFill();
    rect(x, y, Width, Height);
    if (text != "") {
      textAlign(CENTER);
      if ((red*0.299 + green*0.587 + blue*0.114) > 186)
        fill(0);
      else fill(255);
      text(text, x + (Width/2), y + (Height/2));
    }
    if (mouseX > x && mouseX < x + Width && mouseY > y && mouseY < y + Height) {
      noFill();
      strokeWeight(5);
      if ((red*0.299 + green*0.587 + blue*0.114) > 186)
        stroke(0);
      else stroke(255);
      rect(x, y, Width, Height);
    } else noStroke();
  }

  // to check if button has been clicked
  boolean isClicked() {
    return clicked;
  }
}
