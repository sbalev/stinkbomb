Game game;
boolean intro;

void setup() {
  size(1600, 900);
  game = new Game();
}

void draw() {
  game.step();
  if (game.isOver()) {
    fill(255, 0, 0, 64);
    textSize(72);
    textAlign(CENTER, CENTER);
    text("GAME OVER", width / 2, height / 2);
    noLoop();
  }
}
