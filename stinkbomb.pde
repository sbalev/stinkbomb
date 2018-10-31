Game game;
boolean intro = true;
Crane introCrane;
Button playButton;

void setup() {
  size(1600, 900);
  game = new Game();
  introCrane = new Crane(width / 2, 110, 80, 20, 0, TWO_PI / 240, color(255));
  playButton = new Button(width / 2, height - 100, 250, 120, "PLAY");
}

void draw() {
  if (intro) {
    displayIntro();
  } else if (game.isOver()) {
    displayGameOver();
  } else {
    game.display();
    game.step();
  }
}

void mousePressed() {
  if (playButton.isInside(mouseX, mouseY)) {
    if (intro) {
      intro = false;
    } else if (game.isOver()) {
      game = new Game();
    }
  }
}

void displayIntro() {
  background(0);
  introCrane.display();
  introCrane.turn();
  String text = "Villains attack!\n" +
    "The only defence weapon you have is a wrecking ball.\n" +
    "Kick away their stink bombs ASAP.\n" +
    "Keep an eye on the air quality gauge!\n" +
    "Use the mouse to move the crane.\n" +
    "Ready?";
  fill(255);
  textSize(36);
  textAlign(CENTER, CENTER);
  text(text, width / 2, height / 2);
  playButton.display();
}

void displayGameOver() {
  game.display();
  noStroke();
  fill(0, 192);
  rectMode(CORNER);
  rect(0, 0, width, height);
  String text = "GAME OVER\n" +
    "Your score: " + game.score + "\n" +
    "Want to try again?";
  fill(255);
  textSize(36);
  textAlign(CENTER, CENTER);
  text(text, width / 2, height / 2);
  playButton.display();
}
