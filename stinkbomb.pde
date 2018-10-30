Crane crane;

void setup() {
  size(1600, 900);
  crane = new Crane();
}

void draw() {
  background(255);
  crane.display();
  crane.move();
  crane.turn();
}
