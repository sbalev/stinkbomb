Game game;
boolean intro = true;
boolean pause = false;
Crane introCrane;
Button playButton;
Timer timer;

void setup() {
  size(1600, 900);
  game = new Game();
  introCrane = new Crane(width / 2, 110, 80, 20, 0, TWO_PI / 240, color(255));
  playButton = new Button(width / 2, height - 100, 250, 120, "PLAY");
  timer = new Timer();
}

void draw() {
  if (intro) {
    displayIntro();
  } else if (game.isOver()) {
    timer.pause();
    displayGameOver();
  } else if (pause) {
    timer.pause();
    displayPause();
  } else {
    timer.start();
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
      timer.reset();
    }
  }
}

void keyPressed() {
  if (key == ' ' && !intro && !game.isOver()) {
    pause = !pause;
  }
}

void displayIntro() {
  background(0);
  introCrane.display();
  introCrane.turn();
  String text = "Villains attack!\n" +
    "The only defense weapon you have is a wrecking ball.\n" +
    "Kick away their stink bombs ASAP.\n" +
    "Keep an eye on the air quality gauge!\n" +
    "Use the mouse to move the crane. Press SPACE to pause/resume.\n" +
    "Ready?";
  displayBigText(text);
  playButton.display();
}

void displayGameOver() {
  game.display();
  noStroke();
  fill(0, 192);
  rectMode(CORNER);
  rect(0, 0, width, height);
  String text = "GAME OVER\n" +
    "You resisted villains during " + timer.getMinutesSeconds() + "\n" +
    "You neutralized " + game.getKickedBombs() + " bombs\n" +
    "You scored " + game.getScore() + " points\n" +
    "Want to try again?";
  displayBigText(text);
  playButton.display();
}

void displayPause() {
  game.display();
  noStroke();
  fill(0, 192);
  rectMode(CORNER);
  rect(0, 0, width, height);
  String text = "GAME PAUSED\n" +
    "Press SPACE to resume.";
  displayBigText(text);
}

void displayBigText(String text) {
  fill(255);
  textSize(36);
  textAlign(CENTER, CENTER);
  text(text, width / 2, height / 2);
}
