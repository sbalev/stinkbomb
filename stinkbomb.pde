Crane crane;

void setup() {
  size(400, 400);
  crane = new Crane();
}

void draw() {
  background(255);
  crane.display();
  crane.turn();
}
