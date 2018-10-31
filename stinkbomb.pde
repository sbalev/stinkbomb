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
  } else {
    game.display();
    game.step();
    if (game.isOver()) {
      fill(255, 0, 0, 64);
      textSize(72);
      textAlign(CENTER, CENTER);
      text("GAME OVER", width / 2, height / 2);
      noLoop();
    }
  }
}

void mousePressed() {
  if (intro && playButton.isInside(mouseX, mouseY)) {
    intro = false;
  }
}

void displayIntro() {
  background(0);
  introCrane.display();
  introCrane.turn();
  textSize(36);
  String text = "Villains attack!\n" +
    "The only defence weapon you have is a wrecking ball.\n" +
    "Kick away their stink bombs ASAP.\n" +
    "Keep an eye on the air quality gauge!\n" +
    "Use the mouse to move the crane.\n" +
    "Ready?";
  fill(255);
  textAlign(CENTER, CENTER);
  text(text, width / 2, height / 2);
  playButton.display();
}
