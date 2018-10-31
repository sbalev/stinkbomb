// universal constants
final float GRAVITY = 0.05;
final float BOMB_PROBABILITY = 0.005;
final float BOMB_PROBABILITY_INCREMENT = 0.002; // for every 100 points scored
final float BOMB_POLLUTION = 0.0001;
final float POLLUTION_DISSIPATION = 0.0001;

Crane crane;
ArrayList<Bomb> bombs;
float airQuality;
int score;

void setup() {
  size(1600, 900);
  crane = new Crane();
  bombs = new ArrayList<Bomb>();
  airQuality = 1;
  score = 0;
}

void draw() {
  background(255);

  display();
  hit();
  move();
  deleteOutside();
  addBomb();
  updateAirQuality();
}

void display() {
  crane.display();
  for (Bomb bomb : bombs) bomb.display();
  noStroke();
  fill(lerpColor(color(255, 0, 0), color(0, 255, 0), airQuality));
  rect(0, 0, map(airQuality, 0, 1, 0, width), 10);
  fill(0);
  textAlign(TOP, LEFT);
  text("Score " + score, 0, 20);
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
    Bomb bomb = bombs.get(i);
    if (bomb.isOutside()) {
      bombs.remove(i);
      if (bomb.toxic) {
        score++;
      } else {
        score += 2;
      }
    }
  }
}

void addBomb() {
  if (random(1) < BOMB_PROBABILITY + (score / 100) * BOMB_PROBABILITY_INCREMENT) {
    bombs.add(new Bomb());
  }
}

void updateAirQuality() {
  for (Bomb bomb : bombs) {
    if (bomb.toxic) {
      airQuality -= BOMB_POLLUTION;
    }
  }
  airQuality += POLLUTION_DISSIPATION;
  airQuality = constrain(airQuality, 0, 1);
  if (airQuality == 0) {
    println("Game over");
    noLoop();
  }
}
