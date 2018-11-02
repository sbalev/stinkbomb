final float BOMB_PROBABILITY = 0.005;
final float BOMB_PROBABILITY_INCREMENT = 0.001; // per level
final float BOMB_POLLUTION = 0.0001;
final float POLLUTION_DISSIPATION = 0.0001;
final int BOMBS_PER_LEVEL = 100;

class Game {
  Crane crane;
  ArrayList<Bomb> bombs;
  float airQuality;
  int score;
  int level;
  int bombsLeft; // to change level

  Game() {
    crane = new Crane();
    bombs = new ArrayList<Bomb>();
    airQuality = 1;
    score = 0;
    level = 0;
    bombsLeft = BOMBS_PER_LEVEL;
  }

  void step() {
    hit();
    move();
    deleteOutside();
    addBomb();
    updateAirQuality();
  }

  boolean isOver() {
    return airQuality == 0;
  }

  void display() {
    background(255);
    crane.display();
    for (Bomb bomb : bombs) bomb.display();
    noStroke();
    fill(lerpColor(color(255, 0, 0), color(0, 255, 0), airQuality));
    rectMode(CORNER);
    rect(0, 0, map(airQuality, 0, 1, 0, width), 10);
    fill(0);
    textSize(18);
    textAlign(TOP, LEFT);
    text("Score " + score + "     Level " + level, 0, 24);
  }
  
  int getScore() {
    return score;
  }
  
  int getKickedBombs() {
    return (level + 1) * BOMBS_PER_LEVEL - bombsLeft;
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
        score++;
        bombsLeft--;
        if (bombsLeft == 0) {
          level++;
          bombsLeft = BOMBS_PER_LEVEL;
          crane.changeDir();
        }
        if (!bomb.toxic) score++;
      }
    }
  }

  void addBomb() {
    if (random(1) < BOMB_PROBABILITY + level * BOMB_PROBABILITY_INCREMENT) {
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
  }
}
