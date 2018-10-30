final float BOMB_PROBABILITY = 0.005;

Crane crane;
ArrayList<Bomb> bombs;

void setup() {
  size(1600, 900);
  crane = new Crane();
  bombs = new ArrayList<Bomb>();
}

void draw() {
  background(255);

  display();
  hit();
  move();
  deleteOutside();
  addBomb();
}

void display() {
  crane.display();
  for (Bomb bomb : bombs) bomb.display();
}

void hit() {
  for (Bomb bomb : bombs) crane.hit(bomb);
}

void move() {
  crane.move();
  crane.turn();
  for (Bomb bomb : bombs) bomb.move();
}

void deleteOutside() {
  for (int i = bombs.size() - 1; i >= 0; i--) {
    if (bombs.get(i).isOutside()) {
      bombs.remove(i);
    }
  }
}

void addBomb() {
  if (random(1) < BOMB_PROBABILITY) {
    bombs.add(new Bomb());
  }
}
