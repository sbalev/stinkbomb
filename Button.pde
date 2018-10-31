class Button {
  int x, y, w, h;
  String text;
  
  Button(int x, int y, int w, int h, String text) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.text = text;
  }
  
  void display() {
    noStroke();
    fill(255, 0, 0);
    rectMode(CENTER);
    rect(x, y, w, h, 20);
    fill(255);
    textSize(72);
    textAlign(CENTER, CENTER);
    text(text, x, y - 12);
  }
  
  boolean isInside(int mx, int my) {
    return x - w / 2 < mx && mx < x + w / 2 && y - h / 2 < my && my < y + h / 2; 
  }
}
