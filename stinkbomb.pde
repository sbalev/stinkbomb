Crane crane;
Bomb bomb;

void setup() {
  size(1600, 900);
  crane = new Crane();
  bomb = new Bomb();
}

void draw() {
  background(255);

  crane.display();
  bomb.display();
  
  crane.hit(bomb);
  
  crane.move();
  crane.turn();
  bomb.move();
}
